import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

#test bench for the unified memory file
@cocotb.test()
async def nrst_test(dut):
    dut.nrst = 0b0
    await Timer(10, unit="ns")
    assert int(dut.read_data) == 0

@cocotb.test()
async def mem_test(dut):
    dut.write_enable = 1
    dut.address = random.randint(0, 0xFFFFFFFF)
    dut.byte_enable = 0x6F
    await Timer(10, unit="ns")
    assert int(dut.read_data) == int(dut.write_data)
