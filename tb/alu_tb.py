import cocotb
from cocotb.triggers import Timer
import random

def binary_hex(bin_str):
    hex_str = hex(int(str(bin_str), 2))[2:]
    hex_str = hex_str.zfill(8)
    return hex_str.upper()

@cocotb.test()
async def add_test(dut):
    await Timer(1, units="ns")
    dut.alu_control.value = 0b0000
    for _  in range(1000):
        a = random.randint(0,0xFFFFFFFF)
        b = random.randint(0,0xFFFFFFFF)
        expected = (a + b) & 0xFFFFFFFF
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, units="ns")
        assert int(dut.alu_result.value) == expected

@cocotb.test()
async def sub_test(dut):
    await Timer(1, units="ns")
    for _ in range(1000):
        a = random.randint(0,0xFFFFFFFF)
        b = random.randint(0,0xFFFFFFFF)
        expected = (a - b) & 0xFFFFFFFF
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, units="ns")
        assert int(dut.alu_result.value) == expected

@cocotb.test()
async def and_test(dut):
    await Timer(1, units="ns")
    for _ in range(1000):
        a = random.randint(0,0xFFFFFFFF)
        b = random.randint(0,0xFFFFFFFF)
        expected = (a & b) & 0xFFFFFFFFF
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, units="ns")
        assert int(dut.alu_result.value) == expected

@cocotb.test()
async def or_test(dut):
    await Timer(1, units="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFF)
        expected = (a | b) & 0xFFFFFFFF
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, units="ns")
        assert int(dut.alu_result.value) == expected

@cocotb.test()
async def xor_test(dut):
    await Timer(1, units="ns")
    for _ in range(1000):
        a = random.randint(0, 0xFFFFFFFFF)
        b = random.randint(0, 0xFFFFFFFFF)
        expected =  (a ^ b) & 0xFFFFFFFF
        dut.src1.value = a
        dut.src2.value = b
        await Timer(1, units="ns")
        assert int(dut.alu_result.value) == expected
