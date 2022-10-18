module RO (
	out
);

localparam	ro_len = 3;

output wire out;

wire inv; /* synthesis keep = 1 */
wire	[ro_len-1:0] c_out;
assign inv = ~c_out[ro_len-1];
assign out = inv;

LCELL u_cell0( inv, c_out[0]); /* synthesis keep = 1 */

// Последующие элементы линии задержки
genvar i;
generate for (i = 1; i < ro_len; i = i + 1)
	begin : DLINE
		LCELL u_cell( c_out[i-1], c_out[i]); /* synthesis keep = 1 */
	end
endgenerate	

endmodule