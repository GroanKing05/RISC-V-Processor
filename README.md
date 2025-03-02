# Sequential RISC-V Processor in iVerilog

**One might think it's little endian or big endian, but you'll be surprised to know it's PROUD INDIAN o7**

This is a basic RISC-V processor implemented in iVerilog, as part of the course project for the Spring 25' course "Intro. to Processor Architecture" at IIIT Hyderabad. The components in the sequential processor are mentioned below.

Team Name - Tervis Scoot

Team Members - Siddarth G, Varun S, M. Samartha

## PC

- INPUTS: `clk`,`reset`, `pc_in`
- OUTPUT: `pc_out`

The PC is a 64-bit register that stores the address of the current instruction. The PC is incremented by 4 (32-bit instructions) after every instruction, unless there is a branch, in which it is updated according to the branch target address. The PC is updated with the value of `pc_in` every clock cycle, so it does not need an exclusive write signal.

## Register File

- INPUTS: `clk`, `reset`, `read_reg1`, `read_reg2`, `write_reg`, `write_data`, `reg_write_en`

- OUTPUTS: `read_data1`, `read_data2`

- We slice the 32-bit instruction into two, 5-bit data fields which are the register addresses, which read the data from the register file, and output them as `read_data1` and `read_data2`.

- READ is always happening, WRITE only happens when `reg_write_en` is 1.

- `write_data` is a 64-bit line, for the data to be written into the register, given by line `write_reg`.

- `Read_data1` is directly hard-wired to ALU Input 1.

- Hardcode 32 registers in an initial block.

## Instruction Memory

- INPUTS: `clk`, `reset`, `addr`

- OUTPUTS: `instr`

This extracts 32-bits corresponding to the instruction indicated by the program counter (PC). Again, READ is always happening. Read happens from the text file containing the instructions. Instructions are constructed from memory in **Little Endian** format.

## Control Unit

- INPUTS: `opcode`

- OUTPUTS: `Branch`, `MemRead`, `MemtoReg`, `ALUOp`, `MemWrite`, `ALUSrc`, `RegWrite`

- This block reads the opcode and generates the control signals for the rest of the processor.

- `Branch` is set to 1 if the instruction is a branch instruction.

- `MemRead` is set to 1 if the instruction is a load instruction.

- `MemtoReg` is set to 1 if the instruction is a load instruction.

- `ALUOp` is set to 00 if the instruction is an R-type instruction, 01 if the instruction is an I-type instruction, 10 if the instruction is an S-type instruction, and 11 if the instruction is a branch instruction.

- `MemWrite` is set to 1 if the instruction is a store instruction.

- `ALUSrc` is set to 1 if the ALU second input is the value generated by the immediate block.

- `RegWrite` is set to 1 if the instruction is a load instruction for write-back.

## Immediate Generation

- INPUTS: `instruction`

- OUTPUTS: 64-bit signed extended `immediate` value.

- This block reads the instruction and extracts the immediate value (sign-extended). The immediate value is then stored in a 64-bit bus, determined by the instruction type, referring the `RISC-V Card`.

## ALU Control

- INPUTS: 2-bit `ALUOp`, `instruction [30,14-12]`

- OUTPUTS: 4-bit `ALUControl`

- The reason why other instruction bits are not considered (in the input) is because they are pre-determined (see below).

![ALUControl truth table](ALUControl_truth_table.jpg)

- The ALUControl block reads the ALUOp and the instruction bits and generates the control signal for the ALU, to determine the operation to be performed.

## ALU

- INPUTS: `input1`, `input2`, `control_signal`

- OUTPUTS: `result`, `zero_flag`

The ALU takes the two inputs values and performs the operation according to the control signal provided by the ALU Control. The result is stored in `result` and if the result of the ALU operation is zero, the status for the same is stored in `zero_flag`.

## Data Memory

- INPUTS: `clk`, `reset`, `address`, `Write_data`, `MemRead`, `MemWrite`

- OUTPUTS: `read_data`

The data memory block reads the address and reads the data from the memory. If the instruction is a store instruction (`MemWrite` is asserted), the data is written to the memory. For a load, `MemRead` is asserted, and the data is read from the memory and output as `read_data`.

## MUXes

Apart from these main datapath units, we also have MUXes at three different locations in the datapath. 

1) **Second input to the ALU**, whether it comes from the immediate generation block or the register file. This is controlled by the `ALUSrc` signal.

2) **Input in WriteBack**, whether it comes from the ALU (R-type instruction) or the data memory (load instruction). This is controlled by the `MemtoReg` signal.

3) **Branch Target Address**, whether it comes from the immediate generation block or the PC + 4. This is controlled by the logical AND of the `Branch` signal, and the `z_flag` from the ALU.

## Adder Block

The adder blocks are instantiations of the carry look-ahead adder, which is used to calculate the branch target address, and for PC + 4.

# The Sequential Processor!

This gives us the final datapath for the sequential processor like in the figure below!

Instructions supported: and, sub, add, or, ld, sd and beq.

![Sequential Datapath](Seq_Datapath.png)

Few Notes:

- `test_program_4.txt` contains instructions for checking arithmetic, logical, sd, ld, beq basic checking (18 instr)

- `test_program_5.txt` contains instructions for checking vector addition (34 instructions)

- `test_program_5.txt` contains untampered instructions for checking vector addition (34 instructions)

- Arithmetic and Logical test instructions count: first 8
(first 32 lines of `test_program_4.txt`)

- SD and LD test instructions count: next 4
(lines 33-48 of `test_program_4.txt`)

- BEQ test instructions count: next 6
(lines 49-64 of `test_program_4.txt`)