interface fifo_if #(parameter width = 32)(input bit clk);
    logic wr_clk;
    logic wr_rst;
    logic wr_empty;
    logic wr_ready;
    logic wr_valid;
    logic [width-1 : 0]wr_bits;

    logic rd_clk;
    logic rd_rst;
    logic rd_full;
    logic rd_ready;
    logic rd_valid;
    logic [width-1 : 0]rd_bits;
endinterface