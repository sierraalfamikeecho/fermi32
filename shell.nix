{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    python313Packages.cocotb
    python313Packages.pytest
    verilator
    tcl
    gnumake
  ];
}
