file://<WORKSPACE>/src/main/scala/gcd/GCD.scala
### java.lang.NullPointerException

occurred in the presentation compiler.

action parameters:
offset: 928
uri: file://<WORKSPACE>/src/main/scala/gcd/GCD.scala
text:
```scala
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

  val rd_empty = false.B
  val wr_empty = true.B
  io.read.valid := !rd_empty
  io.write.valid:= !wr_empty



  withClockAndReset( io.clk_r , io.rst_r){
    when(rd_en) {
      io.read.bits := ram.read(rd_ptr)
      rd_ptr := rd_ptr + 1.U

      wr_ptr_1 = RegNext(wr_ptr)
      wr_ptr_r = RegNext(w@@)
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
```



#### Error stacktrace:

```
scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.methodsParams$lzycompute(ArgCompletions.scala:30)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.methodsParams(ArgCompletions.scala:29)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.allParams$lzycompute(ArgCompletions.scala:81)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.allParams(ArgCompletions.scala:81)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.params$lzycompute(ArgCompletions.scala:83)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.params(ArgCompletions.scala:82)
	scala.meta.internal.pc.completions.ArgCompletions$ArgCompletion.contribute(ArgCompletions.scala:210)
	scala.meta.internal.pc.CompletionProvider.expected$1(CompletionProvider.scala:439)
	scala.meta.internal.pc.CompletionProvider.safeCompletionsAt(CompletionProvider.scala:499)
	scala.meta.internal.pc.CompletionProvider.completions(CompletionProvider.scala:58)
	scala.meta.internal.pc.ScalaPresentationCompiler.$anonfun$complete$1(ScalaPresentationCompiler.scala:169)
```
#### Short summary: 

java.lang.NullPointerException