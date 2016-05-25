
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

module BitSampleCount(output reg SRControl,
                        output reg BICincrement,
                        input enable,
                        input clk,
                        input rst);
	
	reg [3:0] count;
	
	always@(*) begin	
	
		if (!rst)begin
			SRControl = 0;	
		end else if(rst && count == 4'b0111) begin
			SRControl = 1;
		end else if (rst && SRControl == 1) begin
			SRControl = 0;
		end
		
		if (!rst) begin
			BICincrement = 0;
		end else if(rst && count == 4'b1111) begin
			BICincrement = 1;
		end else if (rst && BICincrement == 1) begin
			BICincrement = 0;
		end
		
	end 
	
	always@(posedge clk)
	if (!rst) begin
		count <= 0;
	end else if (rst && enable) begin   // binary 9
		count <= count + 1; 		// equivalent to "0000"
    end				

endmodule
