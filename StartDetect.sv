///////////////////////////////////////////////////////////////////////////////
// Module: StartDetect.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Shifter that takes in 1-bit serial inputs and detects the 4-bit
// 0000 start nibble.
// Implmentation: Implemented in behavioral verilog.
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module StartDetect(output enable,
                   input sIn,
                   input clk,
                   input rst);
    reg [3:0] temp;

    always @(posedge clk) begin
        if (!rst)
            temp <= 4'bZ;
        else
            temp <= {temp[2:0], sIn};
    end

    assign pOut = temp;

endmodule
