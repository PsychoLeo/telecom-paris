UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=dff-impl.circ
SPEC=dff-spec.circ
TESTBENCH=dff-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/dff.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/dff.gtkw

SIGSPEC=clk 1[color=orange] reset 1 en 1 D 1 Q 1

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
