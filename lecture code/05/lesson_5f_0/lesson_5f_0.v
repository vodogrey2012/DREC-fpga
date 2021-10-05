module lesson_5f_0(
	clk,
	led1
	);

input 	wire	clk;
output	wire	led1;


reg [23:0] cnt = 24'h0000;

always @(posedge clk)
begin
	cnt = cnt + 24'h1;
end

wire [31:0]ext /* synthesis keep = 1 */;

assign ext = {32{cnt[23]}};
assign led1 = |ext; 


	
endmodule