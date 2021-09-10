`timescale 1ns/10ps

module clkdiv
    (
    clk_i,
    rstn_i,
    sel_i,
    dclk_o
);

input   wire            clk_i;
input   wire            rstn_i;
input   wire    [2:0]   sel_i;
output  reg             dclk_o;

reg     [   15  :   0]  cnt;

always @(posedge clk_i or negedge rstn_i)
begin
    if( !rstn_i)
        cnt <= {16{1'b0}};
    else
        cnt <= cnt + 1;
end

always @(*)
begin
    dclk_o = cnt[15 - sel_i];
end

endmodule
