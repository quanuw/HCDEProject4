///////////////////////////////////////////////////////////////////////////////
// Module: BitSampleCounter.sv
// Project: Extending a Simple Microprocessor
// References:
// Description: Counter for char detection.
// Implmentation: Implemented in behavioral verilog.
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////

module BSD(output dataOut,
           output idEnable,
           input dataIn,
           input [3:0] enable,
           input clk);

    reg [3:0] count;
    reg startFlag;

    always @(posedge clk) begin
        if (enable == 4'b0000)
            startFlag <= 1'b1;
            if (startFlag or count < 4'b1111) begin
                dataOut <= dataIn;
                count <= count + 1;
            end else begin
                idEnable <= 1'b1;
                count <= 4'b0000;
                enable <= 4'b1111;
                startFlag <= 1'b0;
            end
        end
    end
endmodule
