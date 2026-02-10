SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += $(PWD)../../src/signext.sv

COCOTB_TOPLEVEL += signext_tb.py

COCOTB_TEST_MODULES += signext
include $(shell cocotb-config --makefiles)/Makefile.sim
