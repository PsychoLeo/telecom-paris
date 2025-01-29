UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=dec-impl.circ
SPEC=dec-spec.circ
TESTBENCH=dec-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/dec.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/dec.gtkw

SIGSPEC=E0 1 E1 1 S0 1 S1 1 S2 1 S3 1

.PHONY: all clean view

default all: $(WAVE_DIR) view

$(WAVE_DIR):
	mkdir -p $(WAVE_DIR)

view: $(WAVEFILE)
	$(VCDVIEWER) $(GTKWFILE)
	
clean:
	rm -rf $(WAVEFILE) $(GTKWFILE) $(SPECFILE)

%.mem: %.asm
	$(ASSEMBLER) -o $@ $<
	
$(SPECFILE): $(SPEC) $(CIRCUIT) $(TESTBENCH)
	logisim -tty table $(TESTBENCH) -sub $(CIRCUIT) $(SPEC) > $@

$(WAVEFILE): $(SPECFILE) $(CIRCUIT) $(TESTBENCH) $(SPEC)
	logisim -tty table $(TESTBENCH) | $(UTILS_DIR)/logisim2vcd.py $@ -spec $(SPECFILE) $(SIGSPEC)
