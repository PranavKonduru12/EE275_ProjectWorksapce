`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 02:33:42 AM
// Design Name: 
// Module Name: testALU
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

//top Module
module ALU (                    
    input [31:0] a, b,         // 32-bit inputs a and b
    input [3:0] operation,     // 4-bit opcode for selecting operation
    input cin,                 // Carry in for add/sub
    output reg [31:0] result,      // 32-bit result
    output overflow, underflow, // Overflow and underflow flags
    output equal, less_than, less_than_equal, // Comparator outputs
    output carry_out           // Carry out for add/sub
);
    wire [31:0] sum, diff, mult;
    wire [31:0] and_res, or_res, xor_res, not_res;
    wire [31:0] cmp_res;
    wire cout_add, cout_sub;
    wire [31:0] diff;             /////////new wires 
    wire diff_sign;

    // Add (using full adder structure)
    fulladd32 add32(.sum(sum), .cout(cout_add), .a(a), .b(b), .cin(cin));

    // Subtract (using full adder structure with 2's complement)
    fulladd32 sub32(.sum(diff), .cout(cout_sub), .a(a), .b(~b), .cin(1'b1));  // For subtract, invert b and add 1

    // Multiply (using iterative addition or similar method)
    multiplier32 mult32(.product(mult), .a(a), .b(b));

    // Logical operations
    assign and_res = a & b;    // Use gate-level logic here         //AND(and_res, a, b)
    assign or_res = a | b;     // OR gate
    assign xor_res = a ^ b;    // XOR gate
    assign not_res = ~a;       // NOT gate

//    // Comparators
//    assign equal = (a == b);    // Equal
//    assign less_than = (a < b); // Less than
//    assign less_than_equal = (a <= b); // Less than or equal

    // Comparators
   // assign equal = (a == b);    // Equal
   assign equal = ~|(a ^ b); // XOR each bit and then NOR the result
   // assign less_than = (a < b); // Less than
   assign diff_sign = diff[31];  // The sign bit of the difference
   assign less_than = diff_sign; // If the result is negative, a < b
   //assign less_than_equal = (a <= b); // Less than or equal
   assign less_than_equal = less_than | equal;

    // Overflow/Underflow detection
    assign overflow = (a[31] == b[31]) && (sum[31] != a[31]);  // Detect overflow in addition
    assign underflow = (a[31] != b[31]) && (diff[31] != a[31]); // Detect underflow in subtraction



    // Select result based on operation code
    always @(*) begin
        case (operation)
            4'b0000: result = sum;              // Add
            4'b0001: result = diff;             // Subtract
            4'b0010: result = mult;             // Multiply
            4'b0011: result = and_res;          // AND
            4'b0100: result = or_res;           // OR
            4'b0101: result = xor_res;          // XOR
            4'b0110: result = not_res;          // NOT
            4'b0111: result = {31'b0, equal};   // Equal comparator
            4'b1000: result = {31'b0, less_than}; // Less than comparator
            4'b1001: result = {31'b0, less_than_equal}; // Less than or equal comparator
            default: result = 32'b0;
        endcase
    end

    assign carry_out = cout_add;

endmodule

////////////////////////////FullAdder32
//module fulladd32(
//    output [31:0] sum, 
//    output cout, 
//    input [31:0] a, b, 
//    input cin
//);
//    wire [31:0] carry;
    
    
    
//    // 32 instances of 1-bit full adder
//    fulladd fa0 (.sum(sum[0]), .cout(carry[0]), .a(a[0]), .b(b[0]), .cin(cin));
//    genvar i;
//    generate
//        for (i = 1; i < 32; i = i + 1) begin : adder_loop
//            fulladd fa (.sum(sum[i]), .cout(carry[i]), .a(a[i]), .b(b[i]), .cin(carry[i-1]));
//        end
//    endgenerate

//    assign cout = carry[31];
//endmodule

// 1-bit full adder module
//module fulladd(
//    output sum, cout, 
//    input a, b, cin
//);
//    wire s1, c1, c2;
    
//    xor (s1, a, b);
//    and (c1, a, b);
//    xor (sum, s1, cin);
//    and (c2, s1, cin);
//    or (cout, c1, c2);
//endmodule


//////////////////////
//module multiplier32(      //From before October 3
//    //output reg [31:0] product,
//    output [64:0] product,                               ///////////////////////////////<<<--
//    input [31:0] a, b
//);
//    wire [31:0] partial_products[31:0];
//    wire [31:0] sum[30:0];
//    wire [31:0] carry[30:0];

//    // Generate partial products
//    genvar i, j;
//    generate
//        for (i = 0; i < 32; i = i + 1) begin
//            for (j = 0; j < 32; j = j + 1) begin
//                assign partial_products[i][j] = a[i] & b[j];
//            end
//        end
//    endgenerate

//    // Add partial products
//    assign sum[0] = partial_products[0];
//    assign carry[0] = 32'b0;
    
//    generate
//        for (i = 1; i < 32; i = i + 1) begin : mult_loop
//            fulladd32 adder (.sum(sum[i]), .cout(carry[i]), .a(partial_products[i]), .b(sum[i-1]), .cin(carry[i-1]));
//        end
//    endgenerate

//    assign product = {carry[31], sum[31]};
//endmodule
//module multiplier32(      //From October 3
//    output [63:0] product,  // The product is 64 bits for a 32x32 multiplier
//    input [31:0] a, b
//);
//    wire [31:0] partial_products[31:0];
//    wire [31:0] sum[30:0];
//    wire [31:0] carry[30:0];

//    // Generate partial products
//    genvar i, j;
//    generate
//        for (i = 0; i < 32; i = i + 1) begin
//            for (j = 0; j < 32; j = j + 1) begin
//                assign partial_products[i][j] = a[i] & b[j];
//            end
//        end
//    endgenerate

//    // Add partial products
//    assign sum[0] = partial_products[0];
//    assign carry[0] = 32'b0;
    
//    generate
//        for (i = 1; i < 32; i = i + 1) begin : mult_loop
//            fulladd32 adder (.sum(sum[i]), .cout(carry[i]), .a(partial_products[i]), .b(sum[i-1]), .cin(carry[i-1]));
//        end
//    endgenerate

//    // Combine the final sum and carry to form the full 64-bit product
//    assign product = {carry[31], sum[31]}; // Concatenate carry and sum for full result
//endmodule
////new multiplier
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

