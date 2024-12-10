module parser(
  input wire [31:0] ins,
  output wire [6:0] opcode,
  output wire [4:0] rd,     //added output starting from this line
  output wire [2:0] funct3,
  output wire [4:0] rs1,
  output wire [4:0] rs2,
  output wire [6:0] funct7 
);
  assign opcode = ins[6:0];
  assign rd = ins[11:7];
  assign funct3 = ins[14:12];
  assign rs1 = ins[19:15];
  assign rs2 = ins[24:20];
  assign funct7 = ins[31:25];
endmodule 