SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += $(PWD)../../src/register_file.sv

COCOTB_TOPLEVEL += regfile_tb.py

COCOTB_TEST_MODULES += RegisterFile

include $(shell cocotb-config --makefiles)/Makefile.sim
