package fifo

import chisel3._
import chisel3.util._

class fifo[T <: Data] (data:T,depth:Int) extends RawModule {
  val io = IO(new Bundle {
    val write        = Flipped(Decoupled(data))
    val wr_rst        = Input(Bool())
    val wr_clk        = Input(Clock())
    val read         = Decoupled(data)
    val rd_rst        = Input(Bool())
    val rd_clk        = Input(Clock())
  })

  val ram = Mem(depth,data)
  val ptr_width = log2Ceil(depth) + 1
  val wr_ptr = withClockAndReset(io.wr_clk,io.wr_rst) { RegInit(0.U(ptr_width.W))}
  val rd_ptr = withClockAndReset(io.rd_clk,io.rd_rst) { RegInit(0.U(ptr_width.W))}
  val wr_ptr_r = ptr_converter(wr_ptr,io.rd_clk)
  val rd_ptr_w = ptr_converter(rd_ptr,io.wr_clk)
  val rd_bits = withClockAndReset(io.rd_clk,io.rd_rst) {RegInit(0.U(data.getWidth.W))}

  val rd_empty = rd_ptr === wr_ptr_r
  val wr_full = (wr_ptr.head(1) =/= rd_ptr_w.head(1)) && (wr_ptr.tail(1) === rd_ptr_w.tail(1))
  val wr_en = io.write.valid && io.write.ready
  val rd_en = io.read.valid && io.read.ready
  io.read.valid := !rd_empty
  io.write.ready:= !wr_full
  io.read.bits := rd_bits
    when( wr_en === true.B) {
      ram.write(wr_ptr , io.write.bits , io.wr_clk)
      wr_ptr := wr_ptr + 1.U
    } 
    when( rd_en === true.B) {
      // io.read.bits := Mux(rd_en, ram.read(rd_ptr,io.rd_clk),0.U.asTypeOf(data))
      rd_bits := ram.read(rd_ptr,io.rd_clk)
      rd_ptr := rd_ptr + 1.U
    }
}
object ptr_converter {
  def apply(ptr : UInt , clk : Clock) : UInt = {
    withClock(clk){
      val ptr_1 = RegNext(ptr)
      val ptr_2 = RegNext(ptr_1)
      ptr_2 := ptr_1
      ptr_2
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
  val arg = Array("--target-dir","./gen")
  (new chisel3.stage.ChiselStage).emitVerilog(new fifo(UInt(32.W),8) , arg)
}
