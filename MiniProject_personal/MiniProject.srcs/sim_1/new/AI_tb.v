`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2024 12:51:55 AM
// Design Name: 
// Module Name: AI_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_TwoBitAdder;

// Inputs
reg A0, B0, A1, B1, Cin;

// Outputs
wire S0, S1, Cout;

// Instantiate the Unit Under Test (UUT)
TwoBitAdder uut (
    .A0(A0), 
    .B0(B0), 
    .A1(A1), 
    .B1(B1), 
    .Cin(Cin), 
    .S0(S0), 
    .S1(S1), 
    .Cout(Cout)
);

initial begin
    // Display header for output
    //$display("A0 B0 A1 B1 Cin | S0 S1 Cout");

    // Apply test vectors
    A0 = 0; B0 = 0; A1 = 0; B1 = 0; Cin = 0;
    #10 //$display("%b  %b  %b  %b  %b   | %b  %b  %b", A0, B0, A1, B1, Cin, S0, S1, Cout);

    A0 = 0; B0 = 1; A1 = 0; B1 = 1; Cin = 0;
    #10 //$display("%b  %b  %b  %b  %b   | %b  %b  %b", A0, B0, A1, B1, Cin, S0, S1, Cout);

    A0 = 1; B0 = 0; A1 = 1; B1 = 0; Cin = 1;
    #10 //$display("%b  %b  %b  %b  %b   | %b  %b  %b", A0, B0, A1, B1, Cin, S0, S1, Cout);

    A0 = 1; B0 = 1; A1 = 1; B1 = 1; Cin = 1;
    #10 //$display("%b  %b  %b  %b  %b   | %b  %b  %b", A0, B0, A1, B1, Cin, S0, S1, Cout);

    A0 = 0; B0 = 1; A1 = 1; B1 = 0; Cin = 1;
    #10 //$display("%b  %b  %b  %b  %b   | %b  %b  %b", A0, B0, A1, B1, Cin, S0, S1, Cout);

    // Add more test cases if necessary

    $finish;
end

endmodule

