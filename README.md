# RISC-V-RV32I-CPU

RV32I RISC-V CPU written in Verilog for the Basys 3 (Artix-7). Single-cycle first, then a 5-stage pipeline.

## Status
| Module | File | Status |
|---|---|---|
| Program counter | rtl/pc.v | Done |
| Register file | rtl/reg.v | Verified (5 self-checking tests) |
| ALU | rtl/alu.v | Verified (8 self-checking tests) |
| Immediate generator | | Not started |
| Instruction memory | | Not started |
| Data memory | | Not started |
| Control unit | | Not started |
| Branch logic | | Not started |
| Single-cycle top | | Not started |
| 5-stage pipeline | | Planned |

## Design notes
- **Register file:** 32x32, x0 hardwired to 0, async read, sync write, same-cycle write-before-read bypass, synchronous reset.
- **ALU:** purely combinational, 10 operations, zero flag. The op code is `{instr[30], funct3}`.

| Op | alu_op |
|---|---|
| ADD | 0000 |
| SLL | 0001 |
| SLT | 0010 |
| SLTU | 0011 |
| XOR | 0100 |
| SRL | 0101 |
| OR | 0110 |
| AND | 0111 |
| SUB | 1000 |
| SRA | 1101 |

## Repo layout
- `rtl/` design sources
- `tb/` self-checking testbenches
- `docs/` simulation screenshots

## Tools
Vivado, simulated with behavioral testbenches. Target board: Basys 3.

## Roadmap
Single-cycle core, then pipeline with forwarding and hazard detection, then a simple SoC with memory-mapped I/O. A security-focused review (PMP, privilege modes) is a stretch goal.
