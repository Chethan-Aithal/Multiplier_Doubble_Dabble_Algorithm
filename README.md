# Parameterized Shift-and-Add Multiplier with Binary to BCD Converter

A parameterized Verilog implementation of a Shift-and-Add Multiplier that multiplies two binary numbers and converts the binary result into Binary Coded Decimal (BCD) using the Double Dabble algorithm.

---

## Features

- Parameterized input bit width
- Shift-and-Add multiplication algorithm
- Binary to BCD conversion
- Configurable for different operand sizes
- Synthesizable RTL design
- Simple and modular implementation

---

## Project Structure

```
Multiplier.v       // Main multiplier module
Multiplier_tb.v    // Testbench
```

---

## Inputs

| Signal | Width | Description |
|--------|------:|-------------|
| clk | 1 | System clock |
| reset | 1 | Active-low reset |
| start | 1 | Starts multiplication |
| a_in | N | First operand |
| b_in | N | Second operand |

---

## Outputs

| Signal | Width | Description |
|--------|------:|-------------|
| out | 2N | Binary multiplication result |
| finish | 1 | Indicates completion of multiplication |
| bcd | Depends on N | BCD representation of the result |

---

## Working Principle

The multiplier works in two stages:

### 1. Shift-and-Add Multiplication

- Inputs are loaded into internal registers.
- The Least Significant Bit (LSB) of the multiplier is checked.
- If the LSB is `1`, the multiplicand is added to the result.
- The multiplicand is shifted left by one bit.
- The multiplier is shifted right by one bit.
- This process repeats for **N clock cycles**.

### 2. Binary to BCD Conversion

After multiplication completes, the binary result is converted into BCD using the Double Dabble (Shift-Add-3) algorithm, making the result suitable for decimal displays.

---

## Simulation Flow

```
Reset
   │
   ▼
Load Inputs
   │
   ▼
Start Multiplication
   │
   ▼
Shift-and-Add (N Cycles)
   │
   ▼
Binary Result Generated
   │
   ▼
Binary to BCD Conversion
   │
   ▼
Finish = 1
```

---

## Example

| A | B | Binary Output | Decimal |
|---|---|--------------|---------|
| 26 | 30 | 780 | 780 |
| 13 | 13 | 169 | 169 |

---

## Advantages

- Easy to understand
- Parameterized design
- Low hardware complexity
- Reusable for different bit widths
- Suitable for FPGA and ASIC learning

---

## Limitations

- BCD conversion is performed after multiplication, increasing latency.
- Double Dabble implementation becomes slower for larger bit widths.
- Multiplication requires **N clock cycles**.
- No busy signal to indicate an ongoing operation.

---

## Future Improvements

- Add a Busy signal
- Implement an FSM-based controller
- Optimize Binary-to-BCD conversion
- Pipeline the multiplier for higher performance
- Support signed multiplication

---

## Tools Used

- Verilog HDL
- Xilinx Vivado (Simulation & Synthesis)

---

## Chethan Aithal

**Chethan Aithal**

---
