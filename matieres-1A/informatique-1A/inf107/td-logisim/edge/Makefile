UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=edgedetect-impl.circ
SPEC=edgedetect-spec.circ
TESTBENCH=edgedetect-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/edgedetect.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/edgedetect.gtkw

SIGSPEC=clk 1 D 1 TOP 1[color=red]

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
