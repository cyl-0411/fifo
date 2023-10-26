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
  assign io_write_ready = io_read_ready; // @[GCD.scala 44:12]
  assign io_read_valid = io_write_valid; // @[GCD.scala 44:12]
  assign io_read_bits = io_write_bits; // @[GCD.scala 44:12]
endmodule
