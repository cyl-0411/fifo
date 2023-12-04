`timescale 1ns/1ps
module fifo_tb();
reg clk;
reg rst;

reg wr_clk;
reg wr_rst;
reg wr_valid;
wire wr_ready;
reg [31:0]wr_bits;
wire wr_empty;

reg rd_clk;
reg rd_rst;
wire rd_valid;
wire rd_ready;
wire [31:0]rd_bits;
wire rd_full;

fifo dut(
.clock      (clk          ),
.reset      (rst          ),
.io_write_ready (wr_ready  ),
.io_write_valid (wr_valid  ),
.io_write_bits  (wr_bits   ),
.io_read_ready  (rd_ready  ),
.io_read_valid  (rd_valid  ),
.io_read_bits   (rd_bits   )
);


initial begin 
    clk = 0 ; rd_clk  = 0 ; wr_clk = 0 ;
    rst = 1 ; rd_rst = 1 ; 
    #100 ;
    rst = 0 ;
end 
always #10 clk = ~clk ;

initial begin 
	$dumpfile("fifo_tb.vcd");
	$dumpvars(0,fifo_tb);
end

initial begin 
    @(negedge rst);
    $finish();
end 



endmodule