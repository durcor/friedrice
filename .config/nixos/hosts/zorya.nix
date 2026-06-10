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
pamShimPkgs,
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

  # Use Ubuntu's native PAM from Nix-built hyprlock.  Nix's linux-pam does not
  # understand all Debian/Ubuntu PAM behavior and may look for helpers/modules
  # in NixOS-specific locations, which breaks screen-unlock authentication on
  # this system-manager host.
  _module.args.hyprlockPkg = pkgs.replaceDependencies {
    drv = pkgs.hyprlock;
    replacements = [
      {
        oldDependency = pkgs.linux-pam;
        newDependency = pamShimPkgs.default;
      }
    ];
  };

  # system-manager only links /bin by default.  NixOS exposes a much richer
  # /run/current-system/sw tree via environment.pathsToLink.  Link the safe,
  # user-session-facing parts here so desktop launchers, MIME/icon lookup,
  # shell completions, man/info, portals, and Wayland session metadata can see
  # system-manager-installed packages.
  environment.pathsToLink = [
    # Executables.  /bin is added by system-manager by default.  /sbin is
    # harmless unless users add it to PATH, and matches normal NixOS profiles.
    "/sbin"

    # Shell completions.  These may still require per-shell setup (e.g. zsh
    # fpath), but linking them makes the files available under the profile.
    "/etc/bash_completion.d"
    "/share/bash-completion"
    "/share/fish/vendor_completions.d"
    "/share/fish/vendor_conf.d"
    "/share/fish/vendor_functions.d"
    "/share/zsh"

    # Documentation / terminal metadata.
    "/share/info"
    "/share/man"
    "/share/terminfo"

    # Freedesktop/XDG desktop data.  Fuzzel and icon/mime lookup need these via
    # XDG_DATA_DIRS=/run/system-manager/sw/share:...
    "/share/appdata"
    "/share/applications"
    "/share/desktop-directories"
    "/share/icons"
    "/share/metainfo"
    "/share/mime"
    "/share/pixmaps"
    "/share/sounds"
    "/share/themes"
    "/share/thumbnailers"

    # Desktop/session integration data.  These are data-only from the host's
    # perspective, but allow Nix-provided Wayland sessions, portals, and D-Bus
    # activation metadata to be discovered by user-session tools.
    "/etc/xdg"
    "/etc/xdg/menus"
    "/etc/xdg/menus/applications-merged"
    "/share/dbus-1"
    "/share/hypr"
    "/share/uwsm"
    "/share/wayland-sessions"
    "/share/X11"
    "/share/xdg-desktop-portal"

    # Runtime/graphics data used by loaders and toolkits.  Avoid linking /lib
    # wholesale on a non-NixOS host; these share subtrees are safer.
    "/share/vulkan"
  ];

  # Pull split man/info outputs into the profile when packages provide them.
  # Avoid "doc" by default: it is safe, but can substantially increase closure
  # size.  Add "doc" here later if you want /share/doc, /share/gtk-doc, etc.
  environment.extraOutputsToInstall = [
    "man"
    "info"
  ];

  # Possibly useful but intentionally *not* linked yet until host<->system-manager
  # interop is more deliberate:
  #   /lib, /libexec, /lib/systemd, /lib/udev, /lib/tmpfiles.d
  #     Can affect plugin/service/module discovery and blur host vs Nix runtime
  #     boundaries.  Prefer explicit wrappers/env vars over wholesale linking.
  #   /etc, /etc/dbus-1, /etc/systemd, /etc/udev, /etc/pam.d, /etc/tmpfiles.d
  #     Host daemons may need activation/reload semantics and policy review.
  #   /share/polkit-1
  #     Useful for GUI apps with privileged actions, but it is authorization
  #     policy metadata; enable deliberately once host polkit integration is clear.
  #   /share/doc, /share/gtk-doc, /share/devhelp
  #     Safe but potentially large; add with environment.extraOutputsToInstall =
  #     [ "doc" ] if you want full documentation outputs.

  # Make the linked desktop/config/info data visible to login-shell-started
  # sessions like this host's ~/.profile -> Hyprland flow, while preserving host
  # distro data.  man-db usually infers /run/system-manager/sw/share/man from
  # /run/system-manager/sw/bin on PATH, so MANPATH is intentionally not set.
  environment.extraInit = ''
    if [ -z "''${XDG_DATA_DIRS:-}" ]; then
      export XDG_DATA_DIRS="/usr/local/share:/usr/share"
    fi
    case ":$XDG_DATA_DIRS:" in
      *:/run/system-manager/sw/share:*) ;;
      *) export XDG_DATA_DIRS="/run/system-manager/sw/share:$XDG_DATA_DIRS" ;;
    esac

    if [ -z "''${XDG_CONFIG_DIRS:-}" ]; then
      export XDG_CONFIG_DIRS="/etc/xdg"
    fi
    case ":$XDG_CONFIG_DIRS:" in
      *:/run/system-manager/sw/etc/xdg:*) ;;
      *) export XDG_CONFIG_DIRS="/run/system-manager/sw/etc/xdg:$XDG_CONFIG_DIRS" ;;
    esac

    if [ -z "''${INFOPATH:-}" ]; then
      export INFOPATH="/usr/local/share/info:/usr/share/info"
    fi
    case ":$INFOPATH:" in
      *:/run/system-manager/sw/share/info:*) ;;
      *) export INFOPATH="/run/system-manager/sw/share/info:$INFOPATH" ;;
    esac
  '';

  # fonts.packages = with pkgs; [
  #   nerd-fonts.terminess-ttf
  # ];

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

  # nixpkgs.overlays = [
  #   (
  #     final: prev:
  #     let
  #       patchedPam = prev.linux-pam.overrideAttrs (old: {
  #         postPatch = ''
  #           substituteInPlace modules/module-meson.build \
  #             --replace-fail "sbindir / 'unix_chkpwd'" "'/usr/bin/unix_chkpwd'"
  #         '';
  #       });
  #     in
  #     {
  #       hyprlock = prev.hyprlock.override { pam = patchedPam };
  #     }
  #   )
  # ];

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

    @include common-auth
    @include common-account
    @include common-session
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

    home-manager

    # formatters
    treefmt
    nixpkgs-fmt
    alejandra
    ruff

    # AI
    openspec

    # cloud
    awscli2
    ssm-session-manager-plugin
    azure-cli
    argocd
    k9s
    kubectl
    terraform

    util-linux # NOTE: will this mess with our host?

    yaziPkgs.yazi

    # nixGLPkgs.default
    systemManagerPkgs.default
    nix-output-monitor
    nix-fast-build

    docker-credential-helpers

    waybar

    # python package management
    twine
    poetry

    firefoxNightlyPkgs.firefox-nightly-bin

    interception-tools
    interception-tools-plugins.caps2esc
    interception-tools-plugins.dual-function-keys

    # xdg-desktop-portal
    # xdg-desktop-portal-gtk
    hyprlandPkgs.xdg-desktop-portal-hyprland
    hyprlandPkgs.hyprland # config.lib.pamShim.replacePam

    # gnome-keyring
    # libsecret
    # lxqt.lxqt-policykit

    # networkmanagerapplet
    # libayatana-appindicator
  ];
}
