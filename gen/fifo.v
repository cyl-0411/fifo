module fifo(
  output        io_write_ready,
  input         io_write_valid,
  input  [31:0] io_write_bits,
  input         io_wr_rst,
  input         io_wr_clk,
  input         io_read_ready,
  output        io_read_valid,
  output [31:0] io_read_bits,
  input         io_rd_rst,
  input         io_rd_clk
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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:7]; // @[fifo.scala 16:16]
  wire  ram_rd_bits_MPORT_en; // @[fifo.scala 16:16]
  wire [2:0] ram_rd_bits_MPORT_addr; // @[fifo.scala 16:16]
  wire [31:0] ram_rd_bits_MPORT_data; // @[fifo.scala 16:16]
  wire [31:0] ram_MPORT_data; // @[fifo.scala 16:16]
  wire [2:0] ram_MPORT_addr; // @[fifo.scala 16:16]
  wire  ram_MPORT_mask; // @[fifo.scala 16:16]
  wire  ram_MPORT_en; // @[fifo.scala 16:16]
  reg [3:0] wr_ptr; // @[fifo.scala 18:64]
  reg [3:0] rd_ptr; // @[fifo.scala 19:64]
  reg [3:0] wr_ptr_r_ptr_1; // @[fifo.scala 46:26]
  reg [3:0] wr_ptr_r; // @[fifo.scala 47:26]
  reg [3:0] rd_ptr_w_ptr_1; // @[fifo.scala 46:26]
  reg [3:0] rd_ptr_w; // @[fifo.scala 47:26]
  reg [31:0] rd_bits; // @[fifo.scala 22:64]
  wire  rd_empty = rd_ptr == wr_ptr_r; // @[fifo.scala 24:25]
  wire  wr_full = wr_ptr[3] != rd_ptr_w[3] & wr_ptr[2:0] == rd_ptr_w[2:0]; // @[fifo.scala 25:55]
  wire  wr_en = io_write_valid & io_write_ready; // @[fifo.scala 26:30]
  wire  rd_en = io_read_valid & io_read_ready; // @[fifo.scala 27:29]
  wire [3:0] _wr_ptr_T_1 = wr_ptr + 4'h1; // @[fifo.scala 34:24]
  wire [3:0] _rd_ptr_T_1 = rd_ptr + 4'h1; // @[fifo.scala 39:24]
  assign ram_rd_bits_MPORT_en = io_read_valid & io_read_ready;
  assign ram_rd_bits_MPORT_addr = rd_ptr[2:0];
  assign ram_rd_bits_MPORT_data = ram[ram_rd_bits_MPORT_addr]; // @[fifo.scala 16:16]
  assign ram_MPORT_data = io_write_bits;
  assign ram_MPORT_addr = wr_ptr[2:0];
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_write_valid & io_write_ready;
  assign io_write_ready = ~wr_full; // @[fifo.scala 29:20]
  assign io_read_valid = ~rd_empty; // @[fifo.scala 28:20]
  assign io_read_bits = rd_bits; // @[fifo.scala 30:16]
  always @(posedge io_wr_clk) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[fifo.scala 16:16]
    end
    if (io_wr_rst) begin // @[fifo.scala 18:64]
      wr_ptr <= 4'h0; // @[fifo.scala 18:64]
    end else if (wr_en) begin // @[fifo.scala 32:29]
      wr_ptr <= _wr_ptr_T_1; // @[fifo.scala 34:14]
    end
    rd_ptr_w_ptr_1 <= rd_ptr; // @[fifo.scala 46:26]
    rd_ptr_w <= rd_ptr_w_ptr_1; // @[fifo.scala 48:13]
  end
  always @(posedge io_rd_clk) begin
    if (io_rd_rst) begin // @[fifo.scala 19:64]
      rd_ptr <= 4'h0; // @[fifo.scala 19:64]
    end else if (rd_en) begin // @[fifo.scala 36:29]
      rd_ptr <= _rd_ptr_T_1; // @[fifo.scala 39:14]
    end
    wr_ptr_r_ptr_1 <= wr_ptr; // @[fifo.scala 46:26]
    wr_ptr_r <= wr_ptr_r_ptr_1; // @[fifo.scala 48:13]
    if (io_rd_rst) begin // @[fifo.scala 22:64]
      rd_bits <= 32'h0; // @[fifo.scala 22:64]
    end else if (rd_en) begin // @[fifo.scala 36:29]
      rd_bits <= ram_rd_bits_MPORT_data; // @[fifo.scala 38:15]
    end
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
  wr_ptr = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  rd_ptr = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  wr_ptr_r_ptr_1 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  wr_ptr_r = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  rd_ptr_w_ptr_1 = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  rd_ptr_w = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  rd_bits = _RAND_7[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
