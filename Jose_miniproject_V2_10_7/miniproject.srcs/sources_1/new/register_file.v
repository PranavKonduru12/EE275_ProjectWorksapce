`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 10:08:53 PM
// Design Name: 
// Module Name: register_file
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


/////=============================part2================================
/////////////////////////////registerfile
module RegisterFile (
    input clk,                              // Clock signal
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
    
//    assign pc = registers[0];
//    assign sp = registers[1];
    
//    /////////////****
    integer i;
    initial begin
        for (i=0;i<15;i=i+1)
        registers[i] = 0;
    end
//    ////////////***************

    initial begin
        pc = 0; sp = 0;
    end


    // Update Condition Code register on clock edge
    always @(posedge clk) begin
        cc_register <= cc_flags;  // Store ALU flags into the Condition Code register
//        registers[3] <= 3;
//        registers[4] <= 3;
//        if (reg_write && write_reg != 4'b0000 && write_reg != 4'b0001) begin
//            registers[write_reg] <= write_data;  // Write to the register
//        end else if (write_reg != 4'b0000) begin
//            pc <= write_data;
//            sp <= 0;
//        end else if (write_reg != 4'b0001) begin
//            sp <= write_data;
//        end
        if (reg_write) begin
            registers[write_reg] <= write_data;  // Write to the register
            if (write_reg == 4'b0000) begin
                pc <= write_data;
                //sp <= 0;
            end else if (write_reg == 4'b0001) begin
                sp <= write_data;
            end
        end

    end

    // Register write operation, but do not overwrite R0 (PC) or R1 (SP) directly
//    always @(posedge clk) begin
//        if (reg_write && write_reg != 4'b0000 && write_reg != 4'b0001) begin
//            registers[write_reg] <= write_data;  // Write to the register
//        end
//    end

    // R0 as Program Counter (PC) and R1 as Stack Pointer (SP)
    assign reg_data1 = (read_reg1 == 4'b0000) ? pc : (read_reg1 == 4'b0001) ? sp : registers[read_reg1];
    assign reg_data2 = (read_reg2 == 4'b0000) ? pc : (read_reg2 == 4'b0001) ? sp : registers[read_reg2];
//    assign reg_data1 = registers[read_reg1];
//    assign reg_data2 = registers[read_reg2];

endmodule
