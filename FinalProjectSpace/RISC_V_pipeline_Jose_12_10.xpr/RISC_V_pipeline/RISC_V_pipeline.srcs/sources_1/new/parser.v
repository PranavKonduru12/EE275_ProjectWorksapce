module parser(
  input wire [31:0] ins,            // 32-bit instruction
  output wire [6:0] opcode,         // Opcode field
  output wire [4:0] rd,             // Destination register
  output wire [2:0] funct3,         // Function field (3 bits)
  output wire [4:0] rs1,            // Source register 1
  output wire [4:0] rs2,            // Source register 2
  output wire [6:0] funct7          // Function field (7 bits)
);

  assign opcode = ins[6:0];
  assign rd = ins[11:7];
  assign funct3 = ins[14:12];
  assign rs1 = ins[19:15];
  assign rs2 = ins[24:20];
  assign funct7 = ins[31:25];

  // Debugging statements
  initial begin
    $display("Parser: Instruction parsed. Opcode=%b, rd=%b, funct3=%b, rs1=%b, rs2=%b, funct7=%b",
             opcode, rd, funct3, rs1, rs2, funct7);
  end

endmodule

//module parser(
//  input wire [31:0] ins,
//  output wire [6:0] opcode,
//  wire [4:0] rd,
//  wire [2:0] funct3,
//  wire [4:0] rs1,
//  wire [4:0] rs2,
//  wire [6:0] funct7 
//);
//  assign opcode = ins[6:0];
//  assign rd = ins[11:7];
//  assign funct3 = ins[14:12];
//  assign rs1 = ins[19:15];
//  assign rs2 = ins[24:20];
//  assign funct7 = ins[31:25];
//endmodule 