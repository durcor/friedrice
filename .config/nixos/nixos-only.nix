{
self,
lib,
config,
pkgs,
firefoxNightlyPkgs,
gpuUsageWaybarPkgs,
hyprlandPkgs,
nvimPkgs,
yaziPkgs,
...
}:

{
  environment.homeBinInPath = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "03:45" ];
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  services.fwupd.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  services.kmscon.enable = false;
  console = {
    font = "Lat2-Terminus12";
    useXkbConfig = true;
    earlySetup = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf
  ];

  services.xserver = {
    enable = false;
    xkb.options = "caps:swapescape";
  };

  services.interception-tools = {
    enable = true;
    plugins = with pkgs.interception-tools-plugins; [
      caps2esc
      dual-function-keys
    ];
    udevmonConfig =
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
      in
      lib.strings.toJSON [
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
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };

  services.homed.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.transmission.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  programs.nh.enable = true;
  programs.nix-ld.enable = true;

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = hyprlandPkgs.default;
    portalPackage = hyprlandPkgs.xdg-desktop-portal-hyprland;
  };
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;
  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    config.hyprland.preferred = [ "hyprland" "gtk" ];
  };

  systemd.user.services.waybar = {
    enable = true;
    path = with pkgs; [
      bash
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
    ];

    serviceConfig.Environment = [
      "PATH=%h/bin:${lib.makeBinPath config.systemd.user.services.waybar.path}"
    ];
  };

  programs.yazi = {
    enable = true;
    package = yaziPkgs.yazi;

    initLua = "${self}/etc/yazi/init.lua";
    settings = {
      yazi = fromTOML (builtins.readFile "${self}/etc/yazi/yazi.toml");
      theme = fromTOML (builtins.readFile "${self}/etc/yazi/theme.toml");
      keymap = fromTOML (builtins.readFile "${self}/etc/yazi/keymap.toml");
    };

    plugins = {
      inherit (pkgs.yaziPlugins) piper ouch git;
      "fs-usage.yazi" = "${self}/etc/yazi/plugins/fs-usage.yazi";
    };
  };

  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.ccache.enable = true;
  programs.ccache.cacheDir = "/nix/var/cache/ccache";
  systemd.tmpfiles.rules = [
    "d /nix/var/cache/ccache 0770 root nixbld - -"
  ];
  programs.ccache.packageNames = [
    "hyprland"
    "xdg-desktop-portal-hyprland"
    "mesa"
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;

  services.libinput.enable = true;

  programs.firefox = {
    enable = true;
    package = firefoxNightlyPkgs.firefox-nightly-bin;
    nativeMessagingHosts.packages = with pkgs; [
      pywalfox-native
      browserpass
      ff2mpv
    ];
    policies.Preferences = {
      "sidebar.revamp" = true;
      "sidebar.verticalTabs" = true;
      "browser.compactmode.show" = true;
      "image.jxl.enabled" = true;
    };
  };

  programs.neovim = {
    package = nvimPkgs.default;
    enable = true;
    vimAlias = true;
    viAlias = true;
    defaultEditor = true;
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  chaotic.mesa-git.enable = false;

  hardware.graphics.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings.General.Experimental = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  services.playerctld.enable = true;

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
