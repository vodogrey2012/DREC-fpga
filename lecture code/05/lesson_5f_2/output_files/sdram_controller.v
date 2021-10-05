module sdram_controller(
	// sdram signals
	A0_11_o,
	BS0_1_o,
	DQ0_15_io,
	nCS_o,
	nRAS_o,
	nCAS_o,
	nWE_o,
	// master signals
	addr_i,
	clk_i,
	we_i,
	re_i,
	din_i,
	dout_o,
	setup_i,
	bact_i
);

output	reg	[	11	:	0	]	A0_11_o;
output	reg	[	1	:	0	]	BS0_1_o;
inout		wire	[	15	:	0	]	DQ0_15_io;
output	reg						nCS_o;
output	reg						nRAS_o;
output	reg						nCAS_o;
output	reg						nWE_o;

input		wire						clk_i;
input		wire						we_i;
input		wire						re_i;
input		wire						setup_i;
input		wire						bact_i;
input		wire	[	15	:	0	]	din_i;
output	wire	[	15	:	0	]	dout_o;
input		wire	[	11	:	0	]	addr_i;

//###############################
wire setup_sig = (setup_dl == 1'b0 ) && (setup_i == 1'b1) ? 1'b1 : 1'b0 ;
reg setup_dl;
always @(posedge clk_i) setup_dl <= setup_i;

wire we_sig = (we_dl == 1'b0 ) && (we_i == 1'b1) ? 1'b1 : 1'b0 ;
reg we_dl;
always @(posedge clk_i) we_dl <= we_i;

wire re_sig = (re_dl == 1'b0 ) && (re_i == 1'b1) ? 1'b1 : 1'b0 ;
reg re_dl;
always @(posedge clk_i) re_dl <= re_i;

wire bact_sig = (bact_dl == 1'b0 ) && (bact_i == 1'b1) ? 1'b1 : 1'b0 ;
reg bact_dl;
always @(posedge clk_i) bact_dl <= bact_i;

always @(posedge clk_i)
begin
	if( setup_sig)
		nCS_o <= 1'b0;
	else if( bact_sig)
		nCS_o <= 1'b0;
	else if( we_sig)
		nCS_o <= 1'b0;
	else if( re_sig)
		nCS_o <= 1'b0;
	else
		nCS_o <= 1'b0;
end
		
always @(posedge clk_i)
begin
	if( setup_sig)
		nRAS_o <= 1'b0;
	else if( bact_sig)
		nRAS_o <= 1'b0;
	else if( we_sig)
		nRAS_o <= 1'b1;
	else if( re_sig)
		nRAS_o <= 1'b1;
	else
		nRAS_o <= 1'b1;
end

always @(posedge clk_i)
begin
	if( setup_sig)
		nCAS_o <= 1'b0;
	else if( bact_sig)
		nCAS_o <= 1'b1;
	else if( we_sig)
		nCAS_o <= 1'b0;
	else if( re_sig)
		nCAS_o <= 1'b0;
	else
		nCAS_o <= 1'b1;
end

always @(posedge clk_i)
begin
	if( setup_sig)
		nWE_o <= 1'b0;
	else if( bact_sig)
		nWE_o <= 1'b1;
	else if( we_sig)
		nWE_o <= 1'b0;
	else if( re_sig)
		nWE_o <= 1'b1;
	else
		nWE_o <= 1'b1;
end

always @(posedge clk_i)
begin
	if( setup_sig)
		A0_11_o <= { 2'b00, 1'b1, 1'b0, 1'b0, 3'b011, 1'b0, 3'b000};
	else if( bact_sig)
		A0_11_o <= 12'h000;
	else if( we_sig)
		A0_11_o <= {addr_i[11:10], 1'b0, addr_i[8:0]};
	else if( re_sig)
		A0_11_o <= {addr_i[11:10], 1'b0, addr_i[8:0]};
	else
		A0_11_o <= 12'h1234;
end

always @(posedge clk_i)
begin
	if( setup_sig)
		BS0_1_o <= 2'b00;
	else if( bact_sig)
		BS0_1_o <= 2'b00;
	else if( we_sig)
		BS0_1_o <= 2'b00;
	else if( re_sig)
		BS0_1_o <= 2'b00;
	else
		BS0_1_o <= 2'b00;
end

//###################################
// Bidir data io

reg	[	15	:	0	]	da = 16'h0000;
reg	[	15	:	0	]	db = 16'h0000;
assign DQ0_15_io = we_i ? da : 16'bZ;
assign dout_o = db;

always @(posedge clk_i)
begin
	db <= DQ0_15_io;
	da <= din_i;
end


endmodule
	
	
	