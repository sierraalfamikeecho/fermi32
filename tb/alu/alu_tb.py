import random

import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_alu(dut):
    await sum_test(dut)
    await sub_test(dut)
    await and_test(dut)
    await or_test(dut)
    await xor_test(dut)


def binary_hex(bin_str):
    hex_str = hex(int(str(bin_str), 2))[2:]
    hex_str = hex_str.zfill(8)
    return hex_str.upper()


async def sum_test(dut):
    await Timer(1, unit="ns")
    dut.alu_control.value = 0b0000
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        expected = (a + b) & 0xFFFFFFFF
        dut.opcode = 0b000
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, unit="ns")
        assert int(dut.alu_result.value) == expected


async def sub_test(dut):
    await Timer(1, unit="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        expected = (a - b) & 0xFFFFFFFF
        dut.opcode = 0b001
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, unit="ns")
        assert int(dut.alu_result.value) == expected


async def and_test(dut):
    await Timer(1, unit="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        expected = (a & b) & 0xFFFFFFFFF
        dut.opcode = 0b010
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, unit="ns")
        assert int(dut.alu_result.value) == expected


async def or_test(dut):
    await Timer(1, unit="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        expected = (a | b) & 0xFFFFFFFF
        dut.opcode = 0b011
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, unit="ns")
        assert int(dut.alu_result.value) == expected


async def xor_test(dut):
    await Timer(1, unit="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFFF)
        expected = (a ^ b) & 0xFFFFFFFF
        dut.opcode = 0b100
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, unit="ns")
        assert int(dut.alu_result.value) == expected
