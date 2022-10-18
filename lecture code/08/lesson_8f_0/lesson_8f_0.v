module lesson_8f_0 (
	clk,
	// 7seg
	DS_EN1,
	DS_EN2,
	DS_EN3,
	DS_EN4,
   DS_A,
	DS_B,
	DS_C,
	DS_D,
	DS_E,
	DS_F,
	DS_G,
	btn1,
	led1
);

localparam	k_num = 512;

input		wire	clk;
output	wire	DS_EN1;
output	wire	DS_EN2;
output	wire	DS_EN3;
output	wire	DS_EN4;
output	wire	DS_A;
output	wire	DS_B;
output	wire	DS_C;
output	wire	DS_D;
output	wire	DS_E;
output	wire	DS_F;
output	wire	DS_G;
input 	wire	btn1;
output	wire	led1;

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [6:0]segments;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G} = segments;

reg [15:0] r_out;
seg7_controller seg7_controller_inst(
    .clk(clk),
    .data( r_out ),
    .anodes(anodes),
    .segments(segments)
);


wire [k_num-1:0] ro_out;

genvar i;
generate for (i = 0; i < k_num; i = i + 1)
	begin : RO
		RO RO_inst( /* synthesis keep = 1 */
			.out(ro_out[i])
		); 
	end
endgenerate

wire to_ff;
assign to_ff = ^ro_out;

reg [1:0] rand;
always @(posedge clk)
	rand <= {rand[0], to_ff};

reg [15:0] sr = 16'h0000;

always @(posedge clk) sr <= {sr[14:0], rand[1]};


reg [1:0] btn_edge;
always @(posedge clk) btn_edge <= {btn_edge[0], ~btn1};


always @(posedge clk)
begin
	if(btn_edge == 2'b01)
		r_out <= sr;
end

endmodule