# SONY Cell SPU Processor: Dual-Issue Pipelined Multimedia Microarchitecture

This repository contains the complete Verilog implementation and supporting tools for a cycle-accurate, dual-issue pipelined multimedia processor inspired by the Synergistic Processing Unit (SPU) of the Cell Broadband Engine architecture. The processor is referred to as **SPU-lite**, and supports a wide subset of SIMD-oriented SPU instructions, focused on multimedia and scientific workloads.

---

##  Overview

The SPU-lite processor features:

- **11-stage dual-issue pipeline** with symmetric even and odd instruction paths.
- **Cycle-accurate simulation** model capturing precise behavior of stalls, forwarding, and instruction-level parallelism.
- Support for **128-bit SIMD register operations**, including fixed-point arithmetic, floating-point operations, permute, byte-level logic, and load/store.
- A companion **C++ assembler** that parses SPU-like assembly and emits 32-bit binary instructions compatible with the SPU-lite ISA.
- Separate instruction and data memories, mimicking the local store design of the original Cell SPU.
- Instruction and register preload support via external files for flexible testbench integration.

---

##  Pipeline Architecture

The pipeline is composed of **11 logical stages**, with up to **two instructions fetched, decoded, issued, and routed per cycle**. The first three stages are shared by both instructions, while subsequent stages process instructions independently along the even and odd paths.

### Stage Breakdown:

| Stage | Description                                 |
|-------|---------------------------------------------|
| IF    | Dual-instruction fetch from IMEM            |
| ID    | Decode, dependency check, issue, routing    |
| RF    | Dual-port register file read + forwarding   |
| EX1–EX7 | Execution stages for each functional unit |
| WB    | Write-back with bypass and register commit  |

Hazard detection logic ensures correctness across all stages, and a unified forwarding unit enables aggressive data reuse to reduce pipeline stalls.

---

##  Instruction Set Architecture (ISA)

SPU-lite supports a carefully selected subset of the original Cell SPU ISA. The implemented instructions span across 7 execution units:

- **FX1 / FX2**: Fixed-point units (add, sub, shift)
- **SP**: Single-precision floating point operations (add, mul, madd)
- **BYTE**: Byte-wise logical operations
- **PERMUTE**: Shift, rotate, merge, gather, and permute operations
- **BR**: Conditional and unconditional branches
- **LS**: Load and Store operations

### Instruction Formats

Six instruction formats are supported:

- `RR`, `RRR`: Register-to-register operations
- `RI7`, `RI10`, `RI16`, `RI18`: Immediate variants

Each instruction encodes:

- Operation code (opcode)
- Operand registers (RA, RB, RC)
- Immediate fields (signed, sign-extended)
- Destination register
- Execution unit and functional pipeline

All instruction names and binary encodings strictly follow the official SPU documentation to allow compatibility with real-world SPU toolchains and test programs.

---

##  Hazard and Control Management

### Structural Hazards

- Dual-issue logic prevents simultaneous dispatch to the same functional unit.
- Each instruction is independently routed to its designated execution pipeline.

### Data Hazards

- RAW dependencies are checked per operand.
- The forwarding unit resolves hazards across up to 7 stages.
- Stall logic inserts NOPs or delays issue when required.

### Control Hazards

- Static branch prediction (not-taken) is assumed.
- On misprediction, the pipeline is flushed, and execution resumes from the branch target.
- Misaligned PC updates are detected and handled via dynamic NOP injection.

---

## Register File and Result Bus

- **128 general-purpose registers**, each 128-bit wide.
- Simultaneous dual-port read access from both even and odd instructions.
- Result buses tagged with:
  - Functional unit ID (1–7)
  - 128-bit result value
  - Destination register index
  - Write enable flag
  - Ready stage for forwarding

The register write-back stage validates these tags and commits results accordingly, maintaining correctness across data and control flow.

---
## Simulation

This processor has been verified using both **Xcelium** and **Questasim** simulators.

The `output_binary.txt` file should be preloaded into the instruction memory via the testbench before simulation begins.

### The testbench handles:

- Clock generation  
- Reset sequencing  
- Instruction memory initialization  
- Optional register file / Local Store Memory preloading  

---

### Tools Used

- **Xcelium**  

- **Questasim**  

---

## Assembler

A custom-built C++ assembler is included to support writing test programs in a human-readable format. It accepts pseudo-SPU assembly and produces binary instruction encodings to be loaded into the processor's instruction memory.

### Features:

- Support for all six instruction formats
- Robust label handling for PC-relative branches
- Immediate parsing in decimal and hexadecimal
- Syntax and format validation with precise error feedback
- Outputs `output_binary.txt` file compatible with Verilog testbench loading

### Usage:

```bash
g++ parser.cpp -o parser
./parser
