`timescale 1ns / 1ps

module matrix_multiplier_2x2 (
    input wire clk,
    input wire [7:0] A_row0,
    input wire [7:0] A_row1,
    input wire [7:0] B_col0,
    input wire [7:0] B_col1,
    output reg [7:0] C_row0,
    output reg [7:0] C_row1
);

wire [7:0] prod00, prod01, prod10, prod11;
wire [7:0] acc00, acc01, acc10, acc11;

assign prod00 = A_row0[3:0] * B_col0[3:0];
assign prod10 = A_row0[3:0] * B_col0[7:4];
assign prod01 = A_row0[7:4] * B_col1[3:0];
assign prod11 = A_row0[7:4] * B_col1[7:4];

assign acc00 = prod00 + (A_row1[3:0] * B_col0[3:0]);
assign acc01 = prod01 + (A_row1[3:0] * B_col1[3:0]);
assign acc10 = prod10 + (A_row1[7:4] * B_col0[7:4]);
assign acc11 = prod11 + (A_row1[7:4] * B_col1[7:4]);

always @(posedge clk) begin
    C_row0[3:0] <= acc00[3:0];
    C_row0[7:4] <= acc01[3:0];
    C_row1[3:0] <= acc10[3:0];
    C_row1[7:4] <= acc11[3:0];
end

endmodule

