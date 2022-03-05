`timescale 1ns/10ps

module tb();

reg         clk;
reg         rstn;
reg [1:0]   sel;
reg         en;
wire        dclk;

top top_inst(
    .clk_i(clk),
    .rstn_i(rstn),
    .sel_i(sel),
    .dclk_o(dclk),
    .en_i(en)
);

realtime period = 10;
realtime t;


always #(period/2) clk = ~clk;


initial begin
    $dumpvars;
    clk = 1'b0;
    sel = 2'b00;
    en = 1'b1;
    
    rstn = 1'b0;
    #(5);
    rstn = 1'b1;
    
    @(posedge dclk);
    t = $realtime;
    @(posedge dclk);
    t = $realtime - t;
    
    #(100); 
    $finish;
end

endmodule
