`timescale 1ns / 1ps

module riscv_simple (
    input wire clk,
    input wire rst,
    output reg [31:0] pc
);

// Instruction fields
wire [31:0] instr;
wire [6:0] opcode = instr[6:0];
wire [4:0] rd = instr[11:7];
wire [4:0] rs1 = instr[19:15];
wire [4:0] rs2 = instr[24:20];
wire [2:0] funct3 = instr[14:12];
wire [31:0] imm;

// Control signals
reg reg_write;
reg [1:0] alu_op;
reg alu_src;

// Register file
reg [31:0] reg_file [0:7];  // 8 registers
wire [31:0] rs1_data, rs2_data;
assign rs1_data = reg_file[rs1];
assign rs2_data = reg_file[rs2];

// ALU
reg [31:0] alu_result;
wire [31:0] alu_in2 = alu_src ? imm : rs2_data;

// Instruction memory (ROM, 16 instructions)
reg [31:0] instr_mem [0:15];
initial begin
    instr_mem[0] = 32'h005182b3; // ADD x5, x3, x5
    instr_mem[1] = 32'h405182b3; // SUB x5, x3, x5
    instr_mem[2] = 32'h0051c2b3; // AND x5, x3, x5
    instr_mem[3] = 32'h0051e2b3; // OR x5, x3, x5
    instr_mem[4] = 32'h00a18193; // ADDI x3, x3, 10
end

assign instr = instr_mem[pc[5:2]];

// Immediate generation (I-type)
assign imm = {{20{instr[31]}}, instr[31:20]};

// Control unit
always @(*) begin
    reg_write = 0;
    alu_op = 2'b00;
    alu_src = 0;
    case (opcode)
        7'b0110011: begin  // R-type
            reg_write = 1;
            alu_src = 0;
            case (funct3)
                3'b000: alu_op = (instr[30]) ? 2'b01 : 2'b00; // ADD/SUB
                3'b111: alu_op = 2'b10; // AND
                3'b110: alu_op = 2'b11; // OR
            endcase
        end
        7'b0010011: begin  // I-type (ADDI)
            reg_write = 1;
            alu_src = 1;
            alu_op = 2'b00; // ADD
        end
    endcase
end

// ALU
always @(*) begin
    case (alu_op)
        2'b00: alu_result = rs1_data + alu_in2; // ADD
        2'b01: alu_result = rs1_data - alu_in2; // SUB
        2'b10: alu_result = rs1_data & alu_in2; // AND
        2'b11: alu_result = rs1_data | alu_in2; // OR
        default: alu_result = 0;
    endcase
end

// Register file write and PC update
always @(posedge clk or posedge rst) begin
    if (rst) begin
        pc <= 0;
        reg_file[0] <= 0; // x0 is hardwired 0
    end else begin
        pc <= pc + 4; // Next instruction
        if (reg_write && rd != 0) reg_file[rd] <= alu_result;
    end
end

endmodule
