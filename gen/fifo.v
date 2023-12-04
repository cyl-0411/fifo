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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:7]; // @[fifo.scala 19:16]
  wire  ram_io_read_bits_MPORT_en; // @[fifo.scala 19:16]
  wire [2:0] ram_io_read_bits_MPORT_addr; // @[fifo.scala 19:16]
  wire [31:0] ram_io_read_bits_MPORT_data; // @[fifo.scala 19:16]
  wire [31:0] ram_MPORT_data; // @[fifo.scala 19:16]
  wire [2:0] ram_MPORT_addr; // @[fifo.scala 19:16]
  wire  ram_MPORT_mask; // @[fifo.scala 19:16]
  wire  ram_MPORT_en; // @[fifo.scala 19:16]
  wire  wr_en = io_write_valid & io_write_ready; // @[fifo.scala 21:30]
  wire  rd_en = io_read_valid & io_read_ready; // @[fifo.scala 22:29]
  reg [3:0] rd_ptr; // @[fifo.scala 25:23]
  reg [3:0] wr_ptr; // @[fifo.scala 26:23]
  reg [3:0] wr_ptr_r_ptr_1; // @[fifo.scala 61:26]
  reg [3:0] wr_ptr_r; // @[fifo.scala 62:26]
  reg [3:0] rd_ptr_w_ptr_1; // @[fifo.scala 61:26]
  reg [3:0] rd_ptr_w; // @[fifo.scala 62:26]
  wire  rd_empty = rd_ptr == wr_ptr_r; // @[fifo.scala 31:25]
  wire  wr_full = wr_ptr[3] != rd_ptr_w[3] & wr_ptr[2:0] == rd_ptr_w[2:0]; // @[fifo.scala 32:55]
  wire  _T = ~io_rst_r; // @[fifo.scala 37:19]
  wire [31:0] _io_read_bits_T_1 = rd_en ? ram_io_read_bits_MPORT_data : 32'h0; // @[fifo.scala 41:26]
  wire [3:0] _rd_ptr_T_1 = rd_ptr + 4'h1; // @[fifo.scala 42:24]
  wire  _T_1 = ~io_rst_w; // @[fifo.scala 48:19]
  wire [3:0] _wr_ptr_T_1 = wr_ptr + 4'h1; // @[fifo.scala 53:26]
  assign ram_io_read_bits_MPORT_en = _T ? 1'h0 : 1'h1;
  assign ram_io_read_bits_MPORT_addr = rd_ptr[2:0];
  assign ram_io_read_bits_MPORT_data = ram[ram_io_read_bits_MPORT_addr]; // @[fifo.scala 19:16]
  assign ram_MPORT_data = io_write_bits;
  assign ram_MPORT_addr = wr_ptr[2:0];
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = _T_1 ? 1'h0 : wr_en;
  assign io_write_ready = ~wr_full; // @[fifo.scala 34:20]
  assign io_read_valid = ~rd_empty; // @[fifo.scala 33:20]
  assign io_read_bits = ~io_rst_r ? 32'h0 : _io_read_bits_T_1; // @[fifo.scala 37:32 39:20 41:20]
  always @(posedge io_clk_w) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[fifo.scala 19:16]
    end
    rd_ptr_w_ptr_1 <= rd_ptr; // @[fifo.scala 61:26]
    rd_ptr_w <= rd_ptr_w_ptr_1; // @[fifo.scala 63:13]
  end
  always @(posedge clock) begin
    if (reset) begin // @[fifo.scala 25:23]
      rd_ptr <= 4'h0; // @[fifo.scala 25:23]
    end else if (~io_rst_r) begin // @[fifo.scala 37:32]
      rd_ptr <= 4'h0; // @[fifo.scala 38:14]
    end else begin
      rd_ptr <= _rd_ptr_T_1; // @[fifo.scala 42:14]
    end
    if (reset) begin // @[fifo.scala 26:23]
      wr_ptr <= 4'h0; // @[fifo.scala 26:23]
    end else if (~io_rst_w) begin // @[fifo.scala 48:31]
      wr_ptr <= 4'h0; // @[fifo.scala 49:14]
    end else if (wr_en) begin // @[fifo.scala 51:21]
      wr_ptr <= _wr_ptr_T_1; // @[fifo.scala 53:16]
    end
  end
  always @(posedge io_clk_r) begin
    wr_ptr_r_ptr_1 <= wr_ptr; // @[fifo.scala 61:26]
    wr_ptr_r <= wr_ptr_r_ptr_1; // @[fifo.scala 63:13]
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
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  rd_ptr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  wr_ptr = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  wr_ptr_r_ptr_1 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  wr_ptr_r = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  rd_ptr_w_ptr_1 = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  rd_ptr_w = _RAND_6[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
