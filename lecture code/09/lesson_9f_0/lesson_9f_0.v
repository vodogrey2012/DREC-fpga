module lesson_9f_0(
	clk,
	btn1,
	btn2,
	btn4,
	led1,
	led2
);

input		wire	clk;
input		wire	btn1;
input		wire	btn2;
input		wire	btn4;
output	wire	led1;
output	wire	led2;

SM1 SM1_inst(
    .reset(),
	 .clock(clk),
	 .btn1(btn1),
	 .btn2(btn2),
	 .btn4(btn4),
    .led1(led1),
	 .led2(led2)
);

endmodule