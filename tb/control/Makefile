
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += $(PWD)/../../src/control.sv

COCOTB_TOPLEVEL += control_tb.py

COCOTB_TEST_MODULES += control

include $(shell cocotb-config --makefiles)/Makefile.sim
