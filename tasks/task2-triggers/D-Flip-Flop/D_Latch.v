
module D_Latch(
	input D_i,
	input E_i,
	output Q_o,
	output nQ_o
);

SR_Latch D_Latch(.R_i( E_i & (!D_i) ), .S_i( E_i & D_i ), .Q_o(Q_o), .nQ_o(nQ_o));

endmodule