{
pkgs,
unstablePkgs,
...
}:
{
  environment.systemPackages = with pkgs; [
    # torrents:
    #
    # stig-git
    transmission_4
    # transmission-cli
    # transmission-gtk
    # inputs.transg-tui.packages.${pkgs.stdenv.hostPlatform.system}.default

    # crypto wallets
    #
    feather

    # tor
    # torsocks
    tor-browser

    inkscape
    unstablePkgs.krita

    # messaging:
    #
    unstablePkgs.equibop
    vesktop
    teams-for-linux
    # discord
    #
    unstablePkgs.signal-desktop
    unstablePkgs.telegram-desktop
    #
    # matrix:
    # cinny-desktop
    iamb
  ];
}
