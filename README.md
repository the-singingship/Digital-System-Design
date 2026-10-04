# 3C7 Digital Systems Design: Labs & Assignments

Verilog/VHDL designs, simulations, and FPGA implementations for **3C7 Digital Systems Design** (Trinity College Dublin, 2025/2026). Everything targets the **Digilent Basys 3** board (Xilinx Artix-7 `xc7a35tcpg236-1`) and was built with **Vivado 2025.2**.

The work builds up incrementally: a 1-bit full adder (Lab C) becomes a ripple adder/subtractor (Labs C/E), which is reused inside a Mini-ALU (Assignment 1). Assignment 2 moves from combinational to sequential design with an LFSR, a Moore FSM, and a counter.

---

## Contents

| Folder | Topic | Type | Highlights |
|---|---|---|---|
| `LabB/`, `LabB2/` | 8-bit comparator (`gte8`) and follow-up | Combinational | Built from 2-bit `gt2` / `eq2` gate-level blocks; reused later in the Mini-ALU |
| `LabC/` | 6-bit ripple carry adder/subtractor | Combinational | Full-adder chain, 2's complement subtraction, overflow = `carry[5] ^ carry[6]`, 13 test vectors in XSIM |
| `LabD/` | Vivado flow on Basys 3 | Tutorial + hardware | PWM modulator tutorial (timing, power, clock networks), LED bargraph with clock divider |
| `LabE/`, `LabE2/` | Adder/subtractor on the board | Combinational | Synthesis -> implementation -> bitstream, 4 board test cases, 9 LUTs (`LabE2` is the Vivado project) |
| `LabF_PartA/` to `LabF_PartD/` | _Add a one-line description_ | _TBD_ | _TBD_ |
| `Assign1/` | 6-bit **Mini-ALU** | Combinational | 8 functions, strictly structural top level, reuses lab modules unchanged, 19 LUTs |
| `Assign2/` | **LFSR codeword sequence detector** | Sequential | 22-bit XNOR LFSR, 7-state Moore FSM (KMP overlap handling), 17-bit counter, 65,536 detections |
| `Documentation/` | Written reports | PDFs | Lab and assignment write-ups |


---

## Assignment 1: Mini-ALU

A 6-bit ALU (signed, 2's complement) with a 3-bit function select `fxn`.

| `fxn` | Operation |
|---|---|
| `000` | Pass A |
| `001` | Pass B |
| `010` | Negate A |
| `011` | Negate B |
| `100` | Signed A < B |
| `101` | A XNOR B |
| `110` | A + B |
| `111` | A - B |

**Design notes**
- Top level (`minimum_alu`) contains only instantiations, with no logic of its own.
- Reuses `full_adder`, the ripple adder, and the gate-level comparators from earlier labs without modification.
- Signed less-than reuses the unsigned 8-bit comparator by flipping the MSB of each input (2's complement -> offset binary).
- Negation is done by routing `0` and the operand into the adder with `sel = 1` (computes `0 - x`).
- Verified with 21 test vectors in simulation and 8 hardware demos on the board.
- Resources: **19 LUTs**, 21 IOBs, no timing constraints (purely combinational).

**Module hierarchy**
```
minimum_alu
├── adder_input
├── ripple_adder_6bit
│   └── FullAdder x6
├── less_than_six_bit
│   └── gt_8bit
│       ├── gt2 x4
│       └── eq2 x4
├── six_bit_xnor
└── multiplexer_output
```

---

## Assignment 2: LFSR Codeword Sequence Detector

Counts how many times a 6-bit codeword appears in one full cycle of a maximal-length LFSR.

| Parameter | Value |
|---|---|
| LFSR | 22-bit, XNOR feedback (taps 22 and 1) |
| Codeword | `010110` |
| Seed | `0x79` |
| Sequence length | 2^22 - 1 = 4,194,303 cycles |
| Expected count | 2^(22-6) = **65,536** (`0x10000`) |

**Architecture** (`top.v`)
- `clk_div`: 100 MHz -> ~1 MHz (fast demo, ~4.2 s per full cycle) or ~1 Hz (slow step mode) via `sw[15]`
- `lfsr_22bit`: serial output + `done` pulse when the register returns to the seed
- `seq_detector`: 7-state Moore FSM, KMP prefix function used so overlapping matches are counted
- `counter`: 17-bit up-counter that freezes (`hold`) once the LFSR completes
- `disp_hex_mux`: 4-digit 7-segment display driver

**Results**
- Vivado testbench and an independent Python model both give **65,536** detections.
- On the board the display freezes at `1000` (hex) with `LED[15]` lit.
- 43 LUTs, 95 FFs, WNS = **+4.160 ns** at 100 MHz, all 73 endpoints met.

---

## Running on the Basys 3

1. Open the project in **Vivado 2025.2** (or create a new RTL project for `xc7a35tcpg236-1`).
2. Add the Verilog/VHDL sources and the matching `.xdc` constraints file from the folder.
3. Run **Synthesis -> Implementation -> Generate Bitstream**.
4. Connect the board over USB, open **Hardware Manager**, click **Auto Connect**, then **Program Device**.
5. Use the slide switches and LEDs as described in each folder's report.

For simulation, set the folder's testbench (`tb_*.v`) as the simulation top and run behavioural simulation in XSIM.

---

## Tools

- Vivado 2025.2 (synthesis, implementation, XSIM)
- Verilog (VHDL for the Lab D PWM tutorial)
- Python (reference model for the Assignment 2 detection count)
- Digilent Basys 3 (Artix-7 XC7A35T)

## Repository structure

```
.
├── Assign1/
├── Assign2/
├── Documentation/
├── LabB/
├── LabB2/
├── LabC/
├── LabD/
├── LabE/
├── LabE2/
├── LabF_PartA/
├── LabF_PartB/
├── LabF_PartC/
├── LabF_PartD/
└── README.md
```

> Course work submitted for 3C7 Digital Systems Design.
