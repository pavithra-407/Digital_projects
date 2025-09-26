`timescale 1ns / 1ps

module sync_fifo_8bit (
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] data_in,
    output reg [7:0] data_out,
    output reg full,
    output reg empty
);

parameter DEPTH = 16;
parameter PTR_WIDTH = 5;

reg [7:0] mem [0:DEPTH-1];
reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
reg [PTR_WIDTH:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0; rd_ptr <= 0; count <= 0;
        data_out <= 8'b0; full <= 0; empty <= 1;
    end else begin
        if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= wr_ptr + 1;
            if (count != 0) empty <= 0;
            count <= count + 1;
        end
        
        if (rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
            if (count == 1) empty <= 1;
            if (wr_en) count <= count;
            else count <= count - 1;
        end
        
        full <= (count == DEPTH);
        empty <= (count == 0);
    end
end

endmodule
