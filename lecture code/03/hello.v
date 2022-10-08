module hello(
	clk,
	btn,
	led
);

input wire clk;
input wire btn;
output wire led;

reg [21:0]clk_div;

always @(posedge clk)
begin
	clk_div <= clk_div + 21'h000001;
end

assign led = btn == 1'b0 ? ~clk_div[20] : 1'b1;

endmodule
