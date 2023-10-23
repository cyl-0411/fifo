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

/*rd_ptr is increasing*/
  withClockAndReset ( io.clk_r , io.rst_r ) {
    when (io.rst_r === true.B) {
      rd_ptr := 0.U
    }

    when( rd_ptr < wr_ptr && rd_empty ===false.B && rd_en === true.B) {
      rd_ptr := rd_ptr +1.U 
    } .otherwise {
      rd_ptr := rd_ptr
    }
  }

  /*  write_ptr   */
  withClockAndReset ( io.clk_w , io.rst_w ) {
    
  }
  io.write <> io.read
}

/* rd_empty generate */

/* wr_full generate */

class BinToGray (width: Int) extends Module {
  val io = IO(new Bundle {
    val bin     = Input(UInt(width.W))
    val gray    = Output(UInt(width.W))
  })

    io.gray := io.bin ^ (io.bin >> 1.U)
}

class GrayToBin (width: Int) extends Module {
  val io = IO(new Bundle {
    val bin     = Output(UInt(width.W))
    val gray    = Input(UInt(width.W))
  })
    val binary = Wire(Vec(width,UInt(1.W)))
    binary(width-1) := io.gray(width-1)
    for (i <- 2 until (width+1)) {
      binary(width-i) := io.gray(width-i) ^ binary(width-i+1) 
    }
    io.bin := binary.asUInt() 
}



// object Convert{
//   def BintoGray(bin:UInt):UInt = {

//   }
//   def GraytoBin(gray:UInt):UInt = {

//   }
// }

object Elaborate extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new fifo(UInt(32.W),4))
}