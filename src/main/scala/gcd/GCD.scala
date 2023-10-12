package fifo

import chisel3._
import chisel3.util.Decoupled
import chisel3.util.Queue


class fifo[T <: Data] (data:T,depth:Int) extends RawModule {
  val io = IO(new Bundle {
    val write        = Flipped(Decoupled(data))
    val rst_w        = Input(Bool())
    val clk_w        = Input(Clock())

    val read         = Decoupled(data)
    val rst_r        = Input(Bool())
    val clk_r        = Input(Clock())
  })

  withClockAndReset ( io.clk_r , io.rst_r ) {

  }

  withClockAndReset ( io.clk_w , io.rst_w ) {
    
  }

}

object Elaborate extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new fifo(UInt(32.W),4))
}