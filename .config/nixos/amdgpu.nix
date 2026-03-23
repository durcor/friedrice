{
pkgs,
stablePkgs,
...
}:

{
  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with stablePkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+ /opt/rocm     - - - - ${rocmEnv}"
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      mesa = (prev.mesa.override {
        galliumDrivers = [
          "radeonsi"
          "zink"
        ];
        vulkanDrivers = ["amd"];
      }).overrideAttrs (old: { # HACK: create empty output to satisfy the package
        postInstall = (old.postInstall or "") + ''
          mkdir -p "$spirv2dxil"
        '';
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    rocmPackages.rocm-smi
    nvtopPackages.amd
    btop-rocm
    # xf86-video-amdgpu
    # linux-firmware-amdgpu
  ];
}
