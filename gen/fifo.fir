circuit fifo :
  module fifo :
    output io : { flip write : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip wr_rst : UInt<1>, flip wr_clk : Clock, read : { flip ready : UInt<1>, valid : UInt<1>, bits : UInt<32>}, flip rd_rst : UInt<1>, flip rd_clk : Clock}

    cmem ram : UInt<32> [8] @[fifo.scala 16:16]
    reg wr_ptr : UInt<4>, io.wr_clk with :
      reset => (io.wr_rst, UInt<4>("h0")) @[fifo.scala 18:64]
    reg rd_ptr : UInt<4>, io.rd_clk with :
      reset => (io.rd_rst, UInt<4>("h0")) @[fifo.scala 19:64]
    reg wr_ptr_r_ptr_1 : UInt, io.rd_clk with :
      reset => (UInt<1>("h0"), wr_ptr_r_ptr_1) @[fifo.scala 46:26]
    wr_ptr_r_ptr_1 <= wr_ptr @[fifo.scala 46:26]
    reg wr_ptr_r : UInt, io.rd_clk with :
      reset => (UInt<1>("h0"), wr_ptr_r) @[fifo.scala 47:26]
    wr_ptr_r <= wr_ptr_r_ptr_1 @[fifo.scala 47:26]
    wr_ptr_r <= wr_ptr_r_ptr_1 @[fifo.scala 48:13]
    reg rd_ptr_w_ptr_1 : UInt, io.wr_clk with :
      reset => (UInt<1>("h0"), rd_ptr_w_ptr_1) @[fifo.scala 46:26]
    rd_ptr_w_ptr_1 <= rd_ptr @[fifo.scala 46:26]
    reg rd_ptr_w : UInt, io.wr_clk with :
      reset => (UInt<1>("h0"), rd_ptr_w) @[fifo.scala 47:26]
    rd_ptr_w <= rd_ptr_w_ptr_1 @[fifo.scala 47:26]
    rd_ptr_w <= rd_ptr_w_ptr_1 @[fifo.scala 48:13]
    reg rd_bits : UInt<32>, io.rd_clk with :
      reset => (io.rd_rst, UInt<32>("h0")) @[fifo.scala 22:64]
    node rd_empty = eq(rd_ptr, wr_ptr_r) @[fifo.scala 24:25]
    node _wr_full_T = head(wr_ptr, 1) @[fifo.scala 25:29]
    node _wr_full_T_1 = head(rd_ptr_w, 1) @[fifo.scala 25:50]
    node _wr_full_T_2 = neq(_wr_full_T, _wr_full_T_1) @[fifo.scala 25:33]
    node _wr_full_T_3 = tail(wr_ptr, 1) @[fifo.scala 25:70]
    node _wr_full_T_4 = tail(rd_ptr_w, 1) @[fifo.scala 25:91]
    node _wr_full_T_5 = eq(_wr_full_T_3, _wr_full_T_4) @[fifo.scala 25:74]
    node wr_full = and(_wr_full_T_2, _wr_full_T_5) @[fifo.scala 25:55]
    node wr_en = and(io.write.valid, io.write.ready) @[fifo.scala 26:30]
    node rd_en = and(io.read.valid, io.read.ready) @[fifo.scala 27:29]
    node _io_read_valid_T = eq(rd_empty, UInt<1>("h0")) @[fifo.scala 28:20]
    io.read.valid <= _io_read_valid_T @[fifo.scala 28:17]
    node _io_write_ready_T = eq(wr_full, UInt<1>("h0")) @[fifo.scala 29:20]
    io.write.ready <= _io_write_ready_T @[fifo.scala 29:17]
    io.read.bits <= rd_bits @[fifo.scala 30:16]
    node _T = eq(wr_en, UInt<1>("h1")) @[fifo.scala 32:17]
    when _T : @[fifo.scala 32:29]
      node _T_1 = bits(wr_ptr, 2, 0)
      write mport MPORT = ram[_T_1], io.wr_clk
      MPORT <= io.write.bits
      node _wr_ptr_T = add(wr_ptr, UInt<1>("h1")) @[fifo.scala 34:24]
      node _wr_ptr_T_1 = tail(_wr_ptr_T, 1) @[fifo.scala 34:24]
      wr_ptr <= _wr_ptr_T_1 @[fifo.scala 34:14]
    node _T_2 = eq(rd_en, UInt<1>("h1")) @[fifo.scala 36:17]
    when _T_2 : @[fifo.scala 36:29]
      node _rd_bits_T = bits(rd_ptr, 2, 0) @[fifo.scala 38:26]
      read mport rd_bits_MPORT = ram[_rd_bits_T], io.rd_clk @[fifo.scala 38:26]
      rd_bits <= rd_bits_MPORT @[fifo.scala 38:15]
      node _rd_ptr_T = add(rd_ptr, UInt<1>("h1")) @[fifo.scala 39:24]
      node _rd_ptr_T_1 = tail(_rd_ptr_T, 1) @[fifo.scala 39:24]
      rd_ptr <= _rd_ptr_T_1 @[fifo.scala 39:14]

