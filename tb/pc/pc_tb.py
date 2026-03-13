import random

import cocotb
from cocotb.triggers import Timer


# program counter testbench
@cocotb.test()
async def reset_test(dut):
    dut.pc_in = random.randint(0, 0xFFFFFF)
    dut.reset = 0b1
    Timer(1, unit="ns")
    assert dut.pc_out == dut.pc_in


@cocotb.test()
async def program_counter(dut):
    dut.pc_in = random.randint(0, 0xFFFFFF)
    dut.reset = 0b0
    Timer(1, unit="ns")
    assert dut.pc_out == (dut.pc_in + 4)

@cocotb.test()
async def write_enable(dut):
    dut.write_enable = 1
    dut.address3 = random.randint(1, 0xFFFFFF)
    dut.write_data = random.randint(0,0xFFFFFF)
    await Timer(1, unit="ns")
    assert (dut.register[dut.address3] == dut.write_data)

@cocotb.test()
async def read_test(dut):
    assert dut.read_data1 == dut.registers[dut.address1]
    assert dut.read_data2 == dut.registers[dut.address2]
