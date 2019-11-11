# vhdl files
FILES = src/*
VHDLEX = .vhd
 
# testbench
TESTBENCHPATH = tb/${TESTBENCH}$(VHDLEX)
 
#GHDL CONFIG
GHDL_CMD = ghdl
GHDL_FLAGS  = 
 
SIMDIR = simu/
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=1000ns
 
WAVEFORM_VIEWER = gtkwave
 
all: check_files check_tb compile view
 
check_files:
	$(GHDL_CMD) -s $(GHDL_FLAGS) $(FILES)

check_tb:
ifeq ($(strip $(TESTBENCH)),)
		@echo "TESTBENCH not set. Use TESTBENCH=value to set it."
		@exit 2
endif
	$(GHDL_CMD) -s $(GHDL_FLAGS) $(TESTBENCHPATH)

compile:
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(TESTBENCHPATH) $(FILES)
	$(GHDL_CMD) -e $(GHDL_FLAGS) $(TESTBENCH)
	$(GHDL_CMD) -r $(TESTBENCH) $(GHDL_SIM_OPT) --vcd=$(TESTBENCH).vcd
 
view:
	@gtkwave *.vcd
 
clean:
	@rm -rf *.vcd *.cf
