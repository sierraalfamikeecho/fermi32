import cocotb
import random

from cocotb.triggers import RisingEdge, Timer

# Test bench for sign extension module at src/signext.sv


@cocotb.test()
async def signext_test(dut):
    dut.imm_source = 0b111
    await Timer(1, unit="ns")
    assert (dut.immediate == 0b0)

    dut.imm_source = 0b000
    await Timer(1, unit="ns")
    #Assert

    dut.imm_source =  0b001
    await Timer(1, unit="ns")
    #Assert

    dut.imm_source =  0b010
    await Timer(1, unit="ns")
    #Assert

    dut.imm_source = 0b011
    await Timer(1, unit="ns")
    #Assert

    dut.imm_source = 0b100
    await Timer(1, unit="ns")
    #Assert
