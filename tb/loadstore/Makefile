# Makefile

# defaults
SIM ?= verilator

TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)../../src/loadStoreDecoder.sv

EXTRA_ARGS += --trace --trace-structs

COCOTB_TOPLEVEL = loadStoreDecoder.sv

COCOTB_TEST_MODULES = loadstore_tb

include $(shell cocotb-config --makefiles)/Makefile.sim
