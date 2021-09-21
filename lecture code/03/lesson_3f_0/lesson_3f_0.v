module lesson_3f_0(
	clk,
	led1,
	led2,
	btn1,
	btn2
	);

input 	wire	clk;
input 	wire	btn1;
input 	wire	btn2;
output	wire	led1;
output	wire	led2;


reg [23:0] cnt = 24'h0000;

always @(posedge clk)
begin
	cnt = cnt + 24'h1;
end

assign led1 = 	btn1 == 1'b0	? 	cnt[23] 	: 		1'b1;
assign led2 = 	btn2 == 1'b0	? 	cnt[23]	:		1'b1;


	
endmodule