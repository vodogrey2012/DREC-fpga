`timescale 1ns/10ps

module tb();

reg s;
reg r;
wire q;
wire q_not;

SR_Latch SR_Latch(.S_i(s), .R_i(r), .Q_o(q), .nQ_o(q_not) );

initial begin
    $dumpvars(s, r, q, q_not);

    // case 1 (latch w/o state)
    s=0; r=0; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # undefined",
              s, r, q, q_not);

    // case 2 (reset)
    s=0; r=1; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # reset, q=0",
              s, r, q, q_not);

    // case 3 (set)
    s=1; r=0; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # set, q=1",
              s, r, q, q_not);

    // case 4 (latch with state)
    s=0; r=0; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # latch, q=q (keep state)",
              s, r, q, q_not);

    // case 5 (invalid state)
    s=1; r=1; #1
    $display("s=%b, r=%b ==> q=%b, q_not=%b # invalid state",
              s, r, q, q_not);
end

endmodule