`include "BitSampleCount_Receive.sv"
`include "BitSampleCount_Receive_tester.v"

module BitSampleCount_Receive_testbench();

	wire Clock, rst, enable, SRControl; 
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	BitSampleCount_Receive_tester t(.Clock(Clock), .rst(rst), .enable(enable)); 
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	BitSampleCount_Receive dut(.clk(Clock), .rst(rst), .enable(enable), .RControl(RControl)); 
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("BitSampleCount_Receive.vcd");
		$dumpvars(0, BitSampleCount_Receive_testbench);
		#150;
		$finish;
	end 
	
endmodule 