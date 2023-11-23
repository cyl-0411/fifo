
package gcd

import chisel3._
import chiseltest._
import org.scalatest.freespec.AnyFreeSpec
import chisel3.experimental.BundleLiterals._
import fifo._


class fifotest extends AnyFreeSpec with ChiselScalatestTester {

  // "Module “BinToGray” should pass" in {
  //   test(new BinToGray(8)) { dut =>
  //     dut.io.bin.poke("b10101010".U)
  //     dut.io.gray.expect("b11111111".U)

  //     dut.io.bin.poke("b00000000".U)
  //     dut.io.gray.expect("b00000000".U)

  //     dut.io.bin.poke("b01010101".U)
  //     dut.io.gray.expect("b01111111".U)

  //     dut.io.bin.poke("b11001100".U)
  //     dut.io.gray.expect("b10101010".U)
      
  //   }
  // }

  //   "Module “GrayToBin” should pass" in {
  //   test(new GrayToBin(8)) { dut =>
                 
  //     dut.io.gray.poke("b00000000".U) 
  //     dut.io.bin.expect("b00000000".U)

  //     dut.io.gray.poke("b10101010".U)
  //     dut.io.bin.expect("b11001100".U) 

  //     dut.io.gray.poke("b01111111".U)
  //     dut.io.bin.expect("b01010101".U)
      
  //     dut.io.gray.poke("b11111111".U) 
  //     dut.io.bin.expect("b10101010".U)
  //   }
  // }
}
