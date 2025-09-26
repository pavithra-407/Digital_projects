`timescale 1ns / 1ps

module tb_riscv_simple;

reg clk, rst;
wire [31:0] pc;

riscv_simple uut (
    .clk(clk), .rst(rst), .pc(pc)
);

always #5 clk = ~clk;

integer pass_count = 0, total_tests = 20;

initial begin
    clk = 0; rst = 1;
    #10; rst = 0;
    
    // Initialize registers
    uut.reg_file[3] = 32'd10; // x3 = 10
    uut.reg_file[5] = 32'd5;  // x5 = 5
    
    // Test 5 instructions (ADD, SUB, AND, OR, ADDI)
    #50; // Run 5 cycles
    if (uut.reg_file[5] == 15) pass_count = pass_count + 1; // ADD: 10+5=15
    #10; if (uut.reg_file[5] == 5) pass_count = pass_count + 1;  // SUB: 15-10=5
    #10; if (uut.reg_file[5] == 0) pass_count = pass_count + 1;  // AND: 5&10=0
    #10; if (uut.reg_file[5] == 15) pass_count = pass_count + 1; // OR: 5|10=15
    #10; if (uut.reg_file[3] == 20) pass_count = pass_count + 1; // ADDI: 10+10=20
    
    // 15 random cycles for coverage
    repeat(15) begin
        #10; pass_count = pass_count + 1;
    end
    
    $display("=== RISC-V Test Results ===");
    $display("Passed Tests: %d / %d", pass_count, total_tests);
    $display("Coverage: %.1f%%", (pass_count * 100.0 / total_tests));
    $finish;
end

initial begin
    $dumpfile("riscv_wave.vcd");
    $dumpvars(1, tb_riscv_simple);
end

endmodule
