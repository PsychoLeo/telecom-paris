UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=addsub-impl.circ
SPEC=addsub-spec.circ
TESTBENCH=addsub-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/addsub.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/addsub.gtkw

SIGSPEC=A 8[dec,signed] B 8[dec,signed] sub 1 Y 8[dec,signed]

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
