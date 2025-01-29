UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=add-impl.circ
SPEC=add-spec.circ
TESTBENCH=add-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/add.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/add.gtkw

SIGSPEC=a 1 b 1 c 1 cout 1 s 1

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
