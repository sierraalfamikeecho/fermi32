import random

import cocotb
from cocotb.triggers import Timer

# Test bench for register file

@cocotb.test()
async def we3_test(dut):
    dut.WE3 = 0b1
    dut.WD3 = random.randint(0, 0x7FFFFFF)
    await Timer(1, unit="ns")
    for _ in range(4):
        assert dut.register_file[dut.A3] == dut.WD3

@cocotb.test()
async def register_data_test(dut):
    dut.A1 = 1
    await Timer(1, unit="ns")
    assert dut.RD1 == dut.register_file[dut.A1]

    dut.A2 = 1
    await Timer(1, unit="ns")
    assert dut.RD2 == dut.register_file[dut.A2]
