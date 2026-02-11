import cocotb
import random

from cocotb.triggers import RisingEdge, Timer

# Test bench for sign extension module at src/signext.sv


@cocotb.test()
async def signext_test(dut):
    dut.imm_source = 0b000
