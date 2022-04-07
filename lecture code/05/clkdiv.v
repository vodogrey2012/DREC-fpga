`timescale 1ns/10ps

module clkdiv(
    clk_i,
    rstn_i,
    sel_i,
    dclk_o
);

input   wire            clk_i;
input   wire            rstn_i;
input   wire    [1:0]   sel_i;
output  reg             dclk_o;

reg [7:0]   cnt;



always @(posedge clk_i or negedge rstn_i)
begin
    if( ~rstn_i)
        cnt <= 8'h00;
    else
    begin
        cnt <= cnt + 1;
    end
end


always @(*)
begin
    case(sel_i)
    2'b00:      dclk_o = cnt[7];
    2'b01:      dclk_o = cnt[6];
    2'b10:      dclk_o = cnt[5];
    2'b11:      dclk_o = cnt[4];
    default:    dclk_o = 1'b0;
    endcase
end




endmodule
