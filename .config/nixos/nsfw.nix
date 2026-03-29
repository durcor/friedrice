{
  pkgs,
  ...
}
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

    tor-browser
  ];
}
