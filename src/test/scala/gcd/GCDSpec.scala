
package gcd

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import chisel3.experimental.BundleLiterals._
import fifo._


class fifotest extends AnyFreeSpec with ChiselScalatestTester {

  "FIFO should pass" in {
    test(new fifo()) { dut =>
      dut.io.value1.poke(1.U)
      dut.io.value2.poke(1.U)
      dut.io.value3.expect(1.U)

      dut.io.value1.poke(0.U)
      dut.io.value2.poke(1.U)
      dut.io.value3.expect(0.U)
            
      dut.io.value1.poke(1.U)
      dut.io.value2.poke(0.U)
      dut.io.value3.expect(0.U)      
    }
  }
}
