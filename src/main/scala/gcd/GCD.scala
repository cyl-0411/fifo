package fifo

import chisel3._
import chisel3.util._



class fifo[T <: Data] (data:T,depth:Int) extends Module {
  val io = IO(new Bundle {
    val write        = Flipped(Decoupled(data))
    val rst_w        = Input(Bool())
    val clk_w        = Input(Clock())

    val read         = Decoupled(data)
    val rst_r        = Input(Bool())
    val clk_r        = Input(Clock())
  })

  val ram = Mem(depth,data)
  
  val wr_en = io.write.valid && io.write.ready
  val rd_en = io.read.valid && io.read.ready
  val ptr_width = log2Ceil(depth) + 1
  val rd_ptr = RegInit(0.U(ptr_width.W))
  val wr_ptr = RegInit(0.U(ptr_width.W))

  val rd_empty = rd_ptr === wr_ptr
  val wr_full = (wr_ptr.head(1) =/= rd_ptr.head(1)) && (wr_ptr.tail(1) === rd_ptr.tail(1))
  io.read.valid := !rd_empty
  io.write.ready:= !wr_full

  withClockAndReset( io.clk_r , io.rst_r){
    when(io.rst_r === false.B ){
      rd_ptr := 0.U
      io.read.bits := 0.U
    } .otherwise {
      io.read.bits := Mux(rd_en, ram.read(rd_ptr,io.clk_r),0.U.asTypeOf(data))
      rd_ptr := rd_ptr + 1.U 
    }
      val wr_ptr_1 = RegNext(wr_ptr)
      val wr_ptr_r = RegNext(wr_ptr_1)

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