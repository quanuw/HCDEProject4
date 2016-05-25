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

module BitSampleCount(output SROut,
                        output idEnable,
                        input enable,
                        input clk,
                        input rst);

    reg [3:0] count;
    reg startFlag;
    reg id;
    reg SRControl;

    always @(posedge clk) begin
        if (!rst) begin
            count <= 4'b000;
            SRControl <= 1'b0;
            id <= 1'b0;
        end else begin
            if (enable == 0 && ~startFlag) begin
                startFlag <= 1'b1;
                SRControl <= 0;
                id <= 0;
            end else if (startFlag && (count < 4'b1111)) begin
                startFlag <= 1'b1;
                count <= count + 1;

                if (count == 4'b0111) begin
                    SRControl <= 1'b1;
                end else if (count == 4'b1111) begin
							startFlag <= 1'b0;
					 end else begin
                    SRControl <= 1'b0;
                end
            end else begin
                SRControl <= 1'b0;
                id <= 1'b1;
                count <= 4'b0000;
                startFlag <= 1'b0;
            end
        end
    end

    assign idEnable = id;
    assign SROut = SRControl;

endmodule

/*
module BitSampleCounter_transmit_tb();
    // Inputs
    reg enable;
    reg clk;
    reg rst;

    // Outputs
    wire SROut;
    wire idEnable;

    BitSampleCounter_transmit bsc(dataOut,
                         idEnable,
                         enable,
                         clk,
                         rst);

    initial begin
    $dumpfile("BitSampleCounter_transmit_tb.vcd");
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
    rst <= 0; @(posedge clk)
    rst <= 1; @(posedge clk)

    enable <= 1; @(posedge clk)
    enable <= 0; @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)
    @(posedge clk)

    $finish;
    end
endmodule
*/
