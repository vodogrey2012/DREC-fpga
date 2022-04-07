`timescale 1ns/10ps

module tb();

reg         clk;
reg         rstn;
reg [1:0]   sel;
reg         en;
wire        dclk;
reg        unused;

top top_inst(
    .clk_i(clk),
    .rstn_i(rstn),
    .sel_i(sel),
    .dclk_o(dclk),
    .en_i(en)
);

realtime period = 10;
reg [2:0] i;

always #(period/2) clk = ~clk;


initial begin
    $dumpvars;
    clk = 1'b0;
    
    for(i = 3'b000; i < 3'b100; i = i + 3'h1)
    begin
        clkcheck(i[1:0], 1'b1, period);
    end
    
    #(100);
    unused = 1'b1;
    $display("SUCCESS");
    $finish;
end



task clkcheck(
    input reg [1:0] sel_t,
    input reg en_t,
    input realtime period_t
);

realtime t;
integer factor;
integer exp;

begin
    sel = sel_t;
    en = en_t;
    
    rstn = 1'b0;
    #(5);
    rstn = 1'b1;
    
    @(posedge dclk);
    t = $realtime;
    @(posedge dclk);
    t = $realtime - t;
    
    factor = 2**(8-sel_t);
    exp = period_t*factor;
    if( t != exp)
    begin
        $display("ERROR!");
        #(100);
        $finish;
    end
    
end
endtask


endmodule
