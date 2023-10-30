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
  val rd_en = RegInit(false.B)
  val wr_en = RegInit(false.B)
  val width = data.getWidth.asUInt

  io.read.valid := false.B
  io.read.bits := 0.U
  io.write.ready := false.B

  for( i <- 0 until depth ) {
    mem.write( i.asUInt , 0.U.asTypeOf(data) )
  }

/* rd_ptr */
  withClockAndReset ( io.clk_r , io.rst_r ) {
    when (io.rst_r === true.B) {
      rd_ptr := 0.U
    }

    when( (rd_ptr < wr_ptr) && (rd_empty ===false.B) && (rd_en === true.B)) {
      rd_ptr := rd_ptr +1.U 
    } .otherwise {
      rd_ptr := rd_ptr
    }

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
/* write_ptr */
  withClockAndReset ( io.clk_w , io.rst_w ) {
    when((wr_ptr < width-1.U) && (wr_full =/= false.B) && (wr_en === true.B)){
      wr_ptr := wr_ptr+1.U
    } .otherwise{
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

/* wr logic*/
  withClock( io.clk_w ) {
    val DataConverter = Module(new BinToGray( io.write.bits.getWidth , data ))
    DataConverter.io.bin := io.write.bits
    when((wr_en === true.B) && (wr_full =/= true.B)  ){
      mem.write( wr_ptr , DataConverter.io.gray , io.clk_w ) 
    } .otherwise {
      wr_ptr := wr_ptr
    }
  }
/* rd logic*/
  withClock( io.clk_r ){
    val DataConverter = Module(new GrayToBin( io.read.bits.getWidth , data))
    DataConverter.io.gray := io.read.bits
    when ((rd_en === true.B) && (rd_empty =/= true.B)){
      io.read.bits := mem.read(rd_ptr,io.clk_r)
    } .otherwise {
      io.read.bits := mem.read((rd_ptr - 1.U),io.clk_r)
    }
  }
}

class BinToGray [T <: Data] (width: Int, gen:T) extends Module {
  val io = IO(new Bundle {
    val bin     = Input(gen)
    val gray    = Output(gen)
  })

    io.gray := io.bin.asUInt ^ (io.bin.asUInt >> 1.U)
}

class GrayToBin [T <: Data] (width: Int, gen:T) extends Module {
  val io = IO(new Bundle {
    val bin     = Output(gen)
    val gray    = Input(gen)
  })
    val binary = Wire(Vec(width,UInt(1.W)))
    binary(width-1) := io.gray.asUInt(width-1)
    for (i <- 2 until (width+1)) {
      binary(width-i) := io.gray.asUInt(width-i) ^ binary(width-i+1) 
    }
    io.bin := binary.asUInt() 
}

object Elaborate extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new fifo(UInt(32.W),8))
}