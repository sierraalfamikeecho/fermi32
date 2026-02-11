
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += $(PWD)../../src/reader.sv

COCOTB_TOPLEVEL += reader_tb.py

COCOTB_TEST_MODULES += reader

include $(shell cocotb-config --makefiles)/Makefile.sim
