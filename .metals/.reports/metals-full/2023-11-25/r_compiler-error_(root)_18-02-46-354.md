file://<WORKSPACE>/src/main/scala/gcd/GCD.scala
### scala.ScalaReflectionException: value rd_empty is not a method

occurred in the presentation compiler.

action parameters:
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

  val rd_empty = rd_ptr === 
  val wr_empty = true.B
  io.read.valid := !rd_empty
  io.write.ready:= !wr_empty



  withClockAndReset( io.clk_r , io.rst_r){
    when(io.rst_r === false.B ){
      rd_ptr := 0.U
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
```



#### Error stacktrace:

```
scala.reflect.api.Symbols$SymbolApi.asMethod(Symbols.scala:240)
	scala.reflect.api.Symbols$SymbolApi.asMethod$(Symbols.scala:234)
	scala.reflect.internal.Symbols$SymbolContextApiImpl.asMethod(Symbols.scala:99)
	scala.tools.nsc.typechecker.ContextErrors$TyperContextErrors$TyperErrorGen$.MissingArgsForMethodTpeError(ContextErrors.scala:761)
	scala.tools.nsc.typechecker.Typers$Typer.adaptMethodTypeToExpr$1(Typers.scala:972)
	scala.tools.nsc.typechecker.Typers$Typer.adapt(Typers.scala:1276)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:6056)
	scala.tools.nsc.typechecker.Typers$Typer.typedDefDef(Typers.scala:6318)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5950)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:6041)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:6119)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$4(Typers.scala:3362)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$4$adapted(Typers.scala:3357)
	scala.reflect.internal.Scopes$Scope.foreach(Scopes.scala:455)
	scala.tools.nsc.typechecker.Typers$Typer.addSynthetics$1(Typers.scala:3357)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3422)
	scala.tools.nsc.typechecker.Typers$Typer.typedTemplate(Typers.scala:2064)
	scala.tools.nsc.typechecker.Typers$Typer.typedClassDef(Typers.scala:1895)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5951)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:6041)
	scala.tools.nsc.typechecker.Typers$Typer.typedStat$1(Typers.scala:6119)
	scala.tools.nsc.typechecker.Typers$Typer.$anonfun$typedStats$8(Typers.scala:3410)
	scala.tools.nsc.typechecker.Typers$Typer.typedStats(Typers.scala:3410)
	scala.tools.nsc.typechecker.Typers$Typer.typedPackageDef$1(Typers.scala:5634)
	scala.tools.nsc.typechecker.Typers$Typer.typed1(Typers.scala:5954)
	scala.tools.nsc.typechecker.Typers$Typer.typed(Typers.scala:6041)
	scala.tools.nsc.typechecker.Analyzer$typerFactory$TyperPhase.apply(Analyzer.scala:117)
	scala.tools.nsc.Global$GlobalPhase.applyPhase(Global.scala:459)
	scala.tools.nsc.interactive.Global$TyperRun.applyPhase(Global.scala:1349)
	scala.tools.nsc.interactive.Global$TyperRun.typeCheck(Global.scala:1342)
	scala.tools.nsc.interactive.Global.typeCheck(Global.scala:680)
	scala.meta.internal.pc.PcCollector.<init>(PcCollector.scala:29)
	scala.meta.internal.pc.PcSemanticTokensProvider$Collector$.<init>(PcSemanticTokensProvider.scala:18)
	scala.meta.internal.pc.PcSemanticTokensProvider.Collector$lzycompute$1(PcSemanticTokensProvider.scala:18)
	scala.meta.internal.pc.PcSemanticTokensProvider.Collector(PcSemanticTokensProvider.scala:18)
	scala.meta.internal.pc.PcSemanticTokensProvider.provide(PcSemanticTokensProvider.scala:71)
	scala.meta.internal.pc.ScalaPresentationCompiler.$anonfun$semanticTokens$1(ScalaPresentationCompiler.scala:157)
```
#### Short summary: 

scala.ScalaReflectionException: value rd_empty is not a method