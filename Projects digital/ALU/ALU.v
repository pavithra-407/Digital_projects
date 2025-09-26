`timescale 1ns / 1ps

module low_power_alu_4bit (
    input wire clk,
    input wire enable,
    input wire [3:0] a,
    input wire [3:0] b,
    input wire [1:0] opcode,    // 00: ADD, 01: SUB, 10: AND, 11: OR
    output reg [3:0] result,
    output reg carry
);

reg [4:0] add_result;
reg [4:0] sub_result;
reg [3:0] and_result;
reg [3:0] or_result;

always @(*) begin
    add_result = {1'b0, a} + {1'b0, b};
    sub_result = {1'b0, a} - {1'b0, b};
    and_result = a & b;
    or_result = a | b;
end

always @(posedge clk) begin
    if (enable) begin
        case (opcode)
            2'b00: begin result <= add_result[3:0]; carry <= add_result[4]; end
            2'b01: begin result <= sub_result[3:0]; carry <= sub_result[4]; end
            2'b10: begin result <= and_result; carry <= 1'b0; end
            2'b11: begin result <= or_result; carry <= 1'b0; end
            default: begin result <= 4'b0; carry <= 1'b0; end
        endcase
    end
end

endmodule
