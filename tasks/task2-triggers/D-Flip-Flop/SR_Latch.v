module SR_Latch(

	input wire R_i,
	input wire S_i,
	output wire Q_o,
	output wire nQ_o
	
);

assign Q_o = ~(R_i | nQ_o);
assign nQ_o = ~(S_i | Q_o);

endmodule