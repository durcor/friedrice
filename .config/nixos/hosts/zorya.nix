{
# self,
pkgs,
lib,
config,
yaziPkgs,
hyprlandPkgs,
firefoxNightlyPkgs,
gpuUsageWaybarPkgs,
systemManagerPkgs,
# inputs,
...
}:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # nixpkgs.config.allowUnfree = true;
  system-manager.allowAnyDistro = true;
  system-graphics = {
    enable = true;
    enable32Bit = true;
  };

  # system-manager already exposes profile terminfo via TERMINFO_DIRS, so we
  # only need to link it into the managed profile.
  environment.pathsToLink = [
    "/share/terminfo"
  ];

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

  environment.etc."interception/udevmon.yaml".text =
    let
      dualFunctionKeysConfig = {
        TIMING = {
          TAP_MILLISEC = 200;
          DOUBLE_TAP_MILLISEC = 0;
        };

        MAPPINGS = [
          {
            KEY = "KEY_LEFTALT";
            TAP = "KEY_F12";
            HOLD = "KEY_LEFTALT";
          }
          {
            KEY = "KEY_ESC";
            TAP = "KEY_CAPSLOCK";
            HOLD = "KEY_LEFTSHIFT";
          }
        ];
      };
      dualFunctionKeysConfigFile = (pkgs.formats.yaml {}).generate "dual-function-keys.yaml" dualFunctionKeysConfig;
      udevmonConfig =
        [
          {
            JOB = builtins.concatStringsSep " | " [
              "${pkgs.interception-tools}/bin/intercept -g $DEVNODE"
              "${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c ${dualFunctionKeysConfigFile}"
              "${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
            ];
            DEVICE.EVENTS.EV_KEY = [ "KEY_F12" ];
          }
          {
            JOB = builtins.concatStringsSep " | " [
              "${pkgs.interception-tools}/bin/intercept -g $DEVNODE"
              "${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc"
              "${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
            ];
            DEVICE.EVENTS.EV_KEY = [ "KEY_CAPSLOCK" "KEY_ESC" ];
          }
        ];
    in
    builtins.readFile ((pkgs.formats.yaml {}).generate "udevmon.yaml" udevmonConfig);

  systemd.services.interception-tools = {
    enable = true;
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Nice = -20;
    };
    path = with pkgs; [
      bash
      interception-tools
      interception-tools-plugins.dual-function-keys
      interception-tools-plugins.caps2esc
    ];
    script = "${pkgs.interception-tools}/bin/udevmon -c /etc/interception/udevmon.yaml";
  };

  environment.etc."pam.d/hyprlock".text = ''
    #%PAM-1.0

    auth       sufficient   /lib/x86_64-linux-gnu/security/pam_himmelblau.so ignore_unknown_user
    auth       [success=2 default=ignore] /lib/x86_64-linux-gnu/security/pam_unix.so nullok
    auth       [success=1 default=ignore] /lib/x86_64-linux-gnu/security/pam_sss.so use_first_pass
    auth       requisite    /lib/x86_64-linux-gnu/security/pam_deny.so
    auth       required     /lib/x86_64-linux-gnu/security/pam_permit.so

    account    sufficient   /lib/x86_64-linux-gnu/security/pam_himmelblau.so ignore_unknown_user
    account    [success=1 new_authtok_reqd=done default=ignore] /lib/x86_64-linux-gnu/security/pam_unix.so
    account    requisite    /lib/x86_64-linux-gnu/security/pam_deny.so
    account    required     /lib/x86_64-linux-gnu/security/pam_permit.so
    account    sufficient   /lib/x86_64-linux-gnu/security/pam_localuser.so
    account    [default=bad success=ok user_unknown=ignore] /lib/x86_64-linux-gnu/security/pam_sss.so

    session    required     /lib/x86_64-linux-gnu/security/pam_permit.so
  '';

  systemd.user.services.waybar = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    requisite = [ "graphical-session.target" ];

    path = with pkgs; [
      bash
      waybar
      fuzzel
      gawk
      bluez
      hyprlandPkgs.default
      gpuUsageWaybarPkgs.default
      wttrbar
      mullvad
      kitty
      playerctl
      wireplumber
      libnotify
      jq
      fastfetch
      procps
    ];

    serviceConfig = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      ExecReload = "${pkgs.procps}/bin/pkill -SIGUSR2 $MAINPID";
      Restart = "on-failure";
      Environment = [
        "PATH=%h/bin:${lib.makeBinPath config.systemd.user.services.waybar.path}"
      ];
    };
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

  environment.systemPackages = with pkgs; [
    rofi

    awscli2
    azure-cli
    argocd
    k9s
    kubectl

    util-linux # NOTE: will this mess with our host?

    yaziPkgs.yazi

    # nixGLPkgs.default
    systemManagerPkgs.default

    docker-credential-helpers

    waybar

    firefoxNightlyPkgs.firefox-nightly-bin

    interception-tools
    interception-tools-plugins.caps2esc
    interception-tools-plugins.dual-function-keys

    # xdg-desktop-portal
    # xdg-desktop-portal-gtk
    hyprlandPkgs.xdg-desktop-portal-hyprland

    nix-output-monitor

    # gnome-keyring
    # libsecret
    # lxqt.lxqt-policykit

    # networkmanagerapplet
    # libayatana-appindicator
  ];
}
