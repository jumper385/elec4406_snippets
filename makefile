# Variables
VHD_FILES := $(wildcard *.vhd)
ELAB_TARGETS := $(VHD_FILES:.vhd=)

# Custom entity name and stop time for simulation
ENTITY_NAME := counter.vhd
STOP_TIME := 10000000ns

# Default target
all: $(ELAB_TARGETS)

# Compile VHDL files
%.o: %.vhd
	ghdl -a $<

# Elaborate the design
%: %.o
	ghdl -e $@

# Clean generated files
clean:
	ghdl --clean

# For GTKWave simulation
run: all
	ghdl -r $(ENTITY_NAME) --stop-time=$(STOP_TIME) --fst=$(ENTITY_NAME).fst
	open $(ENTITY_NAME).fst &

.PHONY: all clean run
