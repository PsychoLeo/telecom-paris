UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=ser2par-impl.circ
SPEC=ser2par-spec.circ
TESTBENCH=ser2par-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/ser2par.vcd
SPECFILE=$(WAVE_DIR)/spec.sim
GTKWFILE=$(WAVE_DIR)/ser2par.gtkw

SIGSPEC=clk 1 reset 1 Sin 1 Pout 4[hex,color=red] valid 1[color=red]

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
