`include "SI_PO_ShiftReg.v"
`include "SI_PO_ShiftReg_tester.v"

module SI_PO_ShiftReg_testbench();

	wire Clock, SI, rst; 
	wire [7:0] PO;
	
	// Calls the 1 bit counter tester module 
	// Notice that the output Clock, Reset, Increase of the tester module are wires Clock, Reset, Increase in this module
	SI_PO_ShiftReg_tester t(.Clock(Clock), .SI(SI), .rst(rst)); 
	
	// Calls the 1 bit counter module as the device under test (dut)
	// Notice that the Clock, Reset, and Increase are wired to the input of the 1 bit counter module  
	SI_PO_ShiftReg dut(.clk(Clock), .rst(rst), .SI(SI), .PO(PO)); 
	
	// Dumps the results of the simulation into a .vcd file for view in GTKWave
	initial begin 
		$dumpfile("SI_PO_ShiftReg.vcd");
		$dumpvars(0, SI_PO_ShiftReg_testbench);
		#150;
		$finish;
	end 
	
endmodule 