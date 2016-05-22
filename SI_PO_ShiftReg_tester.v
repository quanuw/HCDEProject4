module SI_PO_ShiftReg_tester (Clock, SI, rst, latch); 
	output reg Clock, SI, rst, latch;
	
	// Set up the clock.
	parameter CLOCK_PERIOD=2;
	initial Clock=1;
	always begin
		#(CLOCK_PERIOD/2);
		Clock = ~Clock;
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
		rst <= 1;					@(posedge Clock);
		rst <= 0;					@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 1;						@(posedge Clock);			
										@(posedge Clock);
		SI <= 0;						@(posedge Clock);
		SI <= 1;						@(posedge Clock);
	
										@(posedge Clock);
		SI <= 1;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 1;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 0;						@(posedge Clock);	
										@(posedge Clock);
		SI <= 1;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 1;						@(posedge Clock);
		SI <= 0;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 0;						@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
		SI <= 0;						@(posedge Clock);
		SI <= 1;						@(posedge Clock);
		latch <= 1;					@(posedge Clock);
		latch <= 0;					@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);
										@(posedge Clock);

	end
endmodule