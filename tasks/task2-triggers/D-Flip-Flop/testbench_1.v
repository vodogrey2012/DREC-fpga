`timescale 1ns/10ps

module tb();

reg d;
reg c;
wire q;
wire q_not;

D_Flip_Flop D_Flop_Flop(.D_i(d), .C_i(c), .Q_o(q), .nQ_o(q_not));

realtime period = 4;

always #(period/2) c = ~c;

initial begin
    $dumpvars(d, c, q, q_not);
	 
	 d=0;c=0;
	 
	 $display("Start");
 
    #5 d=1;
	 
	 #2 d=0;
	 
	 #1 d=1;
	 
	 #2 d=0;
	 
	 #1 d=1;
	 
	 #2 d=0;
	 
	 #4 d=1;
	 
	 #10
	 
	 $display("Stop");
	 
	 $stop;
	 	  
end

endmodule