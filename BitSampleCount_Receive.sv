
///////////////////////////////////////////////////////////////////////////////
// Module: BitSampleCounter.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Counter for char detection.
// Implmentation: Implemented in behavioral verilog.
//
// TODO: Data is not being sent out. Check If else logic.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module BitSampleCount_Receive(output reg RControl,
                        output reg BICincrement,
                        input enable,
                        input clk,
                        input rst);
	
	reg [3:0] count;
	
	
	always@(*) begin	
	
		if(count == 4'b0111) begin
			RControl = 1;
		end else if (RControl == 1) begin
			RControl = 0;
		end
		
		if(count == 4'b1111) begin
			BICincrement = 1;
		end else if (BICincrement == 1) begin
			BICincrement = 0;
		end
		
	end 
	
	always@(posedge clk)
	if (!rst) begin
		count <= 0;
		RControl <= 0;
		BICincrement <= 0;
	end else if (rst && enable) begin   
		count <= count + 1; 		
    end				

endmodule
