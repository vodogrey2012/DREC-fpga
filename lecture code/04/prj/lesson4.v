
module lesson4(
	clk,
	led
);

input wire clk;
output wire led;

reg [23:0] cnt;

always @(posedge clk)
	cnt <= cnt+1;
	
assign led = cnt[23];

endmodule