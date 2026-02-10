
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += $(PWD)../../src/program_counter.sv

COCOTB_TOPLEVEL += memory_tb.py

COCOTB_TEST_MODULES += memory

include $(shell cocotb-config --makefiles)/Makefile.sim
