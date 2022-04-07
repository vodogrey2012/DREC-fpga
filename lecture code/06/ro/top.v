module top(
	ro_o
);

output wire ro_o;

parameter RO_NUM = 15;

wire a[RO_NUM:0];

genvar i;
generate
for(i = 0; i < RO_NUM; i = i+1) begin : ro
	LCELL ro_inst(.in(a[i]), .out(a[i+1]));
end
endgenerate

assign a[0] = ~a[RO_NUM];

assign ro_o = a[RO_NUM];


endmodule