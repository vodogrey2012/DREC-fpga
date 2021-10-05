module lesson_5f_1(
	clk,
	led1,
	led2,
	btn1,
	btn2
	);

(* maxfan = 8 *) input 	wire	clk;
input 	wire	btn1;
input 	wire	btn2;
output	wire	led1;
output	wire	led2;


reg [23:0] cnt = 24'h0000;

always @(posedge clk)
begin
	cnt = cnt + 24'h1;
end

reg [1:0] btn1_sync;
reg [1:0] btn2_sync;

always @(posedge clk)
	btn1_sync <= {btn1_sync[0], btn1};
	
always @(posedge clk)
	btn2_sync <= {btn2_sync[0], btn2};

assign led1 = 	btn1_sync[1] == 1'b0	? 	cnt[23] 	: 		1'b1;
assign led2 = 	btn2_sync[1] == 1'b0	? 	cnt[23]	:		1'b1;
	
endmodule