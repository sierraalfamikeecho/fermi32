import random

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def load_store_test(dut):
    word = 0x123ABC00
    # Store Word
    dut.f3.value = 0b010

    for _ in range(100):
        register_data = random.randint(0, 0xFFFFFFFF)
        dut.register_read.value = register_data
        for offset in range(4):
            dut.alu_result_address.value = word | offset
            await Timer(1, unit="ns")
            assert dut.data.value == register_data & 0xFFFFFFFF
            if offset == 0b00:
                assert dut.byte_enable.value == 0b1111
            else:
                assert dut.byte_enable.value == 0b0000

    # Store Byte
    await Timer(10, unit="ns")

    dut.f3.value = 0b000

    for _ in range(100):
        reg_data = random.randint(0,0xFFFFFFFF)
        dut.register_read.value = reg_data
        await Timer(1, "ns")
        if dut.offset == 0b00:
            assert dut.byte_enable.value == 0b0001
            assert dut.data.value == (reg_data & 0x000000FF)
        elif dut.offset == 0b01:
            assert dut.byte_enable.value == 0b0010
            assert dut.data.value == (reg_data & 0x000000FF) << 8
        elif dut.offset == 0b10:
            assert dut.byte_enable.value == 0b0100
            assert dut.data.value == (reg_data & 0x000000FF) << 16
        elif dut.offset == 0b11:
            assert dut.byte_enable.value == 0b1000
            assert dut.data.value == (reg_data & 0x000000FF) << 24

    # Store Halfword
    await Timer(10, unit="ns")

    dut.f3.value = 0b001

    for _ in range(100):
        reg_data = random.randint(0,0xFFFFFFFF)
        dut.register_read.value = reg_data
        for offset in range(4):
            dut.alu_result_address.value = word | offset
            await Timer(1, unit="ns")
            if offset == 0b00:
                assert dut.byte_enable == 0b0011
                assert dut.data.value == (reg_data & 0x0000FFFF)
            elif offset == 0b10:
                assert dut.byte_enable == 0b1100
                assert dut.data.vlue == (reg_data & 0x0000FFFF) << 16
            else:
                assert dut.byte_enable == 0b0000
