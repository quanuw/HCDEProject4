///////////////////////////////////////////////////////////////////////////////
// Module: ShiftPToS.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Shifter that takes in an 8-bit parallel input and has 1-bit
// parallel output
// Implmentation: Implemented in behavioral verilog.
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module ShiftPToS(output sOut,
                 input [7:0] data,
                 input sIn,
                 input load,
                 input clk);

    reg [7:0] temp;

    // always block entered on posedge of the clock or load.
    // if there load line has a value then temp is assigned to 8-bit data
    // else top bit of temp is taken off and sIn is appended to temp
    always @(posedge clk or posedge load) begin
        if (load)
            temp = data;
        else
            temp = {temp[6:0], sIn};
    end
    // assign sOut temp
    assign sOut = temp[7];

endmodule
