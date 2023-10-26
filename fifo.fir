circuit fifo :
  module fifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip write : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_w : UInt<1>, flip clk_w : Clock, read : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_r : UInt<1>, flip clk_r : Clock}

    cmem mem : UInt<32> [4] @[GCD.scala 19:16]
    reg rd_ptr : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[GCD.scala 20:23]
    reg wr_ptr : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[GCD.scala 21:23]
    reg wr_full : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[GCD.scala 22:24]
    reg rd_empty : UInt<1>, clock with :
      reset => (reset, UInt<1>("h1")) @[GCD.scala 23:25]
    reg rd_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[GCD.scala 24:22]
    reg wr_en : UInt<1>, clock with :
      reset => (reset, UInt<1>("h0")) @[GCD.scala 25:22]
    node _T = eq(io.rst_r, UInt<1>("h1")) @[GCD.scala 29:20]
    when _T : @[GCD.scala 29:32]
      rd_ptr <= UInt<1>("h0") @[GCD.scala 30:14]
    node _T_1 = lt(rd_ptr, wr_ptr) @[GCD.scala 33:18]
    node _T_2 = eq(rd_empty, UInt<1>("h0")) @[GCD.scala 33:39]
    node _T_3 = and(_T_1, _T_2) @[GCD.scala 33:27]
    node _T_4 = eq(rd_en, UInt<1>("h1")) @[GCD.scala 33:59]
    node _T_5 = and(_T_3, _T_4) @[GCD.scala 33:50]
    when _T_5 : @[GCD.scala 33:71]
      node _rd_ptr_T = add(rd_ptr, UInt<1>("h1")) @[GCD.scala 34:24]
      node _rd_ptr_T_1 = tail(_rd_ptr_T, 1) @[GCD.scala 34:24]
      rd_ptr <= _rd_ptr_T_1 @[GCD.scala 34:14]
    else :
      rd_ptr <= rd_ptr @[GCD.scala 36:14]
    io.read <= io.write @[GCD.scala 44:12]
    reg rd_ptr1 : UInt, io.clk_w with :
      reset => (UInt<1>("h0"), rd_ptr1) @[GCD.scala 48:26]
    rd_ptr1 <= wr_ptr @[GCD.scala 48:26]
    reg rd_ptr_w : UInt, io.clk_w with :
      reset => (UInt<1>("h0"), rd_ptr_w) @[GCD.scala 49:27]
    rd_ptr_w <= rd_ptr1 @[GCD.scala 49:27]
    node _T_6 = leq(wr_ptr, rd_ptr_w) @[GCD.scala 50:18]
    when _T_6 : @[GCD.scala 50:31]
      skip

