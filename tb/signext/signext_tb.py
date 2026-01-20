import cocotb
import random

from cocotb.triggers import RisingEdge, Timer
#Test bench for sign extension module at src/signext.sv

@cocotb.test()
