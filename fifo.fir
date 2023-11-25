circuit fifo :
  module fifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip write : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_w : UInt<1>, flip clk_w : Clock, read : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_r : UInt<1>, flip clk_r : Clock}

    cmem ram : UInt<32> [8] @[GCD.scala 19:16]
    node wr_en = and(io.write.valid, io.write.ready) @[GCD.scala 21:30]
    node rd_en = and(io.read.valid, io.read.ready) @[GCD.scala 22:29]
    reg rd_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[GCD.scala 24:23]
    reg wr_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[GCD.scala 25:23]
    node rd_empty = eq(rd_ptr, wr_ptr) @[GCD.scala 27:25]
    node _wr_full_T = head(wr_ptr, 1) @[GCD.scala 28:29]
    node _wr_full_T_1 = head(rd_ptr, 1) @[GCD.scala 28:48]
    node _wr_full_T_2 = neq(_wr_full_T, _wr_full_T_1) @[GCD.scala 28:33]
    node _wr_full_T_3 = tail(wr_ptr, 1) @[GCD.scala 28:68]
    node _wr_full_T_4 = tail(rd_ptr, 1) @[GCD.scala 28:87]
    node _wr_full_T_5 = eq(_wr_full_T_3, _wr_full_T_4) @[GCD.scala 28:72]
    node wr_full = and(_wr_full_T_2, _wr_full_T_5) @[GCD.scala 28:53]
    node _io_read_valid_T = eq(rd_empty, UInt<1>("h0")) @[GCD.scala 29:20]
    io.read.valid <= _io_read_valid_T @[GCD.scala 29:17]
    node _io_write_ready_T = eq(wr_full, UInt<1>("h0")) @[GCD.scala 30:20]
    io.write.ready <= _io_write_ready_T @[GCD.scala 30:17]
    node _T = eq(io.rst_r, UInt<1>("h0")) @[GCD.scala 33:19]
    when _T : @[GCD.scala 33:32]
      rd_ptr <= UInt<1>("h0") @[GCD.scala 34:14]
      io.read.bits <= UInt<1>("h0") @[GCD.scala 35:20]
    else :
      node _io_read_bits_T = bits(rd_ptr, 2, 0) @[GCD.scala 37:42]
      read mport io_read_bits_MPORT = ram[_io_read_bits_T], io.clk_r @[GCD.scala 37:42]
      wire _io_read_bits_WIRE : UInt<32> @[GCD.scala 37:72]
      _io_read_bits_WIRE <= UInt<1>("h0") @[GCD.scala 37:72]
      node _io_read_bits_T_1 = mux(rd_en, io_read_bits_MPORT, _io_read_bits_WIRE) @[GCD.scala 37:26]
      io.read.bits <= _io_read_bits_T_1 @[GCD.scala 37:20]
      node _rd_ptr_T = add(rd_ptr, UInt<1>("h1")) @[GCD.scala 38:24]
      node _rd_ptr_T_1 = tail(_rd_ptr_T, 1) @[GCD.scala 38:24]
      rd_ptr <= _rd_ptr_T_1 @[GCD.scala 38:14]
    reg wr_ptr_1 : UInt, io.clk_r with :
      reset => (UInt<1>("h0"), wr_ptr_1) @[GCD.scala 40:29]
    wr_ptr_1 <= wr_ptr @[GCD.scala 40:29]
    reg wr_ptr_r : UInt, io.clk_r with :
      reset => (UInt<1>("h0"), wr_ptr_r) @[GCD.scala 41:29]
    wr_ptr_r <= wr_ptr_1 @[GCD.scala 41:29]

