module lesson_6f_0(
	clk,
	din,
   // 7seg
	DS_EN1,
	DS_EN2,
	DS_EN3,
	DS_EN4,
   DS_A,
	DS_B,
	DS_C,
	DS_D,
	DS_E,
	DS_F,
	DS_G,
	
);

input		wire	clk;
input		wire	din;
output	wire	DS_EN1;
output	wire	DS_EN2;
output	wire	DS_EN3;
output	wire	DS_EN4;
output	wire	DS_A;
output	wire	DS_B;
output	wire	DS_C;
output	wire	DS_D;
output	wire	DS_E;
output	wire	DS_F;
output	wire	DS_G;

reg	[7:0]	r_out;
reg	[7:0] c_out;

wire [3:0]anodes;
assign {DS_EN1, DS_EN2, DS_EN3, DS_EN4} = ~anodes;

wire [6:0]segments;
assign {DS_A, DS_B, DS_C, DS_D, DS_E, DS_F, DS_G} = segments;

seg7_controller seg7_controller_inst(
    .clk(clk),
    .data( r_out ),
    .anodes(anodes),
    .segments(segments)
);



cyclone_lcell
#(
  .operation_mode         ("arithmetic"   ), // «арифметический» режим работы
  .synch_mode             ("off"          ),
  .register_cascade_mode  ("off"          ),
  .sum_lutc_input         ("datac"        ),  
  .lut_mask               ("cccc"         ), // «формула» арифметического блока
  .power_up               ("low"          ),
  .cin_used               ("false"        ),
  .cin0_used              ("false"        ),
  .cin1_used              ("false"        ),
  .output_mode            ("reg_and_comb" ), // используем логику и выходной регистр
  .lpm_type               ("cyclone_lcell"),
  .x_on_violation         ("off"          )
)
u_cell0(                      /* synthesis keep = 1 */
  .clk          ( clk      ), // входной клок
  .dataa        ( 0        ),
  .datab        ( din   ), // входной сигнал
  .datac        ( 0        ),
  .aclr         ( 0        ),
  .aload        ( 0        ),
  .sclr         ( 0        ),
  .sload        ( 0        ),
  .ena          ( 1        ),
  .inverta      ( 0        ),
  .regcascin    ( 0        ),
  .combout      (          ),
  .regout       ( r_out[0] ), // выходной регистр
  .cout         ( c_out[0] )  // линия переноса разряда
);

// Последующие элементы линии задержки
genvar i;
generate for (i = 1; i < 8; i = i + 1)
  begin : DLINE
    cyclone_lcell
    #(
      .operation_mode         ("arithmetic"   ), // «арифметический» режим работы
      .synch_mode             ("off"          ),
      .register_cascade_mode  ("off"          ),
      .sum_lutc_input         ("cin"          ), 
      .lut_mask               ("f0f0"         ), // «формула» арифметического блока
      .power_up               ("low"          ),
      .cin_used               ("true"         ), // используем линию переноса
      .cin0_used              ("false"        ), 
      .cin1_used              ("false"        ),
      .output_mode            ("reg_and_comb" ), // используем логику и выходной регистр
      .lpm_type               ("cyclone_lcell"),
      .x_on_violation         ("off"          )
    )
    u_cell1(                         /* synthesis keep = 1 */
      .clk          ( clk         ), // входной клок
      .dataa        ( 0           ),
      .datab        ( 0           ),
      .datac        ( 0           ),
      .cin          (	c_out[i-1]  ), // входной сигнал
      .aclr         ( 0           ),
      .aload        ( 0           ),
      .sclr         ( 0           ),
      .sload        ( 0           ),
      .ena          ( 1           ),
      .inverta      ( 0           ),
      .regcascin    ( 0           ),
      .combout      (             ),
      .regout       ( r_out[i]    ), // выходной регистр
      .cout         ( c_out[i]    )  // линия переноса разряда
    );
  end
endgenerate	


endmodule