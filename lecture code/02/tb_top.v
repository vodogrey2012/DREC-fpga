`timescale 1ns/10ps

module tb_top();
//---------------------------------------------------------------------
reg                         rstn;
reg                         clk;
reg                         oe;
reg  [   2  :   0   ]       sel;
wire                        dclk;

realtime period = 10;
realtime exp;
integer exp_factor;
reg [3:0] sel_int;
integer is_error;

top top_inst(
    .rstn_i(    rstn),
    .clk_i(     clk),
    .oe_i(      oe),
    .sel_i(     sel),
    .dclk_o(    dclk)
);

//---------------------------------------------------------------------
always #(period/2) clk <= ~clk;

initial begin
    $dumpvars;
    clk = 1'b0;
    rstn = 1'b1;
    #(200);
    rstn = 1'b0;
    #(100);
    rstn = 1'b1;
    
    for( sel_int = 4'h0; sel_int < 4'h8; sel_int = sel_int + 4'h1)
    begin
        #(20);
        exp_factor = 2**(16-sel_int);
        exp = period*exp_factor;
        clkdiv_verif(  .sel_i(sel_int), .exp_i(exp), .is_error_o(is_error));
        if( is_error)
            $finish;
    end
    
    $display("SUCCESS!");
    $finish;
end

//---------------------------------------------------------------------
task clkdiv_verif(
    input   reg [3:0]   sel_i,
    input   realtime    exp_i,
    output  integer     is_error_o
);

realtime period;
begin
    sel = sel_i;
    //@(posedge dclk);
    @(dclk === 1'b0);
    @(dclk === 1'b1);
    period = $realtime;
    //@(posedge dclk);
    @(dclk === 1'b0);
    @(dclk === 1'b1);
    period = $realtime - period;
    
    if( exp_i == period)
    begin
        $display("Correct! Period equals to expected %0t", exp_i);
        is_error = 0;
    end
    else
    begin
        $display("Error! Period equals to %0t and does not equal to expected %0t", period, exp_i);
        is_error_o = 1;
    end
end
endtask

endmodule
