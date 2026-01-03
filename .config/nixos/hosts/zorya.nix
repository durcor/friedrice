{ self, nixpkgs, ... }
{
  nixpkgs.hostPlatform = "x86_64-linux";

  environment.systemPackages = with pkgs; [
    inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi
    inputs.system-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.nh
    inputs.television.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.nixGL.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
