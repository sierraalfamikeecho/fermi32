# Memory module test bench
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCE += ../src/memory.sv

COCOTB_TOPLEVEL += memory_tb.py

COCOTB_TEST_MODULES += memory

include $(shell cocotb-config --makefiles)/Makefile.sim
