UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=mux-impl.circ
SPEC=mux-spec.circ
TESTBENCH=mux-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/mux.vcd
SPECFILE=$(WAVE_DIR)/mux.sim
GTKWFILE=$(WAVE_DIR)/mux.gtkw

SIGSPEC=DIN0 1 DIN1 1 Sel 1 DOUT 1[color='red']

.PHONY: all clean view

default all: $(WAVE_DIR) view

$(WAVE_DIR):
	mkdir -p $(WAVE_DIR)

view: $(WAVEFILE)
	$(VCDVIEWER) $(GTKWFILE)
	
clean:
	rm -rf $(WAVEFILE) $(GTKWFILE) $(SPECFILE)
	
$(SPECFILE): $(SPEC) $(CIRCUIT) $(TESTBENCH)
	logisim -tty table $(TESTBENCH) -sub $(CIRCUIT) $(SPEC) > $@

$(WAVEFILE): $(SPECFILE) $(CIRCUIT) $(TESTBENCH) $(SPEC)
	logisim -tty table $(TESTBENCH) | $(UTILS_DIR)/logisim2vcd.py $@ -spec $(SPECFILE) $(SIGSPEC)
