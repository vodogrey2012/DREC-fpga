
module D_Flip_Flop(
	input D_i,
	input C_i,
	output Q_o,
	output nQ_o
);

wire Q_Master;

D_Latch D_Latch_Master(.D_i(D_i), .E_i(!C_i), .Q_o(Q_Master));
D_Latch D_Latch_Slave(.D_i(Q_Master), .E_i(C_i), .Q_o(Q_o), .nQ_o(nQ_o));

endmodule