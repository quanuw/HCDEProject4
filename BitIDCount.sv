///////////////////////////////////////////////////////////////////////////////
// Module: BitIDCount.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: A counter that keeps track of how many bits have been sent to
// the NIOS II processor. Count increments when enable from Bit Sample Counter
// goes to a logical 1. After the counter reaches 10 indicating that 10 bits
// have been sampled, the signal charReceived will go to a logical 1.
// Implmentation: Implemented in behavioral verilog.
//
// TODO: Full sanity check on testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module BitIDCount (output charReceived,
                   input enable,
                   input clk,
                   input rst);
    reg [2:0] count;
    reg isReceived;

    always @(posedge clk) begin
        if (!rst) begin
            isReceived <= 0;
            count <= 0;
        end else begin
            if (enable && count < 8) begin
                isReceived <= 0;
                count <= count + 1;
            end else if (~enable && count < 8) begin
                isReceived <= 0;
                count <= count;
            end else begin
                isReceived <= 1;
                count <= 0;
            end
        end
    end

    assign charReceived = isReceived;

endmodule

module BitIDCount_tb();
    // Outsputs
    wire charReceived;

    // Inputs
    reg enable;
    reg clk;
    reg rst;

    BitIDCount dut (charReceived,
                    enable,
                    clk,
                    rst);

    initial begin
    $dumpfile("BitIDCount_tb.vcd");
    $dumpvars;
    end
    // Set up the clock.
    parameter CLOCK_PERIOD=2;
    initial clk=1;
    initial enable = 0;
    always begin
       #(CLOCK_PERIOD/2);
       clk = ~clk;
    end

   // Set up the inputs to the design. Each line is a clock cycle.
    initial begin

    rst <= 0; @(posedge clk);
    rst <= 1; @(posedge clk);

    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);

    enable <= 0; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 0; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);
    enable <= 1; @(posedge clk);

    $finish;
   end
endmodule
