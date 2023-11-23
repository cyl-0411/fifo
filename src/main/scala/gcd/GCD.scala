package fifo

import chisel3._
import chisel3.util.Decoupled
import chisel3.util.Queue


class fifo[T <: Data] (data:T,depth:Int) extends Module {
  val io = IO(new Bundle {
    val write        = Flipped(Decoupled(data))
    val rst_w        = Input(Bool())
    val clk_w        = Input(Clock())

    val read         = Decoupled(data)
    val rst_r        = Input(Bool())
    val clk_r        = Input(Clock())
  })

  val mem = Mem(depth,data)
  val rd_ptr = RegInit(0.U)
  val wr_ptr = RegInit(0.U)
  val wr_full = RegInit(false.B)
  val rd_empty = RegInit(true.B)
  
  val rd_en = io.read.ready && io.read.valid
  val wr_en = io.write.ready && io.write.valid 
  val width = data.getWidth.asUInt
  for( i <- 0 until depth ) {
    mem.write( i.asUInt , 0.U.asTypeOf(data) )
  }

/* rd_ptr */
  withClockAndReset ( io.clk_r , io.rst_r ) {
    when (io.rst_r === true.B) {
      rd_ptr := 0.U
    } .otherwise {
//this part is rd_crtl logic and rd_ptr generate
        when ((rd_en === true.B) && (rd_empty =/= true.B)){
          io.read.bits := mem.read(rd_ptr,io.clk_r)
          rd_ptr := rd_ptr + 1.U
      } .otherwise {
        rd_ptr := rd_ptr
      }
//get wr_ptr from wr_clk domains
      val wr_ptr1 = RegNext(wr_ptr)
      val wr_ptr_r = RegNext(wr_ptr1)
      when ((rd_ptr <= wr_ptr_r) && (rd_ptr(width-1.U) === wr_ptr_r(width-1.U))){
        rd_empty := false.B
      } .otherwise {
        rd_empty := true.B
      }
      
      when ((io.read.valid === true.B) && (rd_empty =/= true.B)){
        rd_en := true.B
      } .otherwise {
        rd_en := false.B
      }
    }
  }
/* write_ptr */
  withClockAndReset ( io.clk_w , io.rst_w ) {
//two D-FF to transfer signal from different clock domains

    when((wr_en === true.B) && (wr_full =/= true.B)  ){
      mem.write( wr_ptr , io.write.bits , io.clk_w ) 
      wr_ptr := wr_ptr + 1.U
    } .otherwise {
      wr_ptr := wr_ptr
    }
    val rd_ptr1 = RegNext( wr_ptr )
    val rd_ptr_w = RegNext( rd_ptr1 )
    when((wr_ptr <= rd_ptr_w) && (wr_ptr(width-1.U) === rd_ptr_w(width-1.U)) ) {
      wr_full := true.B
    } .otherwise {
      wr_full := false.B
    }
    when ((wr_full =/= true.B) && (io.write.valid === true.B) ){
      wr_en := true.B
    } .otherwise {
      wr_en := false.B
    }
  }
}

object BinToGray {
  def apply(bin : UInt , width : Int) : UInt = {
    val gray = Wire(UInt(32.W))
    gray := bin ^ (bin >> 1.U)
    gray
  }
}
object GrayToBin {
  def apply(gray : UInt , width : Int):UInt = {
    val binary = Wire(Vec(width,UInt(1.W)))
    binary(width-1) := gray(width-1)
    for (i <- 2 until (width+1)) {
      binary(width-i) := gray(width-i) ^ binary(width-i+1) 
    }
    binary.asUInt
  }
}

object Elaborate extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new fifo(UInt(32.W),8))
}