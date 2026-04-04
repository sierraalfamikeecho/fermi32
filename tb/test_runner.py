import os
from pathlib import Path

import cocotb
from cocotb_tools.runner import get_runner


def test_runner(design_name):
    sim = os.getenv("SIM", "verilator")
    project_path = Path(__name__).resolve().parent
    source_code = list(project_path.glob("src/*.sv"))
    runner = get_runner(sim)
    print(f"--trace {project_path}/packages/fermi32.sv")
    runner.build(
        sources=source_code,
        hdl_toplevel=f"{design_name}",
        build_dir=f"./{design_name}/sim_build",
        build_args=[
            f"--trace",
            "--trace-structs",
            "--trace",
            f"{project_path}/packages/fermi32_pkg.sv",
        ],
    )
    runner.test(
        hdl_toplevel=f"{design_name}",
        test_module=f"test_{design_name}",
        test_dir=f"./{design_name}",
    )


def test_alu():
    test_runner("alu")


def test_control():
    test_runner("control")


def test_cpu():
    test_runner("cpu")


def test_memory():
    test_runner("memory")


def test_regfile():
    test_runner("regfile")


def test_signext():
    test_runner("signext")


def test_load_store():
    test_runner("load_store_decoder")


def test_reader():
    test_runner("reader")


if __name__ == "__main__":
    test_alu()
    test_control()
    test_cpu()
    test_memory()
    test_regfile()
    test_signext()
    test_load_store()
    test_reader()
