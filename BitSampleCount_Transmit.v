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

module BitSampleCount_Transmit(
						output reg SRControl,
						input reset,
                        input enable,
                        input clk);
	
	/*
    reg psTransmitControl;
	reg nsTransmitControl;
	*/
	reg [3:0] count;
	reg startFlag;
    
	always @(posedge clk or negedge clk) begin
		if (!reset) begin
			SRControl = 0;
		end else if (enable) begin
            startFlag <= 1'b1;
        end else if (startFlag && (count < 4'b1111)) begin
            startFlag <= 1'b1;
            count <= count + 1;
            SRControl <= ~SRControl;
        end else if (SRControl == 1 && (count == 4'b1111)) begin
			SRControl <= ~SRControl;	
		end else begin
            count <= 4'b0000;
            startFlag <= 1'b0;
        end 

    end
	/*
	always@(*) begin
	
		case (enable) 
		
			1: begin 
				if(psTransmitControl == 1) begin
					nsTransmitControl = 0;
					count = count + 1;
				end else if(psTransmitControl == 0) begin
					nsTransmitControl = 1;
				end
			end 
				
			0: begin 
				nsTransmitControl = 0;
			end 
			
		endcase
	
		
	end 
		
	assign SRControl = psTransmitControl;
	
    always @(posedge clk) begin
	
        if (!reset) begin
            psTransmitControl <= 1'b0;
        end 
		
		else begin
			psTransmitControl <= nsTransmitControl;
		end 
		
    end
	*/
endmodule
