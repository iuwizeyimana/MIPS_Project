SRC_DIR = src/

# vhdl files
VHDLEX = .vhd
TBLEX = _tb

# testbench
TESTBENCH = ${FILE}${TBLEX}
TESTBENCHPATH = tb/${FILE}$(TBLEX)$(VHDLEX)

#GHDL CONFIG
GHDL_CMD = ghdl
GHDL_FLAGS  = --ieee=synopsys 
 
SIMDIR = simu/
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_SIM_OPT = --stop-time=58ns
 
WAVEFORM_VIEWER = gtkwave
 
all: check_file check_tb compile view
 
check_file:
ifeq ($(strip $(FILE)),)
		@echo "FILE not set. Use FILE=value to set it."
		@echo "Make sure you have an associated testbench file as well!"
		@exit 2
endif
	$(GHDL_CMD) -s $(GHDL_FLAGS) src/$(FILE)$(VHDLEX)

check_tb:
ifeq ("$(wildcard $(TESTBENCHPATH))", "")
		@echo "You don't have the associated testbench file!"
		@echo "Put your testbench in tb/ with suffix _tb."
		@exit 2
endif
	$(GHDL_CMD) -s $(GHDL_FLAGS) $(TESTBENCHPATH)

compile: $(check_file) $(check_tb)
ifeq ("$(FILE)", "mips")
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(TESTBENCHPATH) src/*.vhd
else ifeq ("$(FILE)", "mips_wo_mem")
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(TESTBENCHPATH) src/*.vhd
else
	$(GHDL_CMD) -a $(GHDL_FLAGS) $(TESTBENCHPATH) src/$(FILE)$(VHDLEX)
endif
	$(GHDL_CMD) -e $(GHDL_FLAGS) $(TESTBENCH)
	$(GHDL_CMD) -r $(GHDL_FLAGS) $(TESTBENCH) $(GHDL_SIM_OPT) --vcd=$(TESTBENCH).vcd
	-rm -rf ${TESTBENCH}
 
view:
	-gtkwave ${TESTBENCH}.vcd
 
clean:
	-rm -rf *.vcd *.cf *.o
