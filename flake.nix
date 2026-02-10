{
  description = "A dev environment for RISC-V CPU development";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      devShells."x86_64-linux".default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        pkgs.mkShell {
          packages = with pkgs; [
            verilator
            tcl
            gnumake
            python313Packages.cocotb
          ];
        };
    };
}
