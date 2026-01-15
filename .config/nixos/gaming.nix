{
pkgs
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

  environment.systemPackages = with pkgs; [
    mangohud   # -git
    # lutris   # -git
    # itch-setup-bin
    # steamcmd
    #
    # chaotic.packages.${pkgs.stdenv.hostPlatform.system}.mesa_git
    # mesa-tkg       # -git
    # lib32-mesa-tkg # -git
    # mesa-demos
    #
    # gamemode
    # lib32-gamemode
    # gamescope
    # reshade-shaders # -git
    # vkbasalt
    # lib32-vkbasalt
    #
    # dualsensectl # -git
    # dxvk-mingw   # -git
    #
    # game dev:
    #
    # godot
    # love # lua game engine?
    #
    # games:
    #
    # tty-solitaire # TODO: -git?
    # vitetris
    # moon-buggy
    #
    superTuxKart
    # neverball
    # inputs.my-nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xonotic
    xonotic
  ];
}
