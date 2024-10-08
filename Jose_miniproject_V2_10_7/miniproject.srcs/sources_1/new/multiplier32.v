`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 10:06:48 PM
// Design Name: 
// Module Name: multiplier32
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


module multiplier32 (
    output [63:0] product,  // 64-bit product for 32-bit multiplication
    input [31:0] a, b
);
    wire [63:0] partial_products[31:0];  // 64-bit partial products
    wire [31:0] sum_lower[31:0], sum_upper[31:0];  // Lower and upper 32-bit sums
    wire [31:0] carry_lower[31:0], carry_upper[31:0];  // Lower and upper 32-bit carries

    genvar i, j;
    generate
        // Generate partial products using AND gates and shift them by i bits
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                assign partial_products[i][j + i] = a[i] & b[j];  // AND gate for partial product and shift by i bits
            end
            if (i > 0) begin
                assign partial_products[i][i-1:0] = 0;  // Shift lower bits of partial products
            end
        end
    endgenerate

    // Summing the partial products using two 32-bit adders for 64-bit addition
    assign sum_lower[0] = partial_products[0][31:0];  // Initial lower 32 bits
    assign sum_upper[0] = partial_products[0][63:32]; // Initial upper 32 bits
    assign carry_lower[0] = 32'b0;  // Initial carry for lower 32 bits is zero
    assign carry_upper[0] = 32'b0;  // Initial carry for upper 32 bits is zero

    generate
        for (i = 1; i < 32; i = i + 1) begin : mult_loop
            // Lower 32-bit addition using fulladd32
            fulladd32 adder_lower (
                .sum(sum_lower[i]), 
                .cout(carry_lower[i]), 
                .a(partial_products[i][31:0]), 
                .b(sum_lower[i-1]), 
                .cin(carry_lower[i-1])
            );

            // Upper 32-bit addition using fulladd32 with carry from lower adder
            fulladd32 adder_upper (
                .sum(sum_upper[i]), 
                .cout(carry_upper[i]), 
                .a(partial_products[i][63:32]), 
                .b(sum_upper[i-1]), 
                .cin(carry_lower[i])
            );
        end
    endgenerate

    // Combine lower and upper sums to form the final product
    assign product = {sum_upper[31], sum_lower[31]};  // Concatenate upper and lower 32-bit sums
endmodule
