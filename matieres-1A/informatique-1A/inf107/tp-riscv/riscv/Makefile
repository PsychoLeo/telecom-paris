TARGETS=r2r imm load loadstore branch
VCD_FILES=$(addprefix vcd/test-,$(addsuffix .vcd,$(TARGETS)))

# Variables for logisim circuit simulation 
CIRCUITS=$(addprefix riscv-,$(addsuffix(.circ,$(TARGETS))))
VCDVIEWER=gtkwave
LOGISIM=logisim -tty table
SIM2VCD=../utils/logisim2vcd.py
WAVEFILES=$(addsuffix .vcd,$(TARGETS))
MEMFILES=$(addprefix asm/,$(addsuffix -test.mem,$(TARGETS)))
GTKWFILES=$(addsuffix .gtkw,$(TARGETS))

# Variables for RISCV assembler
PREFIX = riscv64-unknown-elf-
CC = $(PREFIX)gcc
AS = $(PREFIX)as
LD = $(PREFIX)ld
LSDUMP = ../utils/lsdump.py
OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump
CFLAGS = -march=rv32e -mabi=ilp32e
ASFLAGS = -march=rv32e
LDFLAGS = -Ttext 0 -melf32lriscv

ASM_FILES = $(wildcard asm/*.asm)
MEM_FILES = $(subst .asm,.mem,$(ASM_FILES))

# Signal specifications for logisim to vcd conversion
SIGSPEC_R=clk 1[color=orange] reset 1 pc 32 I 32[hex] rd 4 rs1 4 rs2 4 write 1 ALUsrc 1 Op1 32[signed] Op2 32[signed] op '4{ADD,SLL,SLT,SLTU,XOR,SRL,OR,AND,SUB,1001,1010,1011,1100,SRA,1110,1111}[color=blue]' Res 32[signed]

SIGSPEC_LOAD=clk 1[color=orange] reset 1 pc 32 I 32[hex] rd 4 rs1 4 rs2 4 write 1 ALUsrc 1 load 1 Op1 32[signed] Op2 32[signed] op '4{ADD,SLL,SLT,SLTU,XOR,SRL,OR,AND,SUB,1001,1010,1011,1100,SRA,1110,1111}[color=blue]' Res 32[hex]

SIGSPEC_STORE=clk 1[color=orange] reset 1 pc 32 I 32[hex] rd 4 rs1 4 rs2 4 write 1 ALUsrc 1 load 1 store 1 Op1 32[signed] Op2 32[signed] op '4{ADD,SLL,SLT,SLTU,XOR,SRL,OR,AND,SUB,1001,1010,1011,1100,SRA,1110,1111}[color=blue]' Res 32[hex]

SIGSPEC_BRANCH=clk 1[color=orange] reset 1 pc 32 I 32[hex] rd 4 rs1 4 rs2 4 write 1 ALUsrc 1 load 1 store 1 branch 1 taken 1 Op1 32[signed] Op2 32[signed] op '4{ADD,SLL,SLT,SLTU,XOR,SRL,OR,AND,SUB,1001,1010,1011,1100,SRA,1110,1111}[color=blue]' Res 32[hex]

.PHONY: all clean test_r2r

default all: vcd $(MEM_FILES) $(VCD_FILES)

vcd:
	mkdir -p vcd 

	
# Rules for processor simulations following the different exercises:	
	
vcd/test-r2r.vcd: riscv-r.circ asm/test-r2r.mem vcd 
	$(LOGISIM) -load $(word 2,$^) $< | $(SIM2VCD) $@ -spec spec/r2r.sim $(SIGSPEC_R)

vcd/test-imm.vcd: riscv-r.circ asm/test-imm.mem vcd
	$(LOGISIM) -load $(word 2,$^) $< | $(SIM2VCD) $@ -spec spec/imm.sim $(SIGSPEC_R)

vcd/test-load.vcd: riscv-load.circ asm/test-load.mem vcd 
	$(LOGISIM) -load $(word 2,$^) $< | $(SIM2VCD) $@ -spec spec/load.sim $(SIGSPEC_LOAD)
	
vcd/test-loadstore.vcd: riscv-loadstore.circ asm/test-loadstore.mem vcd
	$(LOGISIM) -load $(word 2,$^) $< | $(SIM2VCD) $@ -spec spec/loadstore.sim $(SIGSPEC_STORE)
	
vcd/test-branch.vcd: riscv-branch.circ asm/test-branch.mem vcd 
	$(LOGISIM) -load $(word 2,$^) $< | $(SIM2VCD) $@ $(SIGSPEC_BRANCH)

	
# Main test targets:

test_r2r: vcd/test-r2r.vcd 
	$(VCDVIEWER) vcd/test-r2r.gtkw

test_imm: vcd/test-imm.vcd 
	$(VCDVIEWER) vcd/test-imm.gtkw
	
test_load: vcd/test-load.vcd 
	$(VCDVIEWER) vcd/test-load.gtkw 

test_store: vcd/test-loadstore.vcd 
	$(VCDVIEWER) vcd/test-loadstore.gtkw
	
test_branch: vcd/test-branch.vcd 
	$(VCDVIEWER) vcd/test-branch.gtkw
	
	
# Assembler to memory map rules:
%.mem: %.hex
	$(LSDUMP) $< -o $@ -v2
	
%.hex: %.x
	$(OBJCOPY) -O verilog -j .text $< $@
	$(OBJDUMP) $< -d -j .text

%.x: %.o
	$(LD) $(LDFLAGS) $< -o $@

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@


	
clean:
	rm -rf vcd 
	rm -f $(MEM_FILES) asm/*.x asm/*.o asm/*.hex


