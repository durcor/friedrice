{
pkgs,
...
}:

{
  environment.systemPackages = with pkgs; [
    # amd-ucode
    # zenpower3-dkms
    # ryzen_smu-dkms # -git
  ];
}
