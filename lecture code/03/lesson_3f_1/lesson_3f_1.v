module lesson_3f_1(
	clk,
	led1,
	led2,
	led2_o,
	led2_i,
	btn1,
	btn2
	);

input 	wire	clk;
input 	wire	btn1;
input 	wire	btn2;
output	wire	led1;
output	wire	led2;

output	wire	led2_o;
input		wire	led2_i;


reg [23:0] cnt = 24'h0000;

always @(posedge clk)
begin
	cnt = cnt + 24'h1;
end

assign led1 = 	btn1 == 1'b0	? 	cnt[23] 	: 		1'b1;
assign led2_o = 	btn2 == 1'b0	? 	cnt[23]	:		1'b1;

assign led2 = led2_i;

	
endmodule