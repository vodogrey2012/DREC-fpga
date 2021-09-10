`timescale 1ns/10ps

module top(
    rstn_i,
    clk_i,
    sel_i,
    oe_i,
    dclk_o
);

input   wire            rstn_i;
input   wire            clk_i;
input   wire    [2:0]   sel_i;
input   wire            oe_i;
output  wire            dclk_o;

clkdiv clkdiv_inst(
    .rstn_i(    rstn_i),
    .clk_i(     clk_i),
    .sel_i(     sel_i),
    .dclk_o(    dclk)
);

assign dclk_o = oe_i ? dclk : 1'b0; // and( dclk_o, oe_i, dclk);


endmodule
    
    
