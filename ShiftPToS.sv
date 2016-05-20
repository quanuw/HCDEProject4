///////////////////////////////////////////////////////////////////////////////
// Module: ShiftPToS.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Shifter that takes in an 8-bit parallel input and has 1-bit
// parallel output
// Implmentation: Implemented in behavioral verilog.
//
// TODO: make a testbench. Do a sanity check.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module ShiftPToS(output sOut,
                 input [7:0] data,
                 input sIn,
                 input load,
                 input Clock);

    reg [7:0] temp;

    // always block entered on posedge of the clock or load.
    // if there load line has a value then temp is assigned to 8-bit data
    // else top bit of temp is taken off and sIn is appended to temp
    always @(posedge Clock or posedge load) begin
        if (load)
            temp = data;
        else
            temp = {temp[6:0], sIn};
    end
    // assign sOut temp
    assign sOut = temp[7];

endmodule

module ShiftPToS_tb();
    // Inputs
    reg [7:0] data;
    reg sIn;
    reg load;
    reg Clock;

    // Outputs
    wire sOut;

    ShiftPToS uut (sOut,
                   data,
                   sIn,
                   load,
                   Clock);

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
    data <= 5; load <= 1; sIn <= 1; @(posedge Clock);




    data <= 3; load <= 0; sIn <= 0;	@(posedge Clock);



    data <= 7; load <= 1; sIn <= 0;	@(posedge Clock);



    data <= 6; load <= 0; sIn <= 1; @(posedge Clock);


    data <= 6; load <= 1; sIn <= 1; @(posedge Clock);

    $finish;
   end
endmodule
