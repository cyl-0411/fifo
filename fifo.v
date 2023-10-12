module Queue(
  input         clock,
  input         reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits
);
`ifdef RANDOMIZE_MEM_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] ram [0:15]; // @[Decoupled.scala 275:95]
  wire  ram_io_deq_bits_MPORT_en; // @[Decoupled.scala 275:95]
  wire [3:0] ram_io_deq_bits_MPORT_addr; // @[Decoupled.scala 275:95]
  wire [31:0] ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 275:95]
  wire [31:0] ram_MPORT_data; // @[Decoupled.scala 275:95]
  wire [3:0] ram_MPORT_addr; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_mask; // @[Decoupled.scala 275:95]
  wire  ram_MPORT_en; // @[Decoupled.scala 275:95]
  reg [3:0] enq_ptr_value; // @[Counter.scala 61:40]
  reg [3:0] deq_ptr_value; // @[Counter.scala 61:40]
  reg  maybe_full; // @[Decoupled.scala 278:27]
  wire  ptr_match = enq_ptr_value == deq_ptr_value; // @[Decoupled.scala 279:33]
  wire  empty = ptr_match & ~maybe_full; // @[Decoupled.scala 280:25]
  wire  full = ptr_match & maybe_full; // @[Decoupled.scala 281:24]
  wire  do_enq = io_enq_ready & io_enq_valid; // @[Decoupled.scala 52:35]
  wire  do_deq = io_deq_ready & io_deq_valid; // @[Decoupled.scala 52:35]
  wire [3:0] _value_T_1 = enq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  wire [3:0] _value_T_3 = deq_ptr_value + 4'h1; // @[Counter.scala 77:24]
  assign ram_io_deq_bits_MPORT_en = 1'h1;
  assign ram_io_deq_bits_MPORT_addr = deq_ptr_value;
  assign ram_io_deq_bits_MPORT_data = ram[ram_io_deq_bits_MPORT_addr]; // @[Decoupled.scala 275:95]
  assign ram_MPORT_data = io_enq_bits;
  assign ram_MPORT_addr = enq_ptr_value;
  assign ram_MPORT_mask = 1'h1;
  assign ram_MPORT_en = io_enq_ready & io_enq_valid;
  assign io_enq_ready = ~full; // @[Decoupled.scala 305:19]
  assign io_deq_valid = ~empty; // @[Decoupled.scala 304:19]
  assign io_deq_bits = ram_io_deq_bits_MPORT_data; // @[Decoupled.scala 312:17]
  always @(posedge clock) begin
    if (ram_MPORT_en & ram_MPORT_mask) begin
      ram[ram_MPORT_addr] <= ram_MPORT_data; // @[Decoupled.scala 275:95]
    end
    if (reset) begin // @[Counter.scala 61:40]
      enq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_enq) begin // @[Decoupled.scala 288:16]
      enq_ptr_value <= _value_T_1; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Counter.scala 61:40]
      deq_ptr_value <= 4'h0; // @[Counter.scala 61:40]
    end else if (do_deq) begin // @[Decoupled.scala 292:16]
      deq_ptr_value <= _value_T_3; // @[Counter.scala 77:15]
    end
    if (reset) begin // @[Decoupled.scala 278:27]
      maybe_full <= 1'h0; // @[Decoupled.scala 278:27]
    end else if (do_enq != do_deq) begin // @[Decoupled.scala 295:27]
      maybe_full <= do_enq; // @[Decoupled.scala 296:16]
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
  for (initvar = 0; initvar < 16; initvar = initvar+1)
    ram[initvar] = _RAND_0[31:0];
`endif // RANDOMIZE_MEM_INIT
`ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  enq_ptr_value = _RAND_1[3:0];
  _RAND_2 = {1{`RANDOM}};
  deq_ptr_value = _RAND_2[3:0];
  _RAND_3 = {1{`RANDOM}};
  maybe_full = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fifo(
  input         clock,
  input         reset,
  output        io_write_ready,
  input         io_write_valid,
  input  [31:0] io_write_bits,
  input         io_read_ready,
  output        io_read_valid,
  output [31:0] io_read_bits
);
  wire  fifo_clock; // @[GCD.scala 13:22]
  wire  fifo_reset; // @[GCD.scala 13:22]
  wire  fifo_io_enq_ready; // @[GCD.scala 13:22]
  wire  fifo_io_enq_valid; // @[GCD.scala 13:22]
  wire [31:0] fifo_io_enq_bits; // @[GCD.scala 13:22]
  wire  fifo_io_deq_ready; // @[GCD.scala 13:22]
  wire  fifo_io_deq_valid; // @[GCD.scala 13:22]
  wire [31:0] fifo_io_deq_bits; // @[GCD.scala 13:22]
  Queue fifo ( // @[GCD.scala 13:22]
    .clock(fifo_clock),
    .reset(fifo_reset),
    .io_enq_ready(fifo_io_enq_ready),
    .io_enq_valid(fifo_io_enq_valid),
    .io_enq_bits(fifo_io_enq_bits),
    .io_deq_ready(fifo_io_deq_ready),
    .io_deq_valid(fifo_io_deq_valid),
    .io_deq_bits(fifo_io_deq_bits)
  );
  assign io_write_ready = fifo_io_enq_ready; // @[GCD.scala 15:17]
  assign io_read_valid = fifo_io_deq_valid; // @[GCD.scala 16:17]
  assign io_read_bits = fifo_io_deq_bits; // @[GCD.scala 16:17]
  assign fifo_clock = clock;
  assign fifo_reset = reset;
  assign fifo_io_enq_valid = io_write_valid; // @[GCD.scala 15:17]
  assign fifo_io_enq_bits = io_write_bits; // @[GCD.scala 15:17]
  assign fifo_io_deq_ready = io_read_ready; // @[GCD.scala 16:17]
endmodule
