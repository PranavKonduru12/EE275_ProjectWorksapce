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

//////////////////////////////FullAdder32
 //Full Adder for 32-bit addition
module fulladd32(
    output [31:0] sum, 
    output cout, 
    input [31:0] a, b, 
    input cin
);
    wire [31:0] carry;
    
    // 32 instances of 1-bit full adder
    fulladd fa0 (.sum(sum[0]), .cout(carry[0]), .a(a[0]), .b(b[0]), .cin(cin));
    genvar i;
    generate
        for (i = 1; i < 32; i = i + 1) begin : adder_loop
            fulladd fa (.sum(sum[i]), .cout(carry[i]), .a(a[i]), .b(b[i]), .cin(carry[i-1]));
        end
    endgenerate

    assign cout = carry[31];
endmodule

//////////////////**************************************************************
//// 1-bit full adder module
module fulladd(
    output sum, cout, 
    input a, b, cin
);
    wire s1, c1, c2;
    
    xor (s1, a, b);
    and (c1, a, b);
    xor (sum, s1, cin);
    and (c2, s1, cin);
    or (cout, c1, c2);
endmodule


///////////////////////****************************************************************
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



/////////=============================part2================================
/////////////////////////////////registerfile
module RegisterFile (
    input clk,                              // Clock signal
    input reset,                            // Reset signal
    input [3:0] read_reg1, read_reg2,       // Register numbers to read
    input [3:0] write_reg,                  // Register number to write
    input [31:0] write_data,                // Data to write to the register
    input reg_write,                        // Enable register write
    input [4:0] cc_flags,                   // Condition Code flags from ALU (Overflow, Underflow, etc.)
    output wire [31:0] reg_data1, reg_data2, // Data read from registers
    output reg [31:0] pc,                   // Program Counter (R0)
    output reg [31:0] sp                    // Stack Pointer (R1)
);

    // 16 32-bit registers
    reg [31:0] registers [15:0];

    // Condition Code (CC) register: [Overflow, Underflow, Equal, LessThan, LessThanEqual]
    reg [4:0] cc_register;
    
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1)
            registers[i] = 0;
        pc = 0;
        sp = 0;
    end

    // Update Condition Code register on clock edge
    always @(posedge clk) begin
        cc_register <= cc_flags;  // Store ALU flags into the Condition Code register
    end

    // Program Counter (PC) and Stack Pointer (SP) handling
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 0;  // Reset PC to 0
            sp <= 0;  // Reset SP to 0
        end else begin
            pc <= pc + 1;  // Increment PC after each instruction
        end
    end

    // Register write operation, but do not overwrite R0 (PC) or R1 (SP) directly
    always @(posedge clk) begin
        if (reg_write && write_reg != 4'b0000 && write_reg != 4'b0001) begin
            registers[write_reg] <= write_data;  // Write to the register
        end
    end

    // R0 as Program Counter (PC) and R1 as Stack Pointer (SP)
    assign reg_data1 = (read_reg1 == 4'b0000) ? pc : (read_reg1 == 4'b0001) ? sp : registers[read_reg1];
    assign reg_data2 = (read_reg2 == 4'b0000) ? pc : (read_reg2 == 4'b0001) ? sp : registers[read_reg2];
endmodule

///////////////////////////////Control Unit*****************************************
module control_unit (
    input clk,
    input reset,
    input [31:0] instruction,     // Fetched instruction
    output reg [3:0] operation,   // ALU operation code
    output reg [3:0] src1,        // Source register 1
    output reg [3:0] src2,        // Source register 2
    output reg [3:0] dest,        // Destination register
    output reg reg_write,         // Write enable for register file
    output reg [31:0] immediate,  // Immediate value (if used)
    output reg use_immediate      // Flag to use immediate value
);
    // Instruction fields
    wire [3:0] opcode;
    wire [3:0] reg1, reg2, reg_dest;

    // Instruction decoding
    assign opcode = instruction[31:28];  // 4-bit opcode
    assign reg1 = instruction[27:24];    // Source register 1
    assign reg2 = instruction[23:20];    // Source register 2
    assign reg_dest = instruction[19:16]; // Destination register

    // Control Unit Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset everything
            operation <= 4'b0000;
            src1 <= 4'b0000;
            src2 <= 4'b0000;
            dest <= 4'b0000;
            reg_write <= 1'b0;
            immediate <= 32'b0;
            use_immediate <= 1'b0;
        end else begin
            // Decode the instruction
            operation <= opcode;
            src1 <= reg1;
            src2 <= reg2;
            dest <= reg_dest;
            reg_write <= 1'b1;  // Assume we write after every operation

            // If it's an immediate operation, set the flag and capture the immediate value
            if (opcode == 4'b0100) begin  // Let's assume opcode 4'b0100 is for immediate operations
                use_immediate <= 1'b1;
                immediate <= instruction[15:0]; // 16-bit immediate value
            end else begin
                use_immediate <= 1'b0;
            end
        end
    end
endmodule
////******************************************************************************
module instruction_memory (
    input [31:0] addr,        // Address input (from PC)
    output reg [31:0] instruction  // Output instruction at addr
);
    reg [31:0] memory [255:0];  // 256 words of 32-bit instruction memory

    // Initialize with program instructions
    initial begin
    
//                            assign opcode = instruction[31:28];  // 4-bit opcode
//                            assign reg1 = instruction[27:24];    // Source register 1
//                            assign reg2 = instruction[23:20];    // Source register 2
//                            assign reg_dest = instruction[19:16]; // Destination register
                            
                            
        // ADD R1, R2 -> R0 (R0 = R1 + R2)
        //memory[0] = 32'b0000_0001_0001_0000_0000000000000000;
        memory[0] = 32'b0000_0010_0000_0011_0000000000001010;

        // SUB R3, R4 -> R5 (R5 = R3 - R4)
        memory[1] = 32'b0001_0011_0100_0101_0000000000000000;

        // MUL R6, R7 -> R8 (R8 = R6 * R7)
        memory[2] = 32'b0010_0110_0111_1000_0000000000000000;

        // AND R9, R10 -> R11 (R11 = R9 & R10)
        memory[3] = 32'b0011_1001_1010_1011_0000000000000000;

        // OR R12, R13 -> R14 (R14 = R12 | R13)
        memory[4] = 32'b0100_1100_1101_1110_0000000000000000;

        // CMP_EQ R1, R2 -> CC (Set CC if R1 == R2)
        memory[5] = 32'b0111_0001_0010_0000_0000000000000000;

        // JMP R15 (Unconditional jump to address in R15)
        memory[6] = 32'b1100_0000_0000_1111_0000000000000000;

        // CALL procedure at R8 (Save state and jump to R8)
        memory[7] = 32'b1110_0000_0000_1000_0000000000000000;

        // RET (Return from procedure)
        memory[8] = 32'b1111_0000_0000_0000_0000000000000000;

        // Conditional Jump (if CC == 1) to R7
        memory[9] = 32'b1101_0000_0000_0111_0000000000000000;

        // LOAD R5, [R6] (Load data from memory at address in R6 into R5)
        memory[10] = 32'b1010_0110_0000_0101_0000000000000000;

        // STORE R5, [R6] (Store data from R5 into memory at address in R6)
        memory[11] = 32'b1011_0110_0000_0101_0000000000000000;

        // Additional instructions can be added as needed...
    end

    // Fetch instruction at the given address
    always @(addr) begin
        instruction = memory[addr[7:0]];  // Fetch the instruction at addr (lower 8 bits for 256 instructions)
    end
endmodule

/////***************************************************************CPU
module cpu (
    input clk,
    input reset,
    output [31:0] alu_result
);
    wire [31:0] instruction;   // Fetched instruction
    wire [31:0] pc;            // Program counter from register file
    wire [3:0] src1, src2, dest, operation;
    wire [31:0] read_data1, read_data2, immediate;
    wire [31:0] write_data;
    wire reg_write, use_immediate;
    wire [31:0] alu_input2;

    // Instantiate the instruction memory
    instruction_memory instr_mem (
        .addr(pc),
        .instruction(instruction)
    );

    // Instantiate register file
    RegisterFile reg_file (
        .clk(clk),
        .reset(reset),  // Pass reset signal to register file
        .read_reg1(src1),
        .read_reg2(src2),
        .write_reg(dest),
        .write_data(write_data),
        .reg_write(reg_write),
        .reg_data1(read_data1),
        .reg_data2(read_data2),
        .pc(pc),         // PC from register file
        .sp()            // Stack pointer not used in this example
    );

    // Instantiate control unit
    control_unit ctrl_unit (
        .clk(clk),
        .reset(reset),  // Pass reset signal to control unit
        .instruction(instruction),
        .operation(operation),
        .src1(src1),
        .src2(src2),
        .dest(dest),
        .reg_write(reg_write),
        .immediate(immediate),
        .use_immediate(use_immediate)
    );

    // Choose whether to use the immediate value or register value as the second ALU operand
    assign alu_input2 = use_immediate ? immediate : read_data2;

    // Instantiate ALU
    ALU alu (
        .a(read_data1),
        .b(alu_input2),
        .operation(operation),
        .cin(1'b0),
        .result(alu_result),
        .overflow(),
        .underflow(),
        .equal(),
        .less_than(),
        .less_than_equal(),
        .carry_out()
    );

    // Write ALU result to destination register
    assign write_data = alu_result;
endmodule




