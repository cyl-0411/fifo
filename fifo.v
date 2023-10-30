module BinToGray(
  input  [31:0] io_bin,
  output [31:0] io_gray
);
  wire [31:0] _io_gray_T = {{1'd0}, io_bin[31:1]}; // @[GCD.scala 114:47]
  assign io_gray = io_bin ^ _io_gray_T; // @[GCD.scala 114:30]
endmodule
module fifo(
  input         clock,
  input         reset,
  output        io_write_ready,
  input         io_write_valid,
  input  [31:0] io_write_bits,
  input         io_rst_w,
  input         io_clk_w,
  input         io_read_ready,
  output        io_read_valid,
  output [31:0] io_read_bits,
  input         io_rst_r,
  input         io_clk_r
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] mem [0:7]; // @[GCD.scala 19:16]
  wire  mem_io_read_bits_MPORT_en; // @[GCD.scala 19:16]
  wire [2:0] mem_io_read_bits_MPORT_addr; // @[GCD.scala 19:16]
  wire [31:0] mem_io_read_bits_MPORT_data; // @[GCD.scala 19:16]
  wire  mem_io_read_bits_MPORT_1_en; // @[GCD.scala 19:16]
  wire [2:0] mem_io_read_bits_MPORT_1_addr; // @[GCD.scala 19:16]
  wire [31:0] mem_io_read_bits_MPORT_1_data; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_1_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_1_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_1_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_1_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_2_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_2_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_2_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_2_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_3_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_3_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_3_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_3_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_4_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_4_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_4_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_4_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_5_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_5_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_5_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_5_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_6_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_6_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_6_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_6_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_7_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_7_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_7_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_7_en; // @[GCD.scala 19:16]
  wire [31:0] mem_MPORT_8_data; // @[GCD.scala 19:16]
  wire [2:0] mem_MPORT_8_addr; // @[GCD.scala 19:16]
  wire  mem_MPORT_8_mask; // @[GCD.scala 19:16]
  wire  mem_MPORT_8_en; // @[GCD.scala 19:16]
  wire [31:0] DataConverter_io_bin; // @[GCD.scala 88:31]
  wire [31:0] DataConverter_io_gray; // @[GCD.scala 88:31]
  reg  rd_ptr; // @[GCD.scala 20:23]
  reg  wr_ptr; // @[GCD.scala 21:23]
  reg  wr_full; // @[GCD.scala 22:24]
  reg  rd_empty; // @[GCD.scala 23:25]
  reg  rd_en; // @[GCD.scala 24:22]
  reg  wr_en; // @[GCD.scala 25:22]
  wire  _T_2 = ~rd_empty; // @[GCD.scala 42:42]
  reg  wr_ptr1; // @[GCD.scala 48:30]
  reg  wr_ptr_r; // @[GCD.scala 49:27]
  wire [5:0] _T_8 = 6'h20 - 6'h1; // @[GCD.scala 51:48]
  wire  _GEN_2 = rd_ptr <= wr_ptr_r & rd_ptr >> _T_8 == wr_ptr_r >> _T_8 ? 1'h0 : 1'h1; // @[GCD.scala 51:79 52:16 54:16]
  wire  _T_19 = io_read_valid & _T_2; // @[GCD.scala 57:38]
  wire [5:0] _GEN_20 = {{5'd0}, wr_ptr}; // @[GCD.scala 65:18]
  reg  rd_ptr1; // @[GCD.scala 71:30]
  reg  rd_ptr_w; // @[GCD.scala 72:27]
  wire  _T_37 = wr_ptr <= rd_ptr_w & wr_ptr >> _T_8 == rd_ptr_w >> _T_8; // @[GCD.scala 73:31]
  wire  _T_38 = ~wr_full; // @[GCD.scala 79:20]
  wire  _T_40 = ~wr_full & io_write_valid; // @[GCD.scala 79:32]
  wire  _T_48 = rd_en & _T_2; // @[GCD.scala 100:30]
  wire  _io_read_bits_T_3 = rd_ptr - 1'h1; // @[GCD.scala 103:40]
  BinToGray DataConverter ( // @[GCD.scala 88:31]
    .io_bin(DataConverter_io_bin),
    .io_gray(DataConverter_io_gray)
  );
  assign mem_io_read_bits_MPORT_en = rd_en & _T_2;
  assign mem_io_read_bits_MPORT_addr = {{2'd0}, rd_ptr};
  assign mem_io_read_bits_MPORT_data = mem[mem_io_read_bits_MPORT_addr]; // @[GCD.scala 19:16]
  assign mem_io_read_bits_MPORT_1_en = _T_48 ? 1'h0 : 1'h1;
  assign mem_io_read_bits_MPORT_1_addr = {{2'd0}, _io_read_bits_T_3};
  assign mem_io_read_bits_MPORT_1_data = mem[mem_io_read_bits_MPORT_1_addr]; // @[GCD.scala 19:16]
  assign mem_MPORT_data = 32'h0;
  assign mem_MPORT_addr = 3'h0;
  assign mem_MPORT_mask = 1'h1;
  assign mem_MPORT_en = 1'h1;
  assign mem_MPORT_1_data = 32'h0;
  assign mem_MPORT_1_addr = 3'h1;
  assign mem_MPORT_1_mask = 1'h1;
  assign mem_MPORT_1_en = 1'h1;
  assign mem_MPORT_2_data = 32'h0;
  assign mem_MPORT_2_addr = 3'h2;
  assign mem_MPORT_2_mask = 1'h1;
  assign mem_MPORT_2_en = 1'h1;
  assign mem_MPORT_3_data = 32'h0;
  assign mem_MPORT_3_addr = 3'h3;
  assign mem_MPORT_3_mask = 1'h1;
  assign mem_MPORT_3_en = 1'h1;
  assign mem_MPORT_4_data = 32'h0;
  assign mem_MPORT_4_addr = 3'h4;
  assign mem_MPORT_4_mask = 1'h1;
  assign mem_MPORT_4_en = 1'h1;
  assign mem_MPORT_5_data = 32'h0;
  assign mem_MPORT_5_addr = 3'h5;
  assign mem_MPORT_5_mask = 1'h1;
  assign mem_MPORT_5_en = 1'h1;
  assign mem_MPORT_6_data = 32'h0;
  assign mem_MPORT_6_addr = 3'h6;
  assign mem_MPORT_6_mask = 1'h1;
  assign mem_MPORT_6_en = 1'h1;
  assign mem_MPORT_7_data = 32'h0;
  assign mem_MPORT_7_addr = 3'h7;
  assign mem_MPORT_7_mask = 1'h1;
  assign mem_MPORT_7_en = 1'h1;
  assign mem_MPORT_8_data = DataConverter_io_gray;
  assign mem_MPORT_8_addr = {{2'd0}, wr_ptr};
  assign mem_MPORT_8_mask = 1'h1;
  assign mem_MPORT_8_en = wr_en & _T_38;
  assign io_write_ready = 1'h0; // @[GCD.scala 30:18]
  assign io_read_valid = 1'h0; // @[GCD.scala 28:17]
  assign io_read_bits = rd_en & _T_2 ? mem_io_read_bits_MPORT_data : mem_io_read_bits_MPORT_1_data; // @[GCD.scala 100:55 101:20 103:20]
  assign DataConverter_io_bin = io_write_bits; // @[GCD.scala 89:26]
  always @(posedge clock) begin
    if (mem_MPORT_en & mem_MPORT_mask) begin
      mem[mem_MPORT_addr] <= mem_MPORT_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_1_en & mem_MPORT_1_mask) begin
      mem[mem_MPORT_1_addr] <= mem_MPORT_1_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_2_en & mem_MPORT_2_mask) begin
      mem[mem_MPORT_2_addr] <= mem_MPORT_2_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_3_en & mem_MPORT_3_mask) begin
      mem[mem_MPORT_3_addr] <= mem_MPORT_3_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_4_en & mem_MPORT_4_mask) begin
      mem[mem_MPORT_4_addr] <= mem_MPORT_4_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_5_en & mem_MPORT_5_mask) begin
      mem[mem_MPORT_5_addr] <= mem_MPORT_5_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_6_en & mem_MPORT_6_mask) begin
      mem[mem_MPORT_6_addr] <= mem_MPORT_6_data; // @[GCD.scala 19:16]
    end
    if (mem_MPORT_7_en & mem_MPORT_7_mask) begin
      mem[mem_MPORT_7_addr] <= mem_MPORT_7_data; // @[GCD.scala 19:16]
    end
    if (reset) begin // @[GCD.scala 20:23]
      rd_ptr <= 1'h0; // @[GCD.scala 20:23]
    end else if (rd_ptr < wr_ptr & ~rd_empty & rd_en) begin // @[GCD.scala 42:77]
      rd_ptr <= rd_ptr + 1'h1; // @[GCD.scala 43:14]
    end
    if (reset) begin // @[GCD.scala 21:23]
      wr_ptr <= 1'h0; // @[GCD.scala 21:23]
    end else if (wr_en & _T_38) begin // @[GCD.scala 90:55]
      if (_GEN_20 < _T_8 & wr_full & wr_en) begin // @[GCD.scala 65:78]
        wr_ptr <= wr_ptr + 1'h1; // @[GCD.scala 66:14]
      end
    end
    if (reset) begin // @[GCD.scala 22:24]
      wr_full <= 1'h0; // @[GCD.scala 22:24]
    end else begin
      wr_full <= _T_37;
    end
    rd_empty <= reset | _GEN_2; // @[GCD.scala 23:{25,25}]
    if (reset) begin // @[GCD.scala 24:22]
      rd_en <= 1'h0; // @[GCD.scala 24:22]
    end else begin
      rd_en <= _T_19;
    end
    if (reset) begin // @[GCD.scala 25:22]
      wr_en <= 1'h0; // @[GCD.scala 25:22]
    end else begin
      wr_en <= _T_40;
    end
  end
  always @(posedge io_clk_w) begin
    if (mem_MPORT_8_en & mem_MPORT_8_mask) begin
      mem[mem_MPORT_8_addr] <= mem_MPORT_8_data; // @[GCD.scala 19:16]
    end
    rd_ptr1 <= wr_ptr; // @[GCD.scala 71:30]
    rd_ptr_w <= rd_ptr1; // @[GCD.scala 72:27]
  end
  always @(posedge io_clk_r) begin
    wr_ptr1 <= wr_ptr; // @[GCD.scala 48:30]
    wr_ptr_r <= wr_ptr1; // @[GCD.scala 49:27]
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_MEM_INIT
  _RAND_0 = {1{`RANDOM}};
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rd_ptr = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  wr_ptr = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  wr_full = _RAND_3[0:0];
  _RAND_4 = {1{`RANDOM}};
  rd_empty = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  rd_en = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  wr_en = _RAND_6[0:0];
  _RAND_7 = {1{`RANDOM}};
  wr_ptr1 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  wr_ptr_r = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  rd_ptr1 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  rd_ptr_w = _RAND_10[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
