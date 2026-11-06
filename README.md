# Digital Calculator using ALU

An 8-bit digital calculator built around an Arithmetic Logic Unit (ALU), written in SystemVerilog and simulated on EDA Playground Given two 8-bit operands and a 4-bit opcode, it produces a 16-bit result and a one-hot signal showing which operation is active.

## Features

- Arithmetic: addition, subtraction, multiplication, division
- Logic: AND, OR, XOR, NOT
- 16-bit result, so the full product of two 8-bit numbers fits
- One-hot operation indicator outputs
- Division by zero returns 0
- Fully combinational design (`always_comb`)

## Files

| File | Description |
|------|-------------|
| `design.sv` | `digital_calculator` module (design under test) |
| `testbench.sv` | `tb_digital_calculator` testbench with one test per operation |
| `README.md` | Project documentation |

## Ports

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `A` | input | 8 | First operand |
| `B` | input | 8 | Second operand |
| `opcode` | input | 4 | Operation select |
| `result` | output | 16 | Operation result |
| `ADD`, `SUB`, `MUL`, `DIV` | output | 1 | High when that arithmetic operation is selected |
| `AND_op`, `OR_op`, `XOR_op`, `NOT_op` | output | 1 | High when that logic operation is selected |

## Opcode Table

| Opcode | Operation | Result |
|--------|-----------|--------|
| `4'b0000` | ADD | `A + B` |
| `4'b0001` | SUB | `A - B` (8-bit, wraps if `A < B`) |
| `4'b0010` | MUL | `A * B` |
| `4'b0011` | DIV | `A / B` (0 if `B == 0`) |
| `4'b0100` | AND | `A & B` |
| `4'b0101` | OR | `A \| B` |
| `4'b0110` | XOR | `A ^ B` |
| `4'b0111` | NOT | `~A` (8-bit, `B` ignored) |
| others | none | `0`, all indicators low |

## Internal Status Flags

The design computes `zero_flag`, `carry_flag`, `borrow_flag` and `div_by_zero` internally. They are not currently brought out as ports.

## Testbench

The testbench applies one test vector per operation and writes a waveform to `dump.vcd`:

| Test | Inputs | Expected |
|------|--------|----------|
| ADD | 20, 10 | 30 |
| SUB | 50, 20 | 30 |
| MUL | 10, 5 | 50 |
| DIV | 100, 10 | 10 |
| AND | 204, 170 | 136 |
| OR | 204, 170 | 238 |
| XOR | 204, 170 | 102 |
| NOT | 204 | 51 |

## How to Run

1. Open EDA Playground and paste `design.sv` and `testbench.sv` into the Design and Testbench panes.
2. Select a SystemVerilog-capable simulator (e.g. Aldec Riviera-PRO or Synopsys VCS).
3. Tick **Open EPWave after run** and click **Run**.
4. The console prints `SIMULATION COMPLETED` and the waveform opens in EPWave.


## Possible Improvements

- Output the status flags (zero, carry, borrow, divide-by-zero) as ports
- Make the testbench self-checking with expected values and pass/fail messages
- Add edge-case tests: divide by zero, subtract with `A < B`, addition overflow (255 + 1), multiplication of 255 * 255, invalid opcodes
- Add a clock and registered output for a synchronous version
