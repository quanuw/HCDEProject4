///////////////////////////////////////////////////////////////////////////////
// Module: StartDetect.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Shifter that takes in 1-bit serial inputs and detects the 4-bit
// 0000 start nibble.
// Implmentation: Implemented in behavioral verilog.
//
// TODO: Full sanity check on testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module StartDetect(output [3:0] enable,
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

    assign enable = temp;

endmodule

module StartDetect_tb();
    // Inputs
    reg sIn;
    reg clk;
    reg rst;

    // Outputs
    wire [3:0] enable;

    StartDetect sd(enable,
                   sIn,
                   clk,
                   rst);

   initial begin
   $dumpfile("StartDetect_tb.vcd");
   $dumpvars;
   end
   // Set up the clock.
   parameter CLOCK_PERIOD=2;
   initial clk=1;
   initial sIn = 0;
   initial rst = 0;
   always begin
       #(CLOCK_PERIOD/2);
       clk = ~clk;
   end



   // Set up the inputs to the design. Each line is a clock cycle.
   initial begin
   sIn <= 1; rst <= 1;  @(posedge clk);

   sIn <= 0; rst <= 1;  @(posedge clk);

   sIn <= 1; rst <= 1;  @(posedge clk);

   sIn <= 0; rst <= 0;  @(posedge clk);

   sIn <= 1; rst <= 1;  @(posedge clk);

    $finish;
   end
endmodule
