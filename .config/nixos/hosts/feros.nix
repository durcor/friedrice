{
# self,
pkgs,
# lib,
# config,
yaziPkgs,
# hyprlandPkgs,
# firefoxNightlyPkgs,
# gpuUsageWaybarPkgs,
# inputs,
...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  # nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  # nixpkgs.config.allowUnfree = true;

  # NOTE: this is taken from hacks for system-manager. does MacOS need them too?
  environment.pathsToLink = [
    "/share/terminfo"
  ];

  system.primaryUser = "tyler.kaminski";

  # zsh resolves $TERM before nix-darwin's generated set-environment has made
  # TERMINFO_DIRS useful for SSH sessions. Put Kitty's terminfo in zsh's
  # default per-user lookup path so `TERM=xterm-kitty ssh feros` is quiet.
  system.activationScripts.postActivation.text = ''
    install -d -m 0755 -o tyler.kaminski -g staff /Users/tyler.kaminski/.terminfo/78
    ln -sfn ${pkgs.kitty.terminfo}/share/terminfo/78/xterm-kitty /Users/tyler.kaminski/.terminfo/78/xterm-kitty
    chown -h tyler.kaminski:staff /Users/tyler.kaminski/.terminfo/78/xterm-kitty
  '';

  # users.users.tyler = {
  #   isNormalUser = true;
  #   extraGroups = [
  #     "wheel"
  #     # "tyler"
  #     "adm"
  #     "cdrom"
  #     "sudo"
  #     "dip"
  #     "plugdev"
  #     "lpadmin"
  #     "lxd"
  #     "sambashare"
  #     "docker"
  #
  #     # "video"
  #     # "audio"
  #     # "render"
  #     # "libvirtd"
  #   ];
  #   uid = 1000;
  #   # Shell is managed by the host distro on zorya.
  # };

  nix.linux-builder = {
    enable = true;
  };

  # programs.firefox = {
  #   enable = true;
  #   package = firefoxNightlyPkgs.firefox-nightly-bin;
  #   # package = pkgs.latest.firefox-nightly-bin;
  #   # package = inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.firefox_nightly;
  #   # package = pkgs.firefox;
  #   # package = latest.firefox-nightly-bin;
  #   # package = pkgs.librewolf;
  #   # package = pkgs.firedragon;
  #   nativeMessagingHosts.packages = with pkgs; [
  #     pywalfox-native
  #     browserpass
  #     ff2mpv
  #   ];
  #   policies.Preferences = {
  #     "sidebar.revamp" = true;
  #     "sidebar.verticalTabs" = true;
  #     "browser.compactmode.show" = true;
  #     "image.jxl.enabled" = true;
  #   };
  # };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  system.defaults.NSGlobalDomain = {
    InitialKeyRepeat = 15; # 15 == 225 ms (lower is faster)
    KeyRepeat = 2;         # 2 == 30 ms (lower is faster)
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.stateVersion = 7;

  # networking.hostFiles =

  launchd.user.agents.mpd = {
    command = "${pkgs.mpd}/bin/mpd";
    path = with pkgs; [
      mpd
    ];
  };

  environment.systemPackages = with pkgs; [
    awscli2
    azure-cli
    argocd
    k9s
    kubectl

    util-linux # NOTE: will this mess with our host?

    yaziPkgs.yazi

    # nixGLPkgs.default

    docker-credential-helpers

    firefox-bin

    nix-output-monitor

    ghostty-bin

    libreoffice-bin

    gimp2

    # libsecret
  ];
}
