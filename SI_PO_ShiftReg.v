///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: SI_PI_ShiftReg.v
// Project: Serial in Parallel Out Shift Register
// References: http://www.csit-sun.pub.ro/courses/Masterat/Xilinx%20Synthesis%20Technology/toolbox.xilinx.com/docsan/xilinx4/data/docs/xst/hdlcode8.html
// Description: Serial in 8-bit parallel out shift register
// Implmentation: Goal is to shift in input values and make an accessible 8-bit parallel out
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////

module SI_PO_ShiftReg (clk, rst, SI, PO); 
	input  clk, rst, SI; 
	output [7:0] PO; 
	reg [9:0] tmp; 
 
	always @(posedge clk) 
	
	begin
		if (!rst) begin
			tmp = 10'bx;
		end else begin
			tmp = {tmp[8:0], SI}; // Shift in the 1-bit input value 
		end
	end 
	
	assign PO = tmp[8:1];
	
endmodule 

