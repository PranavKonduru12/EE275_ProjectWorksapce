`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 03:49:34 PM
// Design Name: 
// Module Name: mult_32
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


//module multiplier32 (       //New mult using registers
//    output reg [31:0] product,
//    input [31:0] a, b
//);
//    reg [63:0] temp_product; // To store the intermediate product
//    reg [31:0] multiplicand;
//    reg [31:0] multiplier;
//    integer i;

//    always @(*) begin
//        temp_product = 64'b0;
//        multiplicand = a;
//        multiplier = b;

//        // Iterative shift-and-add multiplication
//        for (i = 0; i < 32; i = i + 1) begin
//            if (multiplier[i] == 1'b1) begin
//                temp_product = temp_product + (multiplicand << i);
//            end
//        end

//        product = temp_product[31:0]; // Get the lower 32 bits as the product
//    end
//endmodule
//module multiplier32 (       //mult with boolean logic but not 64
//    output [31:0] product,
//    input [31:0] a, b
//);
//    wire [31:0] partial_products[31:0];  // Array of partial products
//    wire [31:0] sum[31:0];               // Array for summing partial products
//    wire [31:0] carry[31:0];             // Array for carries

//    genvar i, j;
//    generate
//        // Generate partial products using AND gates
//        for (i = 0; i < 32; i = i + 1) begin
//            for (j = 0; j < 32; j = j + 1) begin
//                assign partial_products[i][j] = a[i] & b[j];  // AND gate for partial product
//            end
//        end
//    endgenerate

//    // Summing the partial products using fulladd32 for bitwise addition
//    assign sum[0] = partial_products[0]; // Initial partial product
//    assign carry[0] = 32'b0; // No carry initially

//    generate
//        for (i = 1; i < 32; i = i + 1) begin : mult_loop
//            fulladd32 adder (
//                .sum(sum[i]), 
//                .cout(carry[i]), 
//                .a(partial_products[i]), 
//                .b(sum[i-1]), 
//                .cin(carry[i-1])
//            );
//        end
//    endgenerate

//    assign product = sum[31];  // Final product from the sum of partial products
//endmodule
module multiplier32 (
    output [63:0] product,  // 64-bit product for 32-bit multiplication
    input [31:0] a, b
);
    wire [63:0] partial_products[31:0];  // 64-bit partial products
    wire [63:0] sum[31:0];               // 64-bit sums for accumulation
    wire [63:0] carry[31:0];             // 64-bit carry for summing

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
            //assign partial_products[i][i-1:0] = 0;  // Shift lower bits of partial products
        end
    endgenerate

    // Summing the partial products using a carry-save adder
    assign sum[0] = partial_products[0];  // Initial sum
    assign carry[0] = 64'b0;              // Initial carry is zero

    generate
        for (i = 1; i < 32; i = i + 1) begin : mult_loop
            fulladd32 adder (
                .sum(sum[i]), 
                .cout(carry[i]), 
                .a(partial_products[i]), 
                .b(sum[i-1]), 
                .cin(carry[i-1])
            );
        end
    endgenerate

    assign product = sum[31] + carry[31];  // Combine the final sum and carry to form the product
endmodule
