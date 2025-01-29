UTILS_DIR=../utils
WAVE_DIR=./vcd
CIRCUIT=counter-impl.circ
TESTBENCH=counter-tb.circ
VCDVIEWER=gtkwave
WAVEFILE=$(WAVE_DIR)/counter.vcd
GTKWFILE=$(WAVE_DIR)/counter.gtkw

SIGSPEC=clk 1 reset 1 count 4[color=red]

.PHONY: all clean view

default all: $(WAVE_DIR) view

$(WAVE_DIR):
	mkdir -p $(WAVE_DIR)

view: $(WAVEFILE)
	$(VCDVIEWER) $(GTKWFILE)
	
clean:
	rm -rf $(WAVEFILE) $(GTKWFILE)
	
$(WAVEFILE): $(CIRCUIT) $(TESTBENCH)
	logisim -tty table $(TESTBENCH) | $(UTILS_DIR)/logisim2vcd.py $@ $(SIGSPEC)
