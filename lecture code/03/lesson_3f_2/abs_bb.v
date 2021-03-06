// megafunction wizard: %ALTFP_ABS%VBB%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTFP_ABS 

// ============================================================
// File Name: abs.v
// Megafunction Name(s):
// 			ALTFP_ABS
//
// Simulation Library Files(s):
// 			
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Lite Edition
// ************************************************************

//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.

module abs (
	data,
	result)/* synthesis synthesis_clearbox = 1 */;

	input	[31:0]  data;
	output	[31:0]  result;

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_HINT STRING "UNUSED"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altfp_abs"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "0"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "23"
// Retrieval info: USED_PORT: data 0 0 32 0 INPUT NODEFVAL "data[31..0]"
// Retrieval info: CONNECT: @data 0 0 32 0 data 0 0 32 0
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL abs.v TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs.qip TRUE FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs.bsf TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs_inst.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs_bb.v TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs.inc TRUE TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL abs.cmp TRUE TRUE
