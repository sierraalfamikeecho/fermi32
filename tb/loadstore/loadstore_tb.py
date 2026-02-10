import random

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def load_store_test(dut):
    dut.f3.value = 0b000
