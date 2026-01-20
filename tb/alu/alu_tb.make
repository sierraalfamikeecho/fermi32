# Makefile

# defaults
SIM ?= verilator
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)src/alu.sv

COCOTB_TOPLEVEL = ALU

COCOTB_TEST_MODULES = ALU_TB

include $(shell cocotb-config --makefiles)/Makefile.sim
