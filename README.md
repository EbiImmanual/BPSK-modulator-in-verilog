# 🛰️ BPSK Modulation in Verilog

This project implements a **Binary Phase Shift Keying (BPSK)** modulator using Verilog HDL.  
The design generates a sine wave and modulates its phase (0° or 180°) based on a binary input signal.  
It also includes a simple **testbench** to visualize the waveform and behavior in simulation.

---

## 📘 Overview

**Binary Phase Shift Keying (BPSK)** is a digital modulation technique where the phase of a carrier signal is shifted based on the binary input data:
- Logic `1` → Transmit the original sine wave.  
- Logic `0` → Transmit the inverted sine wave (180° phase shift).

This design:
- Generates a sine wave using a lookup table (`sine_table`).
- Modulates it according to the input bit (`rand_bit`).
- Outputs the **modulated BPSK waveform** and the **sine wave** for comparison.

---

## 🧩 Module Description

### `bpsk_complete.v`
| Port | Direction | Width | Description |
|------|------------|--------|-------------|
| `clk` | input | 1 | System clock |
| `reset` | input | 1 | Active-high reset |
| `rand_bit` | input | 1 | Random input bit for modulation |
| `sine_out` | output | 16 | Generated sine wave |
| `counter` | output | 8 | Address pointer for sine table |
| `bpsk` | output | 16 | BPSK-modulated output |

The sine wave is stored in a **256-sample lookup table** using `$sin()` during simulation.

---

## 🧪 Testbench

### `bpsk_complete_tb.v`
The testbench:
- Toggles the clock (`10 ns` period).
- Resets the DUT.
- Changes the input bit (`rand_bit`) periodically to observe phase shifts.
- Runs for several cycles to display waveform transitions.

### Simulation Behavior
You can observe:
- The sine wave (`sine_out`)
- The BPSK-modulated signal (`bpsk`)
- Counter increments from 0–255 and repeats.

---

## 🧰 How to Simulate

### Using **ModelSim / QuestaSim**
```bash
vlog bpsk_complete.v
vlog bpsk_complete_tb.v
vsim work.bpsk_complete_tb
run 10us
add wave *
