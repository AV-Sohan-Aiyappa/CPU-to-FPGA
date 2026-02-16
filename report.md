# CPU on FPGA 

## 1. Abstract
This project explores the implementation of the **HACK Central Processing Unit (CPU)**, originally introduced in the NAND2TETRIS course, using Verilog and implementing in a **Basys 3 FPGA**. While the original course leverages a custom hardware description language and proprietary simulation infrastructure to teach computer architecture fundamentals, our approach shifts the focus to standard digital design practices, thereby bridging the gap between educational abstraction and real-world hardware deployment. <br><br>
We recreate the entire HACK CPU architecture from fundamental logic gates to the top-level CPU integration using Verilog, and validate our design through rigorous simulation and synthesis. Furthermore, we adapt the architecture for implementation on a FPGA platform, enabling the system to run real HACK assembly programs in real-time hardware. Additionally , using Basys 3 connected to a monitor via VGA , the state of internal registers , flags and the program data can be observed in real time.<br><br>
The report documents the complete development process, including the prerequisite knowledge, modular design methodology, and the challenges encountered during debugging and FPGA deployment. Through this work, we aim not only to replicate a theoretical CPU but also to demonstrate how classical educational architectures can be translated into practical, real-world computing systems. This project serves as a learning milestone in digital design, hardware development, and systems engineering, while also highlighting the potential of open-source tools in hardware prototyping.<br><br>

## 2.Introduction
 
### 2.1 NAND2TETRIS
*NAND2TETRIS* is a renowned educational project developed by **Shimon Schocken and Noam Nisan**, designed to teach computer architecture from the ground up. The course takes students on a hands-on journey, beginning with the simplest digital logic gate:the NAND ,and gradually building up to a functioning 16-bit CPU, memory modules, machine language, and even a basic operating system and compiler. It is widely praised for its clarity, accessibility, and the sense of empowerment it gives learners by demystifying the inner workings of computers.<br><br>
One of the key features of the course is its use of a custom **Hardware Description Language (HDL)** and an educational simulation environment, which makes it approachable for beginners. However, this abstraction also limits the exposure to real-world tools and hardware implementation practices used in the digital design industry.

### 2.2 Objective 
The objective of this project is to **reimplement the HACK CPU**, the central processor defined in the NAND2TETRIS curriculum-using Verilog, and to adapt it for synthesis and deployment on FPGA hardware. By doing so, we aim to bridge the gap between educational abstraction and practical digital system design.
<br><br>
Instead of relying on the built-in simulator and HDL provided by the course, we use industry tools like Xilinx Vivado for simulation, synthesis, and testing. Our focus is not only on replicating the logical behaviour of the HACK CPU but also on making it physically realizable and testable in real hardware environments.<br><br>
Through this project, we aim to gain deeper insights into computer architecture, master Verilog-based design practices, and build a strong foundation in FPGA workflows, from simulation to hardware validation.<br><br>
**Key Objectives:**<br>
    • Reconstruct the HACK CPU architecture using Verilog.<br>
    • Replace the custom HDL with standard, synthesizable code.<br>
    • Synthesize the final design and deploy it on an FPGA board.
## 3. Prerequisites

### 3.1 Theoretical Background 
1. **Verilog HDL**<br>
Proficiency in Verilog is necessary for implementing all logic modules, describing hardware behaviour, and performing simulation and synthesis. The project relies on:<br>
    • Modelling Techniques.<br>
    • Knowledge of building and integrating sequential and combinational circuits. <br>
    • Hierarchical module instantiation. <br>
    • Writing testbenches for validation. <br>
    <br>
2. **GithHub for Code Hosting**<br>
GitHub was used for hosting the project repository and sharing code. It served as a public version-controlled archive for documentation, HDL source files, and testbenches.

### 3.2 Practical Prerequisites 
1. **Software Tools**<br>
Two main toolchains were used throughout the project:<br>
    • Xilinx Vivado Design Suite : Used for RTL synthesis, implementation, timing analysis, and for FPGA deployment.<br>
    • Icarus Verilog + GTKWave : Used for functional simulation and waveform analysis during development. <br><br>
2. **FPGA Development Boards**
The project is to be deployed and validated on two FPGA platforms:<br>
    • BASYS 3 Artix 7 Development Board 

## 4. Development Environment 
The development workflow combined open-source tools, FPGA design software, and a structured repository to support simulation, synthesis, and hardware validation of the HACK CPU architecture.
### 4.1 Software Stack 
    • Xilinx Vivado Design Suite
    • Icarus Verilog (iverilog)
    • GTKWave
    • Text Editor: Visual Studio Code
### 4.2 Hardware Platforms 
    • BASYS 3 Artix 7 Development Board
    • Arty A7 Artix 7 35T Development Board
### 4.3 Project Repository Structure 

## 5. System Architecture 

### HACK CPU Architecture Overview
The HACK CPU is a 16-bit Von Neumann architecture. It aims to provide a clear, hands-on understanding of how a simple, real-world computer system operates. The design is intentionally minimal to focus on core concepts like instruction execution, memory management, and control flow, which are fundamental to understanding modern processors.<br>
Key Components:<br>
#### 5.1 Registers:<br><br>
        ◦ A Register: A 16-bit register that holds either an address or a data value. It can store either a memory address for subsequent memory access or a direct value to be used in calculations.
        ◦ D Register: A 16-bit data register used to store temporary values during computation and data manipulation.
        ◦ Program Counter (PC): A 16-bit register that stores the address of the next instruction to be fetched from memory.
        ◦ Memory: The HACK CPU has two types of memory:
            ▪ RAM: A 32K (32,768 words) memory space, with each word 16 bits wide.
            ▪ ROM: A read-only memory space for storing the program code, also 32K words, where each word is 16 bits.
#### 2. ALU (Arithmetic Logic Unit):
        ◦ The ALU performs a variety of operations, including:
            ▪ Arithmetic operations: Addition, subtraction, etc.
            ▪ Logical operations: AND, OR, NOT, and comparison operations.
#### 3. Control Unit:
        ◦ The control unit interprets instructions from memory and orchestrates the flow of data between the registers, ALU, and memory.
        ◦ The control unit decodes each instruction into signals that direct the data flow in the system. It ensures that data is loaded into the correct registers, that operations are performed by the ALU, and that results are written back to memory or registers as needed.
#### 5.4 Instruction Set:
The instruction set for the HACK CPU is composed of two types of instructions: A-instructions and C-instructions.<br><br>
        ◦ **A-instruction** (Address Instruction):<br>
            ▪ Format: @value<br>
            ▪ The value can either be a memory address or a constant value. It loads the value into the A register.<br>
            ▪ Example: @5 loads the value 5 into the A register.<br><br>
        ◦ **C-instruction** (Computation Instruction):<br>
            ▪ Format: dest=comp;jump<br>
            ▪ The dest field specifies the destination registers for the result (D, M, or D+M).<br>
            ▪ The comp field specifies the computation or operation to perform (e.g., addition, subtraction, AND, OR).<br>
            ▪ The jump field dictates whether a conditional jump occurs based on the computation result.
            ▪ Example: D=A+1 performs the addition A + 1 and stores the result in the D register.<br><br>
        ◦ **Control Signals:**<br>
            ▪ The CPU decodes the C-instruction into various control signals to control the ALU, memory, and other registers.<br>
            ▪ Example signals include ALUop (determines the operation in the ALU), MemWrite (enables writing to memory), and PCWrite (controls the updating of the Program Counter).
#### 5.5 Instruction Fetch-Decode-Execute Cycle:
        ◦ The CPU executes instructions in a three-phase cycle:
            ▪ Fetch: The instruction is fetched from memory at the address specified by the PC.
            ▪ Decode: The instruction is decoded by the control unit, which generates signals that direct the flow of data through the ALU, registers, and memory.
            ▪ Execute: The instruction is executed based on the decoded signals, updating registers, memory, and the PC.

#### 5.6 Memory Access:
        ◦ Read/Write operations are performed with direct addressing. When executing an A-instruction, the value can directly correspond to an address or a constant value.
        ◦ For C-instructions, the results of computations can either be written to the D register or to memory. The M register refers to the memory at the address specified in the A register.
#### 5.7 Jump Logic:
        ◦ The HACK CPU supports conditional branching using jump instructions. The jump field in a C-instruction can trigger a jump based on the result of a computation. Jumps can be unconditional or conditional, based on conditions like negative, zero, or positive results of the ALU computation.
## 6. Module Wise Implementation

The HACK CPU was developed in a bottom-up manner, following the NAND2TETRIS hardware hierarchy. Each module was first implemented in the custom HDL format and then reimplemented in Verilog for simulation and FPGA deployment. The following section documents the design, function, and integration of each major group of components.<br><br>
### 6.1 Module 1: Basics 
This module contains the fundamental building blocks necessary for combinational logic design in the HACK architecture.<br><br>
    • **Primitive Logic Gates (AND, OR, NOT, XOR, NAND,NOR)**<br>
Implemented directly using Verilog’s bitwise operators; verified using exhaustive testbenches.<br><br>
    • **16-bit Gate Variants**<br>
        ◦ And16, Or16, Not16: Applied single-bit gates element-wise across 16-bit inputs.<br>
        ◦ Provided the foundation for bitwise operations in the ALU.<br><br>
    • **Multiplexers and Demultiplexers** <br>
        ◦ Mux16: Selected between two 16-bit inputs using a 1-bit selector. <br>
        ◦ Mux4Way16 and Mux8Way16: Cascaded Mux16 structures with 2-bit and 3-bit selectors respectively.<br>
        ◦ Demux4Way and Demux8Way: Implemented using logic to route a 1-bit input to one of multiple outputs. <br>
        ◦ Demux2x4:  demux structure with two select lines and four outputs. <br>
### 6.2 Module 2: Arithmetic Logic Unit 
This module implements the combinational core that performs all arithmetic and logic operations in the HACK CPU.<br><br>
    • **Half Adder and Full Adder**<br>
        ◦ HalfAdder: Computes sum and carry of 1-bit inputs.<br>
        ◦ FullAdder:  computes full 1-bit addition with carry-in and carry-out.<br><br>
    • **16-bit Incrementer**<br>
        ◦ Inc16: Adds one to a 16-bit input.<br><br>
    • **16-bit ALU**<br>
        ◦ Emulates the behavior specified by the HACK platform: supports zeroing, negation, addition, bitwise AND, and conditional output negation.<br>
        ◦ Takes six control bits to determine function selection.<br>
        ◦ Outputs 16-bit result, zero flag (zr), and negative flag (ng).<br>
### 6.3 Module 3: Memory
This module transitions the design from purely combinational logic to sequential logic using clocked elements.<br><br>
    • **D Flip-Flop (Bit)**<br>
        ◦ Serves as a 1-bit memory cell; foundation for all higher memory elements<br><br>
    • **Register**<br>
        ◦ Built from 16 D flip-flops<br>
        ◦ Stores a 16-bit <br><br>
    • **Hierarchical RAM Modules** <br>
Constructed in powers-of-two hierarchy for scalable memory: <br>
        ◦ RAM8: 8 registers with 3-bit address decoder <br>
        ◦ RAM64: 64-word memory using 8 RAM8 modules <br>
        ◦ RAM512: 512-word memory composed of 8 RAM64 units <br>
        ◦ RAM4K: 4K-word memory (4096 x 16-bit) using 8 RAM512 modules <br>
        ◦ RAM16K: Top-level RAM module used in the HACK computer, composed of 4 RAM4K blocks <br><br>
    • **Program Counter (PC)** <br>
A 16-bit counter that holds the address of the next instruction to execute <br> <br>

### 6.4 Module 4: Assembly 
The module introduces the basic instructions that can be used in the assembly code for HACK CPU, which is very low-level and works directly with memory and registers. <br><br>
 Types of Instructions: <br>
    • **A-instruction**: This instruction sets the value of the A register (which holds addresses or constant values). Example: @5 will set the A register to 5.<br><br>
    • **C-instruction**: The computational instruction, used to perform operations on registers and memory. <br> It consists of a computation part (which specifies the operation), a destination (which specifies where to store the result), and a jump condition (which determines whether a jump should be made). Example: D=A+1 will add 1 to the value in register A and store the result in register D. <br><br>
**Program Flow Control:** <br>
    • Jumps: Instructions like JMP, JEQ, JNE, etc., are used for conditional and unconditional jumps in the program based on certain conditions. <br><br>
 Assembling the Code: The HACK CPU doesn't understand human-readable code, so it needs to be translated (assembled) into machine code. The module shows how to manually translate assembly into binary. <br> 

### 6.5 Module 5: CPU Architecture <br>
This module explains how the HACK CPU works and how to build its architecture using HDL. It covers how the CPU processes two types of instructions - A-instructions and C-instructions , and how these control the data flow and program execution. <br><br>
    • **The A-instruction** starts with a 0 and is u sed to load a 15-bit constant or memory address into the A-register (e.g., @21 becomes 0 000000000010101) <br>
    • The **C-instruction** starts with 111 and is used for computations. 
    
    Its format is :
				111 a cccc cc ddd jjj <br>

where the a and c bits control the ALU operation, d bits select the destination (A, D, or M), and j bits specify the jump condition (like JEQ, JNE, etc.).<br><br> 
The CPU includes components like the A-register, D-register, program counter, and ALU. Control logic determines when to write to registers or jump to a new instruction. Finally, the module combines the CPU with memory (RAM and ROM) and I/O devices to build the full Hack computer, capable of running machine-level programs. <br> <br> 
## 7. FPGA Implementation 

### 7.1 Overview of the FPGA-Based System

The project implements a **modified version of the HACK CPU** on the **Basys 3 FPGA development board**, where instructions are **manually input by the user** instead of being fetched from an instruction memory. The system is designed for **single-step execution**, allowing close observation of CPU behavior at the register-transfer level.

Unlike the conventional HACK architecture, this implementation:

* Eliminates **instruction memory**
* Eliminates the **program counter (PC)**
* Eliminates **jump logic**
* Executes **one instruction per user button press**

The FPGA design integrates:

* A **CPU core** (A register, D register, ALU, control logic)
* A **manual instruction input interface** (slide switches + pushbutton)
* A **VGA display interface** for real-time visualization of internal CPU state

###  7.2 Physical Inputs and Outputs on Basys 3

#### 7.2.1 Instruction Input

* **16 slide switches** (`SW[15:0]`) are used to manually input a 16-bit HACK instruction.
* Since slide switches cannot be toggled simultaneously, instruction execution is controlled using a **pushbutton (BTNC)**.
* The instruction is latched only when the button is pressed, ensuring correct and stable instruction input.

#### 7.2.2 Control Buttons

| Button   | Function                                   |
| -------- | ------------------------------------------ |
| **BTNC** | Executes the currently entered instruction |
| **BTNU** | Resets the entire system                   |

The reset button is mapped via the FPGA constraints file and performs a **system-level reset**, initializing all registers and display logic.


### 7.3 High-Level System Architecture

The FPGA design is organized hierarchically into three major blocks:

```
Top Module
 ├── CPU Core
 │    ├── A Register
 │    ├── D Register
 │    ├── ALU
 │    └── Control Logic
 │
 ├── Instruction Interface
 │    ├── Switch Input
 │    ├── Button Debounce
 │    └── Instruction Latching
 │
 └── VGA Display Controller
      ├── Timing Generator
      ├── Character Renderer
      └── State Visualization
```

The **Top Module** acts as an **interface layer** between the user and the CPU, similar to a *proto-assembler*, but without any instruction decoding assistance.


### 7.4 Instruction Handling and Execution Flow

#### 7.4.1 Instruction Fetch (Manual)

Since there is no instruction memory, instruction fetch is replaced by **manual latching**:

1. User sets the instruction bits using slide switches.
2. User presses **BTNC**.
3. The 16-bit value on the switches is captured into `current_instruction`.
4. The instruction is stored in an internal instruction history buffer for display.

This ensures that partial or unstable switch transitions do not affect execution.

#### 7.4.2 Instruction Execution Model

The CPU follows a **two-phase single-step model** implemented in hardware:

| Phase   | Description                                 |
| ------- | ------------------------------------------- |
| Fetch   | Latch instruction from switches             |
| Execute | Decode and execute instruction exactly once |

This is controlled using  register (`execute_pending`) to guarantee **one execution per button press**.

### 7.5 Modified HACK Instruction Set Implementation

### 7.5.1 A-Instruction

* Identified when `instruction[15] = 0`
* The lower 15 bits are loaded **directly into the A register**
* The ALU is **not used** during A-instruction execution

```text
@value → A = value
```

This matches the original HACK ISA behavior.

---

#### 7.5.2 C-Instruction (Without Jump Logic)

* Identified when `instruction[15] = 1`
* Jump bits are ignored
* The ALU is always active for C-instructions
* The ALU output (`outM`) is routed to destination registers based on `dest` bits

| Destination Bit | Effect                     |
| --------------- | -------------------------- |
| `dest_A`        | Load ALU output into A     |
| `dest_D`        | Load ALU output into D     |
| `dest_M`        | Write ALU output to memory |

The **D register can only be written through the ALU**, consistent with the HACK architecture.

### 7.6 ALU Control and Operation

The ALU operates exactly as defined in the HACK specification:

* Inputs: `A` and `D`
* Control bits: `zx nx zy ny f no`
* Output: `outM`
* Flags: `zr` (zero), `ng` (negative)

The ALU is **purely combinational**, meaning:

* No internal clock
* Output updates immediately when inputs or control bits change

Since ALU inputs and control bits are stable during execution, additional clock gating is unnecessary.

Even though no full RAM is implemented, `outM` and `mem_load` replicate correct HACK memory semantics.


## 7.7 VGA-Based Visualization

The VGA output is used to visualize CPU state in real time, divided into three regions:

#### 7.7.1 Display Layout

| Screen Region | Displayed Information         |
| ------------- | ----------------------------- |
| Left half     | Instruction history           |
| Top-right     | A and D register values       |
| Bottom-right  | ALU output (`outM`) and flags |

This provides **immediate feedback** after each instruction execution.

#### 7.7.2 VGA Timing and Rendering

* VGA operates independently using the 100 MHz FPGA clock
* Pixel timing counters generate synchronization signals
* The CPU state is sampled and displayed continuously

The VGA module does **not interfere** with CPU execution and functions purely as a monitoring interface.


### 7.8 Reset Strategy

Although the original HACK CPU has no reset signal, the FPGA implementation includes a **system reset**:

* Mapped to **BTNU**
* Resets:

  * A register
  * D register
  * Instruction history
  * VGA timing counters
  * Control flags

This ensures a known initial state after configuration or user reset.


### 7.10 Summary

The project successfully demonstrates a **hardware-realized CPU datapath** implemented on an FPGA, closely following the HACK architecture while adapting it for manual instruction input and real-time visualization. The design bridges the gap between theoretical computer architecture and practical digital system implementation.

## 8. Testing and Verification Strategy 
## 9. Issues Documentation
| No. | Issue                                         | Technical Cause                                                      | Observed Behavior                                                                    | Resolution                                                                             |
| --- | --------------------------------------------- | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| 1   | A register width error                        | A register treated as full 16-bit value instead of 15-bit data field | Garbage MSB propagated into A register, causing invalid addresses and operand values | Masked MSB and loaded only lower 15 bits during A-instruction handling                 |
| 2   | Incorrect ALU control bit mapping             | ALU control bits wired to incorrect instruction bit positions        | ALU performed unintended operations for valid C-instructions                         | Rewired ALU control signals to match correct HACK instruction format                   |
| 3   | Incorrect destination bit wiring              | destA, destD, destM fields mapped incorrectly                        | D register did not update correctly during C-instructions                            | Corrected destination bit decoding and wiring to proper register enables               |
| 4   | Fetch and execute in same cycle               | No separation between instruction latch and execution logic          | Registers not updated before being used, causing stale/garbage values                | Separated fetch and execute into different clock cycles                                |
| 5   | Repeated execution due to clock/control logic | Execution enable remained asserted after single instruction          | C-instructions executed continuously (e.g., D=D+1 incrementing forever)              | Added 1-bit execution control register to allow exactly one execution per button press |

## 10. Quality of Results
### 10.1 Power Analysis 

The post-implementation power analysis indicates that the design operates at very low total power, consistent with a lightweight educational CPU and VGA-based debugging system.


- Total On-Chip Power: 0.094 W
- Device Static Power: 0.072 W (76%)
- Dynamic Power: 0.022 W (24%)

This indicates that the majority of power consumption is dominated by static leakage power of the FPGA device, with relatively low switching activity from the implemented logic.

#### 10.1.2 Dynamic Power Breakdown
| Component | Power (W) | Percentage of Dynamic Power |
| --------- | --------- | --------------------------- |
| Clocks    | 0.002 W   | 9%                          |
| Signals   | 0.009 W   | 39%                         |
| Logic     | 0.011 W   | 51%                         |
| BRAM      | 0.000 W   | 0%                          |
| I/O       | < 0.001 W | 1%                          |


The dominant contributors to dynamic power are:

- Logic (51%), due to combinational and sequential CPU datapath activity.

- Signals (39%), due to internal signal toggling, including VGA and CPU interconnects.

The negligible BRAM and I/O power confirms that the design relies primarily on distributed logic and does not heavily utilize on-chip block memory resources.

#### 10.1.3 Thermal Characteristics 

- Junction Temperature: 25.5 °C
- Ambient Temperature: 25.0 °C
- Thermal Margin: 59.5 °C
- Effective θJA: 5.0 °C/W

The low junction temperature and large thermal margin indicate that the design operates well within safe thermal limits, with no thermal constraints affecting operation.

### 10.2 Timing Analysis 

The static timing analysis confirms that all user-specified timing constraints are fully met.

#### 10.2.1 Setup Timing

- Worst Negative Slack (WNS): +2.509 ns
- Total Negative Slack (TNS): 0.000 ns
- Number of Failing Endpoints: 0
- Total Endpoints: 521

A positive WNS of 2.509 ns indicates comfortable setup timing margin, confirming that the design meets setup requirements with significant slack.

#### 10.2.2 Hold Timing

- Worst Hold Slack (WHS): +0.197 ns
- Total Hold Slack (THS): 0.000 ns
- Number of Failing Endpoints: 0
- Total Endpoints: 521

All hold timing requirements are satisfied, with no hold violations across the design.

#### 10.2.3 Pulse Width Timing

- Worst Pulse Width Slack (WPWS): +4.500 ns
- Total Pulse Width Negative Slack (TPWS): 0.000 ns
- Number of Failing Endpoints: 0
- Total Endpoints: 436

Pulse width constraints are also fully met, indicating robust clock and control signal integrity.

### Overall Quality of Results (QoR)

- All timing constraints are met with positive slack.
- No setup, hold, or pulse width violations are present.
- Power consumption is very low (0.094 W total).
- Thermal margins are large, indicating no thermal stress.
- The design demonstrates stable timing closure and efficient power behavior.

## 11. Summary 
This project aimed to reimplement the HACK computer architecture using Verilog, an industry-standard hardware description language. Unlike the course’s simplified HDL and simulation tools, our approach used real-world design environments such as Xilinx Vivado , paving the way for eventual FPGA deployment.

The implementation was modular, beginning with basic logic gates and progressing through the ALU, memory units, and the Program Counter. Each component was carefully designed, tested, and debugged to ensure compatibility with the HACK architecture. The project did not rely on prebuilt libraries, maintaining the spirit of building a computer “from the ground up.”

## 12. Learning Outcomes 
Through the course of this project, we gained hands-on experience in:<br><br>
    • Verilog HDL: Writing synthesizable and testable Verilog modules from scratch.<br>
    • Digital Design Principles: Understanding hierarchical circuit design, clocking, memory addressing, and control flow.<br>
    • Simulation and Debugging: Using Icarus Verilog and GTKWave to visualize signal transitions and validate hardware logic.<br>
    • Toolchain Familiarity: Gaining confidence in working with Vivado and Msys-based Verilog environments.<br>
    • Computer Architecture Fundamentals: Deepening our understanding of how CPUs are built and how low-level hardware executes programs.<br> 
