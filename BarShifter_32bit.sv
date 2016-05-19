///////////////////////////////////////////////////////////////////////////////////////////////////
// Module: BarShifter_32bit.sv
// Project: Designing an ALU
// References: ftp://www.cs.uregina.ca/pub/class/301/guili/BarrelShPipeline.html
// Description: 32-bit shift register for EE469 lab 3
// Implmentation: Goal is to take input values and reorder the input bits by
// rotating them all by the specified 5 bit input control. The first stage
// takes the input and barrel shifts it right by 16 places or leaves it unchanged.
// The next stage shifts by 8, 4, 2, or 1. The total shift sum can be described as:
// 16 * Control(4) + 8 * Control(3) + 4 * Control(2) + 2 * Control(1) + 1* Control(0).
//
// TODO: make a testbench.
// Change history:
//
///////////////////////////////////////////////////////////////////////////////////////////////////
module BarShifter_32bit (output [31:0] out,
                        input [31:0] in,
                        input [4:0] SEL);
    wire [31:0] a;
    wire [31:0] b;
    wire [31:0] c;
    wire [31:0] d;

    assign d = SEL[0] ? {in [30:0], 1'b0} : in;
    assign c = SEL[1] ? {d [29:0], 2'b0} : d;
    assign b = SEL[2] ? {c [27:0], 4'b0} : c;
    assign a = SEL[3] ? {b [23:0], 8'b0} : b;
    assign out = SEL[4] ? {a [15:0], 16'b0} : a;

endmodule

module BarShifter_32bit_tb ();
    // Inputs
    reg [31:0] in;
    reg [4:0] SEL;

    //Outputs
    wire [31:0] out;

    BarShifter_32bit uut (out,
                          in,
                          SEL);

    initial begin
    $dumpfile("BarShifter_32bit_tb.vcd");

    in = 0; SEL = 0;
    #100
    // stimulus
    #10
    in = 32'b11111111111111111111111000000001;
    SEL = 5'b00000;
    #10
    in = 32'b11111100100011101100001010010101;
    SEL = 5'b00001;
    #10
    in = 32'b11111100100011101100001011110101;
    SEL = 5'b00010;
    #10
    in = 32'b00000000000000000000000111000001;
    SEL = 5'b00011;
    #10
    in = 32'b11111111111111111111111111111111;
    SEL = 5'b11111;

    end

    initial begin
 $monitor("time=",$time,, "in=%b SEL=%b : out=%b",
            in, SEL, out);
    end

endmodule
