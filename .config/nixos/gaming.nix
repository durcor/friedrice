{
pkgs,
...
}:

{
  # gaming
  hardware.steam-hardware.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
  programs.steam.enable = true;
  programs.steam.extraPackages = with pkgs; [
    gamescope
    gamemode
    mangohud
  ];
  programs.gamescope.enable = true;

  # Pretty colors
  services.hardware.openrgb.enable = true; # TODO: -git?
  hardware.openrazer.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.kernelModules = [
    "ntsync"
  ];

  environment.systemPackages = with pkgs; [
    mangohud   # -git
    # lutris   # -git
    # itch-setup-bin
    # steamcmd
    # proton-ge-bin

    # chaotic.packages.${pkgs.stdenv.hostPlatform.system}.mesa_git
    # mesa-tkg       # -git
    # lib32-mesa-tkg # -git
    # mesa-demos

    python313Packages.openrazer-daemon

    # gamemode
    # lib32-gamemode
    # gamescope
    # reshade-shaders # -git
    # vkbasalt
    # lib32-vkbasalt

    # dualsensectl # -git
    # dxvk-mingw   # -git

    # game dev:

    # godot
    # love # lua game engine?

    # games:

    tty-solitaire # TODO: -git?
    # vitetris
    moon-buggy

    supertuxkart
    # neverball
    # inputs.my-nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xonotic
    xonotic
    openarena
  ];
}
