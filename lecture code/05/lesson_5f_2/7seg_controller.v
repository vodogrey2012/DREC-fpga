module seg7_controller(
    input clk,
    input [4*4-1:0]data,

    output [3:0]anodes,
    output reg [6:0]segments
);

//#############################################
// clock devider

reg [11:0]cnt = 0;

assign clkd = cnt[11];

always @(posedge clk) begin
    cnt <= cnt + 12'b1;
end

//#############################################
// controller

reg [1:0]i = 0;

assign anodes = (4'b1 << i);

always @(posedge clkd) begin
    i <= i + 2'b1;
end

wire [3:0]d;
assign d = 	i == 2'h0 ? data[3:0] :
				i == 2'h1 ? data[7:4] :
				i == 2'h2 ? data[11:8]:
								data[15:12];

always @(*) begin
    case (d)
        4'h0: segments = 7'b1111110;
        4'h1: segments = 7'b0110000;
        4'h2: segments = 7'b1101101;
        4'h3: segments = 7'b1111001;
        4'h4: segments = 7'b0110011;
        4'h5: segments = 7'b1011011;
        4'h6: segments = 7'b1011111;
        4'h7: segments = 7'b1110000;
        4'h8: segments = 7'b1111111;
        4'h9: segments = 7'b1111011;
        4'ha: segments = 7'b1110111;
        4'hb: segments = 7'b0011111;
        4'hc: segments = 7'b1001110;
        4'hd: segments = 7'b0111101;
        4'he: segments = 7'b1001111;
        4'hf: segments = 7'b1000111;
    endcase
end

endmodule