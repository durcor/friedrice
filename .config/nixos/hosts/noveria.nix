{
self,
config,
lib,
pkgs,
# modulesPath,
hyprlandPkgs,
gpuUsageWaybarPkgs,
yaziPkgs,
firefoxNightlyPkgs,
nvimPkgs,
# chaotic,
# system,
...
}:

{
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  networking.hostName = "noveria";

  swapDevices = [ ];

  # Main user account. Password must be set with ‘passwd’.
  users.users.ty = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      # audio
      # render
      "libvirtd"
      # human # is this better than 'users' as a group name?
      # i2c
      # boinc
      # plugdev
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };
  hardware.openrazer.users = ["ty"];

  environment.systemPackages = with pkgs; [
    liquidctl # TODO: -git?
    # linux-firmware-intel
  ];

  # services.mpd = {
  #   enable = true;
  #   user = "ty";
  #   musicDirectory = "/home/ty/data/mus";
  #   playlistDirectory = "/home/ty/doc/playlists";
  #   extraConfig = ''
  #     audio_output {
  #       type "pipewire"
  #       name "PipeWire Output"
  #     }
  #     audio_output {
  #       type "fifo"
  #       name "ncmpcpp_fifo"
  #       path "/tmp/mpd.fifo"
  #       format "44100:16:2"
  #     }
  #   '';
  #   network.listenAddress = "any";
  # };
  # systemd.services.mpd.environment = {
  #   XDG_RUNTIME_DIR = "/run/user/1000";
  # };


  # Drive Configuration
  #
  # If the options attribute is not set, it'll default to "defaults"
  # boot options for fstab. Search up fstab mount options you can use
  # "users": Allows any user to mount and unmount
  # "nofail": Prevent system from failing if this drive doesn't mount

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      systemd.enable = true;
      availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" ];
      kernelModules = [ "dm-snapshot" ];
      luks.devices."nix".device = "/dev/disk/by-uuid/cf94998a-6cae-45da-8ebd-b42ad8cdad64";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernel.sysctl."kernel.sysrq" = 1;
  };

  fileSystems = {
    "/" = {
      device = "/dev/mapper/nix";
      fsType = "ext4";
    };

    # 3TB Seagate Barracuda
    "/mnt/data" = {
      device = "/dev/disk/by-uuid/1cc1e9b2-6994-4ec0-a4e2-93583f1e483f";
      fsType = "ext4";
      options = [
        "rw"
        "relatime"
        # dump=0 pass=2
      ];
    };

    # 1TB Western Digital - Pretty old
    "/mnt/old" = {
      device = "/dev/disk/by-uuid/80e51b2c-98b3-41f9-b4c9-51b6fc27122d";
      fsType = "ext4";
      options = [
        "rw"
        "relatime"
        # dump=0 pass=2
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5E37-A80D";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

    # FIXME: these are LUKS partitions:
    # Samsung 970 Evo Plus: root (lvm) -> /dev/mapper/vga-root
    # fileSystems."/mnt/arch" = {
    #   device = "/dev/disk/by-uuid/d14958e8-e0e0-4896-9098-18f0b7ada01d";
    #   fsType = "ext4";
    #   options = [
    #     "rw"
    #     "relatime"
    #     # "dump=0" "pass=1"
    #   ];
    # };

    # Samsung 970 Evo Plus: home (lvm) -> /dev/mapper/vga-home
    # fileSystems."/mnt/arch/home" = {
    #   device = "/dev/disk/by-uuid/45b78262-d5e8-4613-b502-8c93e1db8356";
    #   fsType = "ext4";
    #   options = [
    #     "rw"
    #     "relatime"
    #     # "dump=0" "pass=2"
    #   ];
    # };

    # Samsung 970 Evo Plus: boot
    # fileSystems."/mnt/arch/boot" = {
    #   device = "/dev/disk/by-uuid/C8E3-CBEE";
    #   fsType = "vfat";
    #   options = [
    #     "rw"
    #     "relatime"
    #     "fmask=0022"
    #     "dmask=0022"
    #     "codepage=437"
    #     "iocharset=iso8859-1"
    #     "shortname=mixed"
    #     "utf8"
    #     "errors=remount-ro"
    #     # dump=0 pass=2
    #   ];
    # };
  };

  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

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
      yazi = builtins.fromTOML (builtins.readFile "${self}/etc/yazi/yazi.toml");
      theme = builtins.fromTOML (builtins.readFile "${self}/etc/yazi/theme.toml");
      keymap = builtins.fromTOML (builtins.readFile "${self}/etc/yazi/keymap.toml");
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

  system.stateVersion = "26.05";
}
