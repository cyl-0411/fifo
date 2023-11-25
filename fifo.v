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
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:7]; // @[GCD.scala 19:16]
  wire  ram_io_read_bits_MPORT_en; // @[GCD.scala 19:16]
  wire [2:0] ram_io_read_bits_MPORT_addr; // @[GCD.scala 19:16]
  wire [31:0] ram_io_read_bits_MPORT_data; // @[GCD.scala 19:16]
  wire  rd_en = io_read_valid & io_read_ready; // @[GCD.scala 22:29]
  reg [3:0] rd_ptr; // @[GCD.scala 24:23]
  wire  rd_empty = rd_ptr == 4'h0; // @[GCD.scala 27:25]
  wire  wr_full = rd_ptr[3] & 3'h0 == rd_ptr[2:0]; // @[GCD.scala 28:53]
  wire  _T = ~io_rst_r; // @[GCD.scala 33:19]
  wire [31:0] _io_read_bits_T_1 = rd_en ? ram_io_read_bits_MPORT_data : 32'h0; // @[GCD.scala 37:26]
  wire [3:0] _rd_ptr_T_1 = rd_ptr + 4'h1; // @[GCD.scala 38:24]
  assign ram_io_read_bits_MPORT_en = _T ? 1'h0 : 1'h1;
  assign ram_io_read_bits_MPORT_addr = rd_ptr[2:0];
  assign ram_io_read_bits_MPORT_data = ram[ram_io_read_bits_MPORT_addr]; // @[GCD.scala 19:16]
  assign io_write_ready = ~wr_full; // @[GCD.scala 30:20]
  assign io_read_valid = ~rd_empty; // @[GCD.scala 29:20]
  assign io_read_bits = ~io_rst_r ? 32'h0 : _io_read_bits_T_1; // @[GCD.scala 33:32 35:20 37:20]
  always @(posedge clock) begin
    if (reset) begin // @[GCD.scala 24:23]
      rd_ptr <= 4'h0; // @[GCD.scala 24:23]
    end else if (~io_rst_r) begin // @[GCD.scala 33:32]
      rd_ptr <= 4'h0; // @[GCD.scala 34:14]
    end else begin
      rd_ptr <= _rd_ptr_T_1; // @[GCD.scala 38:14]
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
  rd_ptr = _RAND_1[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
