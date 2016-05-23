///////////////////////////////////////////////////////////////////////////////
// Module: ShiftPToS.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Shifter that takes in an 8-bit parallel input and has 1-bit
// parallel output
// Implementation: Implemented in behavioral verilog.
//
// TODO: make a testbench. Do a sanity check.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module ShiftPToS(output sOut,
                 input [7:0] data,
                 input sIn,
                 input load,
                 input Clock,
				 input rst);

    reg [7:0] temp;

    // always block entered on posedge of the clock or load.
    // if there load line has a value then temp is assigned to 8-bit data
    // else top bit of temp is taken off and sIn is appended to temp
    always @(posedge Clock or posedge load) begin
		if (!rst)
			temp <= 8'bz;
        else if (load)
            temp <= data;
        else
            temp <= {temp[6:0], sIn};
    end
    // assign sOut temp
    assign sOut = temp[7];

endmodule

module ShiftPToS_tb();
    // Inputs
    reg [7:0] data;
	reg rst;
    reg sIn;
    reg load;
    reg Clock;

    // Outputs
    wire sOut;

    ShiftPToS uut (sOut,
                   data,
                   sIn,
                   load,
                   Clock,
				   rst);

    initial begin
    $dumpfile("ShiftPToS_tb.vcd");
    $dumpvars;
    end
    // Set up the clock.
    parameter CLOCK_PERIOD=2;
    initial Clock=1;
    initial data = 0;
    initial sIn = 0;
    initial load = 0;
    always begin
       #(CLOCK_PERIOD/2);
       Clock = ~Clock;
    end



   // Set up the inputs to the design. Each line is a clock cycle.
    initial begin

    rst <= 0; @(posedge Clock); rst <= 1; @(posedge Clock);

    data <= 8'b10000101; load <= 1; sIn <= 1;   @(posedge Clock);
                                                @(posedge Clock);
                                                @(posedge Clock);



    data <= 8'b01111111; load <= 0; sIn <= 0;	@(posedge Clock);
                                                @(posedge Clock);
                                                @(posedge Clock);


    data <= 8'b10101010; load <= 1; sIn <= 0;	@(posedge Clock);
                                                @(posedge Clock);
                                                @(posedge Clock);


    data <= 8'b11010010; load <= 0; sIn <= 1;   @(posedge Clock);
                                                @(posedge Clock);
                                                @(posedge Clock);

    data <= 8'b00010001; load <= 1; sIn <= 1;   @(posedge Clock);
                         load <= 0; sIn <= 1;   @(posedge Clock);

    $finish;
   end
endmodule
