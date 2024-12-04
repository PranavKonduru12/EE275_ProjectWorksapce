`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 05:12:31 PM
// Design Name: 
// Module Name: cla_24bits_tb
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


`timescale 1ns / 1ps

module cla_24bit_tb;

    // Inputs
    reg [23:0] a;
    reg [23:0] b;
    reg cin;

    // Outputs
    wire [23:0] sum;
    wire carry_out;

    // Instantiate the DUT (Device Under Test)
    cla_24bit uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry_out(carry_out)
    );

    // Task to display results
    task display_results;
        input [23:0] a;
        input [23:0] b;
        input cin;
        input [23:0] sum;
        input carry_out;
        begin
            $display("a: %h, b: %h, cin: %b => sum: %h, carry_out: %b", 
                     a, b, cin, sum, carry_out);
        end
    endtask

    // Stimulus
    initial begin
        // Test Case 1: Zero inputs
        a = 24'h000000; b = 24'h000000; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 2: Add two small numbers
        a = 24'h000001; b = 24'h000001; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 3: Add with carry-in
        a = 24'h000001; b = 24'h000001; cin = 1;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 4: Add with carry-out
        a = 24'hFFFFFF; b = 24'h000001; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 5: Maximum inputs
        a = 24'hFFFFFF; b = 24'hFFFFFF; cin = 1;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 6: Random input 1
        a = 24'hABCDE0; b = 24'h123456; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 7: Random input 2
        a = 24'h0F0F0F; b = 24'hF0F0F0; cin = 1;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 8: Add with zero carry-in
        a = 24'h100000; b = 24'h100000; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // Test Case 9: Add with alternating bits
        a = 24'hAAAAAAAA; b = 24'h555555; cin = 0;
        #10 display_results(a, b, cin, sum, carry_out);

        // End of simulation
        $finish;
    end

endmodule

