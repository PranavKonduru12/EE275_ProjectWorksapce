`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2024 12:08:32 PM
// Design Name: 
// Module Name: ALU
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
    wire diff_sign;               
    
    // Add (using full adder structure)
    fulladd32 add32(.sum(sum), .cout(cout_add), .a(a), .b(b), .cin(cin));

    // Subtract (using full adder structure with 2's complement)
    fulladd32 sub32(.sum(diff), .cout(cout_sub), .a(a), .b(~b), .cin(1'b1));  // For subtract, invert b and add 1

    // Multiply (using iterative addition or similar method)
    multiplier32 mult32(.product(mult), .a(a), .b(b));

    // Logical operations
    assign and_res = a & b;    // Use gate-level logic here
    assign or_res = a | b;     // OR gate
    assign xor_res = a ^ b;    // XOR gate
    assign not_res = ~a;       // NOT gate

    // Comparators
    // Equal
   assign equal = ~|(a ^ b); // XOR each bit and then NOR the result
   // Less than
   assign diff_sign = diff[31];  // The sign bit of the difference
   assign less_than = diff_sign; // If the result is negative, a < b
   // Less than or equal
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
// Full Adder for 32-bit addition
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

////////////////**************************************************************
//// 1-bit full adder module
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


///////////////////****************************************************************
//module multiplier32 (
//    output [63:0] product,  // 64-bit product for 32-bit multiplication
//    input [31:0] a, b
//);
//    wire [63:0] partial_products[31:0];  // 64-bit partial products
//    wire [31:0] sum_lower[31:0], sum_upper[31:0];  // Lower and upper 32-bit sums
//    wire [31:0] carry_lower[31:0], carry_upper[31:0];  // Lower and upper 32-bit carries

//    genvar i, j;
//    generate
//        // Generate partial products using AND gates and shift them by i bits
//        for (i = 0; i < 32; i = i + 1) begin
//            for (j = 0; j < 32; j = j + 1) begin
//                assign partial_products[i][j + i] = a[i] & b[j];  // AND gate for partial product and shift by i bits
//            end
//            if (i > 0) begin
//                assign partial_products[i][i-1:0] = 0;  // Shift lower bits of partial products
//            end
//        end
//    endgenerate

//    // Summing the partial products using two 32-bit adders for 64-bit addition
//    assign sum_lower[0] = partial_products[0][31:0];  // Initial lower 32 bits
//    assign sum_upper[0] = partial_products[0][63:32]; // Initial upper 32 bits
//    assign carry_lower[0] = 32'b0;  // Initial carry for lower 32 bits is zero
//    assign carry_upper[0] = 32'b0;  // Initial carry for upper 32 bits is zero

//    generate
//        for (i = 1; i < 32; i = i + 1) begin : mult_loop
//            // Lower 32-bit addition using fulladd32
//            fulladd32 adder_lower (
//                .sum(sum_lower[i]), 
//                .cout(carry_lower[i]), 
//                .a(partial_products[i][31:0]), 
//                .b(sum_lower[i-1]), 
//                .cin(carry_lower[i-1])
//            );

//            // Upper 32-bit addition using fulladd32 with carry from lower adder
//            fulladd32 adder_upper (
//                .sum(sum_upper[i]), 
//                .cout(carry_upper[i]), 
//                .a(partial_products[i][63:32]), 
//                .b(sum_upper[i-1]), 
//                .cin(carry_lower[i])
//            );
//        end
//    endgenerate

//    // Combine lower and upper sums to form the final product
//    assign product = {sum_upper[31], sum_lower[31]};  // Concatenate upper and lower 32-bit sums
//endmodule



///////=============================part2================================
///////////////////////////////registerfile
//module RegisterFile (
//    input clk,                              // Clock signal
//    input [3:0] read_reg1, read_reg2,       // Register numbers to read
//    input [3:0] write_reg,                  // Register number to write
//    input [31:0] write_data,                // Data to write to the register
//    input reg_write,                        // Enable register write
//    input [4:0] cc_flags,                   // Condition Code flags from ALU (Overflow, Underflow, etc.)
//    output wire [31:0] reg_data1, reg_data2 // Data read from registers
////    output reg [31:0] pc,                   // Program Counter (R0)
////    output reg [31:0] sp                    // Stack Pointer (R1)
//);

//    // 16 32-bit registers
//    reg [31:0] registers [15:0];

//    // Condition Code (CC) register: [Overflow, Underflow, Equal, LessThan, LessThanEqual]
//    reg [4:0] cc_register;
    
////    /////////////****
//    integer i;
//    initial begin
//        for (i=0;i<15;i=i+1)
//        registers[i] = 0;
//    end
////    ////////////***************


//    // Update Condition Code register on clock edge
//    always @(posedge clk) begin
//        cc_register <= cc_flags;  // Store ALU flags into the Condition Code register
////        registers[3] <= 3;
////        registers[4] <= 3;

//    end

//    // Register write operation, but do not overwrite R0 (PC) or R1 (SP) directly
//    always @(posedge clk) begin
//        if (reg_write && write_reg != 4'b0000 && write_reg != 4'b0001) begin
//            registers[write_reg] <= write_data;  // Write to the register
//        end
//    end

//    // R0 as Program Counter (PC) and R1 as Stack Pointer (SP)
////    assign reg_data1 = (read_reg1 == 4'b0000) ? pc : (read_reg1 == 4'b0001) ? sp : registers[read_reg1];
////    assign reg_data2 = (read_reg2 == 4'b0000) ? pc : (read_reg2 == 4'b0001) ? sp : registers[read_reg2];
//    assign reg_data1 = registers[read_reg1];
//    assign reg_data2 = registers[read_reg2];

//endmodule



////////////////////////////////////////////////////////////////////////////////CPU

//module CPU (
//    input clk,                                 // Clock signal
//    input [31:0] instruction,                  // Input instruction (for simplicity, loaded directly)
//    output [31:0] result                       // Result of the operation
//);
   
//    wire [31:0] reg_data1, reg_data2;            // Register values read from the Register File
//    wire [31:0] alu_result;                      // ALU result
//    reg [31:0] memory_data;                      // To handle memory-related operations
//    reg reg_write;                              // Enable register write
//    reg [31:0] memory [0:255];                  // Simple memory (256 words)
    
//    wire [4:0] cc_flags;                        // Condition Code flags from ALU (overflow, underflow, etc.)
//    wire [5:0] opcode = instruction[31:26];     // OpCode: bits 31-26
//    wire [4:0] rd = instruction[25:21];         // Destination register: bits 25-21
//    wire [4:0] rs1 = instruction[20:16];        // Source register 1: bits 20-16
//    wire [4:0] rs2 = instruction[15:11];        // Source register 2: bits 15-11
//    wire [10:0] immediate = instruction[10:0];  // Immediate/Address: bits 10-0
    
//    // Instantiate Register File
//    RegisterFile regfile (
//        .clk(clk),
//        .read_reg1(rs1), 
//        .read_reg2(rs2), 
//        .write_reg(rd), 
//        .write_data(alu_result), 
//        .reg_write(reg_write), 
//        .reg_data1(reg_data1), 
//        .reg_data2(reg_data2),
//        .cc_flags(cc_flags)                     // Pass CC flags to Register File
//    );
    
//    // Instantiate ALU
//    ALU alu (
//        .a(reg_data1),
//        .b(reg_data2),
//        .operation(opcode[3:0]),     // The lower 4 bits of the opcode are passed to the ALU for operation
//        .cin(1'b0),                  // Carry-in is 0 for now
//        .result(alu_result),
//        .overflow(cc_flags[4]),      // Overflow flag
//        .underflow(cc_flags[3]),     // Underflow flag
//        .equal(cc_flags[2]),         // Equal flag
//        .less_than(cc_flags[1]),     // Less than flag
//        .less_than_equal(cc_flags[0]), // Less than or equal flag
//        .carry_out()                 // Not used for now
//    );
    
//    // Decode and Execute logic
//    always @(posedge clk) begin
//        case (opcode)
//            6'b000000: begin // ADD
//                // ALU will perform addition, result will be in alu_result
//                reg_write <= 1;  // Enable register write
//            end
//            6'b000001: begin // SUB
//                // ALU will perform subtraction
//                reg_write <= 1;  // Enable register write
//            end
//            6'b000010: begin // MULT
//                // ALU will perform multiplication
//                reg_write <= 1;  // Enable register write
//            end
//            6'b000011: begin // AND
//                // ALU will perform bitwise AND
//                reg_write <= 1;
//           end
//           6'b000100: begin // OR
//                // ALU will perform bitwise OR
//                reg_write <= 1;
//           end
//           6'b000101: begin // XOR
//                reg_write <= 1;
//           end
//           6'b000110: begin // NOT
//                reg_write <= 1;
//           end            
//           6'b000111: begin // LOAD (Immediate Mode)
//            // Memory read operation using immediate value
//            memory_data <= memory[immediate];  // Load from memory address in 'immediate'
//            reg_write <= 1;
//            end
//            6'b001000: begin // STORE (Immediate Mode)
//            // Memory write operation using immediate value
//            memory[immediate] <= reg_data1;  // Store reg_data1 into memory
//            reg_write <= 0;
//            end
//            6'b001001: begin // JMP (Unconditional Jump)
//                 // Jump to address in reg_data1 (Rs1)
//                 // Not implemented in this simple design
//            end
//            6'b001010: begin // Conditional Jump (JLT)
//                 if (cc_flags[1]) begin  // If LessThan flag is set
//                     // Jump to address in reg_data1 (Rs1)
//                     // Not implemented in this simple design
//                 end
//            end
//            6'b001011: begin // CALL Procedure
//                  // Decrement Stack Pointer
//                  // Save PC and call procedure at address in reg_data1 (Rs1)
//                  // Not implemented in this simple design
//            end
//            6'b001100: begin // RET (Return from Procedure)
//                  // Restore PC from stack
//                  // Not implemented in this simple design
//            end
            
//            default: begin
//                reg_write <= 0;  // Do nothing for unrecognized OpCode
//            end
//        endcase
//    end
    
//    // Output the final result, either from the ALU or memory read
//    assign result = (opcode == 6'b000111) ? memory_data : alu_result;

//endmodule



