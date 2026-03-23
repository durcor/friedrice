{
pkgs,
lib,
config,
...
}:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.kernelModules = [ "kvm-amd" ];
  boot.blacklistedKernelModules = [ "k10temp" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ zenpower ];

  # NOTE: "native" here means zen2 (ryzen 3000)
  nixpkgs.overlays = let
    native = pkgs: pkg: pkg.override {
      stdenv = pkgs.withCFlags [ "-march=znver2" ] pkgs.stdenv;
    };
    in [
      (_: prev: {
        # superTuxKart = native prev prev.superTuxKart;
        mesa = native prev prev.mesa;
      })
    ];

  # environment.systemPackages = with pkgs; [
  #   # amd-ucode
  #   # zenpower3-dkms
  #   # ryzen_smu-dkms # -git
  # ];
}
