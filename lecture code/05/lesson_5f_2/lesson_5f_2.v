module lesson_5f_2(
	clk,
	btn1,
	btn2,
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
	// sdram nets
	SDRAM_A11,
	SDRAM_A10,
	SDRAM_A9,
	SDRAM_A8,
	SDRAM_A7,
	SDRAM_A6,
	SDRAM_A5,
	SDRAM_A4,
	SDRAM_A3,
	SDRAM_A2,
	SDRAM_A1,
	SDRAM_A0,
	SDRAM_BA1,
	SDRAM_BA0,
	SDRAM_DQ15,
	SDRAM_DQ14,
	SDRAM_DQ13,
	SDRAM_DQ12,
	SDRAM_DQ11,
	SDRAM_DQ10,
	SDRAM_DQ9,
	SDRAM_DQ8,
	SDRAM_DQ7,
	SDRAM_DQ6,
	SDRAM_DQ5,
	SDRAM_DQ4,
	SDRAM_DQ3,
	SDRAM_DQ2,
	SDRAM_DQ1,
	SDRAM_DQ0,
	SDRAM_CS_N,
	SDRAM_RAS_N,
	SDRAM_CAS_N,
	SDRAM_WE_N,
	SDRAM_CKE,
	SDRAM_CLK,
	SDRAM_DQMH,
	SDRAM_DQML
);

input		wire	clk;
input		wire	btn1;
input		wire	btn2;
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

output	wire	SDRAM_A11;
output	wire	SDRAM_A10;
output	wire	SDRAM_A9;
output	wire	SDRAM_A8;
output	wire	SDRAM_A7;
output	wire	SDRAM_A6;
output	wire	SDRAM_A5;
output	wire	SDRAM_A4;
output	wire	SDRAM_A3;
output	wire	SDRAM_A2;
output	wire	SDRAM_A1;
output	wire	SDRAM_A0;
output	wire	SDRAM_BA1;
output	wire	SDRAM_BA0;
inout		wire	SDRAM_DQ15;
inout		wire	SDRAM_DQ14;
inout		wire	SDRAM_DQ13;
inout		wire	SDRAM_DQ12;
inout		wire	SDRAM_DQ11;
inout		wire	SDRAM_DQ10;
inout		wire	SDRAM_DQ9;
inout		wire	SDRAM_DQ8;
inout		wire	SDRAM_DQ7;
inout		wire	SDRAM_DQ6;
inout		wire	SDRAM_DQ5;
inout		wire	SDRAM_DQ4;
inout		wire	SDRAM_DQ3;
inout		wire	SDRAM_DQ2;
inout		wire	SDRAM_DQ1;
inout		wire	SDRAM_DQ0;
output	wire	SDRAM_CS_N;
output	wire	SDRAM_RAS_N;
output	wire	SDRAM_CAS_N;
output	wire	SDRAM_WE_N;
output	wire	SDRAM_CKE;
output	wire	SDRAM_CLK;
output	wire	SDRAM_DQMH;
output	wire	SDRAM_DQML;
//###############################################
reg clk2 = 1'b0;
always @(posedge clk) clk2 <= ~clk2; 


wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [6:0]segments;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G} = segments;

reg [1:0]btn1_sync;
always @(posedge clk2) btn1_sync <= {btn1_sync[0], btn1};

reg [1:0]btn2_sync;
always @(posedge clk2) btn2_sync <= {btn2_sync[0], btn2};

reg [7:0]cnt=8'h00;
always @(posedge clk2)
begin
	cnt <= cnt+8'h1;
end

wire	[	15	:	0	]	dout;
wire	[	15	:	0	]	dout_l;
wire	[	15	:	0	]	din;
wire	[	11	:	0	]	addr;
wire 						setup;
wire						we;
wire						re;
wire						bact;

assign setup = ( cnt == 8'h0f && btn1_sync[1] == 1'b1) ? 1'b1 : 1'b0;
assign bact  = ( cnt == 8'h1f && btn1_sync[1] == 1'b1) ? 1'b1 : 1'b0;

assign we	 = ( cnt == 8'h2f && btn1_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h3f && btn1_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h4f && btn1_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h5f && btn1_sync[1] == 1'b0) ? 1'b1 : 1'b0;
					
assign re	 = ( cnt == 8'h6f && btn1_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h7f && btn1_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h8f && btn2_sync[1] == 1'b0) ? 1'b1 :
					( cnt == 8'h9f && btn1_sync[1] == 1'b0) ? 1'b1 : 1'b0;

assign addr = (cnt == 8'h2f) ? 12'h000 :
				  (cnt == 8'h3f) ? 12'h001 :
				  (cnt == 8'h4f) ? 12'h002 :
				  (cnt == 8'h5f) ? 12'h00f :
				  (cnt == 8'h6f) ? 12'h000 :
				  (cnt == 8'h7f) ? 12'h001 :
				  (cnt == 8'h8f && btn2_sync[1] == 1'b0) ? 12'h002 :
				  (cnt == 8'h9f) ? 12'h00f : 12'h000;

assign dout_l = (cnt == 8'h93) ? dout : dout_l;

assign din = (cnt == 8'h2f || cnt == 8'h30) && (btn1_sync[1] == 1'b0) ? 16'h0123 :
				 (cnt == 8'h3f || cnt == 8'h40) && (btn1_sync[1] == 1'b0) ? 16'h0f0f :
				 (cnt == 8'h4f || cnt == 8'h50) && (btn1_sync[1] == 1'b0) ? 16'habcd :
				 (cnt == 8'h5f || cnt == 8'h60) && (btn1_sync[1] == 1'b0) ? 16'h0f11 :16'h0000;


seg7_controller seg7_controller_inst(
    .clk(clk2),
    .data( dout_l ),
    .anodes(anodes),
    .segments(segments)
);


sdram_controller sdram_controller_inst(
	// sdram signals
	.A0_11_o({SDRAM_A11, SDRAM_A10, SDRAM_A9, SDRAM_A8, SDRAM_A7, SDRAM_A6, SDRAM_A5, SDRAM_A4, SDRAM_A3, SDRAM_A2, SDRAM_A1, SDRAM_A0}),
	.BS0_1_o({SDRAM_BA1, SDRAM_BA0}),
	.DQ0_15_io({SDRAM_DQ15, SDRAM_DQ14, SDRAM_DQ13, SDRAM_DQ12, SDRAM_DQ11, SDRAM_DQ10, SDRAM_DQ9, SDRAM_DQ8,
					SDRAM_DQ7, SDRAM_DQ6, SDRAM_DQ5, SDRAM_DQ4, SDRAM_DQ3, SDRAM_DQ2, SDRAM_DQ1, SDRAM_DQ0}),
	.nCS_o(SDRAM_CS_N),
	.nRAS_o(SDRAM_RAS_N),
	.nCAS_o(SDRAM_CAS_N),
	.nWE_o(SDRAM_WE_N),
	// master signals
	.clk_i(clk2),
	.we_i(we),
	.re_i(re),
	.din_i(din),
	.dout_o(dout),
	.setup_i(setup),
	.bact_i(bact),
	.addr_i(addr)
);

assign SDRAM_CKE = 1'b1;
assign SDRAM_CLK = clk2;
assign SDRAM_DQML = 1'b0;
assign SDRAM_DQMH = 1'b0;

endmodule