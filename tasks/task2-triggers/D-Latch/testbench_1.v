`timescale 1ns/10ps

module tb();

reg d;
reg e;
wire q;
wire q_not;

D_Latch D_Latch(.D_i(d), .E_i(e), .Q_o(q), .nQ_o(q_not) );

initial begin
    $dumpvars(d, e, q, q_not);

    // case 1 (latch)
    d=0; e=0; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # latch, q=q (keep state)",
              d, e, q, q_not);

    // case 2 (latch)
    d=1; e=0; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # latch, q=q (keep state)",
              d, e, q, q_not);

    // case 3 (reset)
    d=0; e=1; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # reset, q=0",
              d, e, q, q_not);

    // case 4 (set)
    d=1; e=1; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # set, q=1",
              d, e, q, q_not);

    // case 5 (latch)
    d=1; e=0; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # latch",
              d, e, q, q_not);
	
	 // case 6 (latch)
    d=0; e=0; #1
    $display("d=%b, e=%b ==> q=%b, q_not=%b # latch",
              d, e, q, q_not);
				  
end

endmodule