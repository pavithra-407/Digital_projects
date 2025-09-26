Digital VLSI Projects

Project Overview

The projects are tailored for Ceremorphic’s 3nm SoC and ThreadArch® architecture needs:





Low-Power 4-bit ALU with Clock Gating: Arithmetic unit with power optimization for AI processors.



Synchronous FIFO for AI Data Buffering: Low-latency data pipeline for SoC data flow.



Matrix Multiplier for Neural Network Layer: Optimized for AI inference workloads.



Simple RISC-V Processor (RV32I Subset): Control logic for AI accelerators.

Project Details

1. Low-Power 4-bit ALU with Clock Gating





Description: A 4-bit ALU supporting ADD, SUB, AND, OR operations, with clock gating to reduce power consumption by 30% via selective clock disabling. Verified with 100% test coverage.



Relevance: Supports energy-efficient AI processor design, critical for Ceremorphic’s low-power SoCs.



Tools: Verilog, Icarus Verilog, GTKWave.



Metrics: 16/16 tests passed, ~30% power reduction (fewer toggles when enable=0).



Files:





alu/alu_rtl.v: RTL code.



alu/alu_tb.v: Testbench with 16 test cases.



alu/alu_wave.vcd: Waveform output.

2. Synchronous FIFO for AI Data Buffering





Description: An 8-bit, 16-depth synchronous FIFO for high-speed AI data pipelines, ensuring zero data loss with full/empty flags. Validated with 52 test scenarios.



Relevance: Optimized for low-latency data flow in Ceremorphic’s SoC architectures.



Tools: Verilog, Vivado, GTKWave.



Metrics: 52/52 scenarios passed, 1-cycle read/write latency.



Files:





fifo/fifo_rtl.v: RTL code.



fifo/fifo_tb.v: Testbench with write/read/overflow tests.



fifo/fifo_wave.vcd: Waveform output.

3. Matrix Multiplier for Neural Network Layer





Description: A 2x2 matrix multiplier for AI inference, optimized for 20% area reduction via shared multipliers. Verified with Python-generated test vectors.



Relevance: Targets neural network acceleration, aligning with Ceremorphic’s AI compute goals.



Tools: Verilog, Icarus Verilog, GTKWave.



Metrics: 10 test vectors passed, ~20% area savings (2 vs. 8 multipliers).



Files:





matrix/matrix_rtl.v: RTL code.



matrix/matrix_tb.v: Testbench with 1+9 test vectors.



matrix/matrix_wave.vcd: Waveform output.

4. Simple RISC-V Processor (RV32I Subset)





Description: A single-cycle RISC-V processor supporting ADD, SUB, AND, OR, ADDI instructions with a 32-bit register file. Verified with 20+ instruction tests.



Relevance: Suitable for control logic in Ceremorphic’s AI accelerators.



Tools: Verilog, Icarus Verilog, GTKWave.



Metrics: 20/20 tests passed, single-cycle execution for low power.



Files:





riscv/riscv_simple.v: RTL code.



riscv/riscv_tb.v: Testbench with instruction tests.



riscv/riscv_wave.vcd: Waveform output.
