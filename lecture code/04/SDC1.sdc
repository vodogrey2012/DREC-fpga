## PROGRAM "Quartus Prime"
## VERSION "Version 17.0.0 Build 595 04/25/2017 SJ Standard Edition"		
## DATE    "Wed May 10 14:03:25 2017"  		
##
## DEVICE  "EP4CGX15BF14C6"
##
#**************************************************************
# Time Information
#**************************************************************
set_time_format -unit ns -decimal_places 3  		
#**************************************************************
# Create Clock
#************************************************************** 		
create_clock -name {clk} -period 20.800 -waveform { 0.000 10.400 } [get_ports {clk}]

#**************************************************************
# Set Clock Uncertainty
#**************************************************************
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  

#**************************************************************
# Set resyncs
#************************************************************** 		
set_false_path -from [get_ports {btn1 btn2}]  -to [get_clocks {clk}]
set_max_delay -from btn1_sync[0]  -to btn1_sync[1] 10.000
set_max_delay -from btn2_sync[0]  -to btn2_sync[1] 10.000


#**************************************************************
# Output signals
#*************************************************************
set_false_path -from [get_clocks {clk}] -to [get_ports {led1 led2}] 
