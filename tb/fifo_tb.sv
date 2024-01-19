`timescale 1ns/1ps
module fifo_tb();

bit clk;

bit [31:0]ram0,ram1,ram2,ram3,ram4,ram5,ram6,ram7;

fifo_if tb_if(clk) ;

fifo dut(
.io_wr_clk		(tb_if.wr_clk	 ),
.io_wr_rst		(tb_if.wr_rst	 ),
.io_write_ready (tb_if.wr_ready  ),
.io_write_valid (tb_if.wr_valid  ),
.io_write_bits  (tb_if.wr_bits   ),
.io_rd_clk		(tb_if.rd_clk	 ),
.io_rd_rst		(tb_if.rd_rst	 ),
.io_read_ready  (tb_if.rd_ready  ),
.io_read_valid  (tb_if.rd_valid  ),
.io_read_bits   (tb_if.rd_bits   )
);


initial begin 
	$dumpfile("fifo_tb.vcd");
	$dumpvars(0,fifo_tb);
	// $dumpvars(0,ram1);
	// for(int i = 0 ; i < 8 ; i++)begin
	// 	$dumpvars(0,fifo_tb.dut.ram[i]);
	// end
end

always #10 begin 
	ram0 = fifo_tb.dut.ram[0];
	ram1 = fifo_tb.dut.ram[1];
	ram2 = fifo_tb.dut.ram[2];
	ram3 = fifo_tb.dut.ram[3];
	ram4 = fifo_tb.dut.ram[4];
	ram5 = fifo_tb.dut.ram[5];
	ram6 = fifo_tb.dut.ram[6];
	ram7 = fifo_tb.dut.ram[7];
end
initial begin 
    tb_if.rd_clk  = 0 ; 
	tb_if.wr_clk = 0 ; 
    tb_if.rd_rst = 0 ; 
	tb_if.wr_rst = 0 ; 
    #5 ;
    tb_if.rd_rst = 1 ; 
	tb_if.wr_rst = 1 ; 
	#50 ;
	tb_if.rd_rst = 0 ; 
	tb_if.wr_rst = 0 ; 
end 
always #10 tb_if.rd_clk = ~tb_if.rd_clk ;
always #10 tb_if.wr_clk = ~tb_if.wr_clk ;

initial begin
	@(posedge tb_if.wr_clk)
	wrOnly();
	rdOnly();
	wrOnly();
	rdOnly();
	$finish;
end

task rdOnly ;
for (int i = 0 ; i < 32 ; i++) begin
	tb_if.rd_ready = $random() ;
	@(posedge tb_if.rd_clk);
    #2 ;
end
endtask

task wrOnly ;
for (int i = 0 ; i < 32 ; i++) begin
	tb_if.wr_valid = $random() % 2 ;
	tb_if.wr_bits = $random() ; 
	@(posedge tb_if.wr_clk);
    #7 ;
end
endtask

endmodule : fifo_tb