circuit fifo :
  module fifo :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip write : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_w : UInt<1>, flip clk_w : Clock, read : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rst_r : UInt<1>, flip clk_r : Clock}

    cmem ram : UInt<32> [8] @[GCD.scala 19:16]
    node wr_en = and(io.write.valid, io.write.ready) @[GCD.scala 21:30]
    node rd_en = and(io.read.valid, io.read.ready) @[GCD.scala 22:29]
    reg rd_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[GCD.scala 25:23]
    reg wr_ptr : UInt<4>, clock with :
      reset => (reset, UInt<4>("h0")) @[GCD.scala 26:23]
    reg wr_ptr_r_ptr_1 : UInt, io.clk_r with :
      reset => (UInt<1>("h0"), wr_ptr_r_ptr_1) @[GCD.scala 61:26]
    wr_ptr_r_ptr_1 <= wr_ptr @[GCD.scala 61:26]
    reg wr_ptr_r : UInt, io.clk_r with :
      reset => (UInt<1>("h0"), wr_ptr_r) @[GCD.scala 62:26]
    wr_ptr_r <= wr_ptr_r_ptr_1 @[GCD.scala 62:26]
    wr_ptr_r <= wr_ptr_r_ptr_1 @[GCD.scala 63:13]
    reg rd_ptr_w_ptr_1 : UInt, io.clk_w with :
      reset => (UInt<1>("h0"), rd_ptr_w_ptr_1) @[GCD.scala 61:26]
    rd_ptr_w_ptr_1 <= rd_ptr @[GCD.scala 61:26]
    reg rd_ptr_w : UInt, io.clk_w with :
      reset => (UInt<1>("h0"), rd_ptr_w) @[GCD.scala 62:26]
    rd_ptr_w <= rd_ptr_w_ptr_1 @[GCD.scala 62:26]
    rd_ptr_w <= rd_ptr_w_ptr_1 @[GCD.scala 63:13]
    node rd_empty = eq(rd_ptr, wr_ptr_r) @[GCD.scala 31:25]
    node _wr_full_T = head(wr_ptr, 1) @[GCD.scala 32:29]
    node _wr_full_T_1 = head(rd_ptr_w, 1) @[GCD.scala 32:50]
    node _wr_full_T_2 = neq(_wr_full_T, _wr_full_T_1) @[GCD.scala 32:33]
    node _wr_full_T_3 = tail(wr_ptr, 1) @[GCD.scala 32:70]
    node _wr_full_T_4 = tail(rd_ptr_w, 1) @[GCD.scala 32:91]
    node _wr_full_T_5 = eq(_wr_full_T_3, _wr_full_T_4) @[GCD.scala 32:74]
    node wr_full = and(_wr_full_T_2, _wr_full_T_5) @[GCD.scala 32:55]
    node _io_read_valid_T = eq(rd_empty, UInt<1>("h0")) @[GCD.scala 33:20]
    io.read.valid <= _io_read_valid_T @[GCD.scala 33:17]
    node _io_write_ready_T = eq(wr_full, UInt<1>("h0")) @[GCD.scala 34:20]
    io.write.ready <= _io_write_ready_T @[GCD.scala 34:17]
    node _T = eq(io.rst_r, UInt<1>("h0")) @[GCD.scala 37:19]
    when _T : @[GCD.scala 37:32]
      rd_ptr <= UInt<1>("h0") @[GCD.scala 38:14]
      io.read.bits <= UInt<1>("h0") @[GCD.scala 39:20]
    else :
      node _io_read_bits_T = bits(rd_ptr, 2, 0) @[GCD.scala 41:42]
      read mport io_read_bits_MPORT = ram[_io_read_bits_T], io.clk_r @[GCD.scala 41:42]
      wire _io_read_bits_WIRE : UInt<32> @[GCD.scala 41:72]
      _io_read_bits_WIRE <= UInt<1>("h0") @[GCD.scala 41:72]
      node _io_read_bits_T_1 = mux(rd_en, io_read_bits_MPORT, _io_read_bits_WIRE) @[GCD.scala 41:26]
      io.read.bits <= _io_read_bits_T_1 @[GCD.scala 41:20]
      node _rd_ptr_T = add(rd_ptr, UInt<1>("h1")) @[GCD.scala 42:24]
      node _rd_ptr_T_1 = tail(_rd_ptr_T, 1) @[GCD.scala 42:24]
      rd_ptr <= _rd_ptr_T_1 @[GCD.scala 42:14]
    node _T_1 = eq(io.rst_w, UInt<1>("h0")) @[GCD.scala 48:19]
    when _T_1 : @[GCD.scala 48:31]
      wr_ptr <= UInt<1>("h0") @[GCD.scala 49:14]
    else :
      when wr_en : @[GCD.scala 51:21]
        node _T_2 = bits(wr_ptr, 2, 0)
        write mport MPORT = ram[_T_2], io.clk_w
        MPORT <= io.write.bits
        node _wr_ptr_T = add(wr_ptr, UInt<1>("h1")) @[GCD.scala 53:26]
        node _wr_ptr_T_1 = tail(_wr_ptr_T, 1) @[GCD.scala 53:26]
        wr_ptr <= _wr_ptr_T_1 @[GCD.scala 53:16]

