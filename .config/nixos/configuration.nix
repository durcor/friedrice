# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, chaotic, ... }:

{
  # NOTE: scan hardware w/ nixos-generate-config
  # imports = [
  #   ./hosts/noveria.nix
  #   # ./secrets.nix # FIXME: sops-nix or agenix are the way
  # ];

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

    initrd.systemd.enable = true;

    # pkgs.linuxPackages_zen
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
      "https://chaotic-nyx.cachix.org"
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
    ];
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://chaotic-nyx.cachix.org"
      "https://ghostty.cachix.org"
      "https://nix-community.cachix.org"
      "https://chaotic-nyx.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "chaotic-nyx.cachix.org-1:Z1OsgFx+V3eyGEIYirsc7blQLuui3CFbfvdqZQhSLaw="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
    ];
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = ["03:45"];
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };
  nixpkgs.config.allowUnfree = true;

  networking = {
    # useNetworkd = true;

    # Configure network connections interactively with nmcli or nmtui.
    networkmanager.enable = true;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  security.sudo.wheelNeedsPassword = false;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  services.kmscon.enable = false;
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
    earlySetup = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf

    # otf-aurulent-nerd
    # otf-codenewroman-nerd
    # otf-comicshanns-nerd
    # otf-commit-mono-nerd
    # otf-droid-nerd
    # otf-firamono-nerd
    # otf-geist-mono-nerd
    # otf-hasklig-nerd
    # otf-hermit-nerd
    # otf-monaspace-nerd
    # otf-opendyslexic-nerd
    # otf-overpass-nerd
    # otf-unifont

    # ttf-0xproto-nerd
    # ttf-3270-nerd
    # ttf-agave-nerd
    # ttf-anonymouspro-nerd
    # ttf-arimo-nerd
    # ttf-bigblueterminal-nerd
    # ttf-bitstream-vera-mono-nerd
    # ttf-cascadia-code-nerd
    # ttf-cascadia-mono-nerd
    # ttf-cousine-nerd
    # ttf-d2coding-nerd
    # ttf-daddytime-mono-nerd
    # ttf-dejavu-nerd
    # ttf-envycoder-nerd
    # ttf-fantasque-nerd
    # ttf-firacode-nerd
    # ttf-go-nerd
    # ttf-greybeard-bin
    # ttf-hack-nerd
    # ttf-heavydata-nerd
    # ttf-iawriter-nerd
    # ttf-ibmplex-mono-nerd
    # ttf-inconsolata-go-nerd
    # ttf-inconsolata-lgc-nerd
    # ttf-inconsolata-nerd
    # ttf-intone-nerd
    # ttf-iosevka-nerd
    # ttf-iosevkaterm-nerd
    # ttf-jetbrains-mono-nerd
    # ttf-lekton-nerd
    # ttf-liberation-mono-nerd
    # ttf-lilex-nerd
    # ttf-martian-mono-nerd
    # ttf-meslo-nerd
    # ttf-monofur-nerd
    # ttf-monoid-nerd
    # ttf-mononoki-nerd
    # ttf-mplus-nerd
    # ttf-nerd-fonts-symbols
    # ttf-nerd-fonts-symbols-mono
    # ttf-noto-nerd
    # ttf-profont-nerd
    # ttf-proggyclean-nerd
    # ttf-roboto-mono-nerd
    # ttf-sharetech-mono-nerd
    # ttf-sourcecodepro-nerd
    # ttf-space-mono-nerd
    # ttf-terminus-nerd
    # ttf-tinos-nerd
    # ttf-twemoji-color
    # ttf-ubuntu-mono-nerd
    # ttf-ubuntu-nerd
    # ttf-victor-mono-nerd
  ];

  services.xserver = {
    enable = false;

    # xkb.layout = "us";
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
              KEY  = "KEY_LEFTALT";
              TAP  = "KEY_F12";
              HOLD = "KEY_LEFTALT";
            }
            # {
            #   KEY  = "KEY_CAPSLOCK";
            #   TAP  = "KEY_ESC";
            #   HOLD = "KEY_LEFTMETA";
            # }
            {
              KEY  = "KEY_ESC";
              TAP  = "KEY_CAPSLOCK";
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

  # CUPS
  services.printing.enable = true;

  # sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Pretty colors
  services.hardware.openrgb.enable = true; # TODO: -git?
  hardware.openrazer.enable = true;
  hardware.openrazer.users = ["ty"];

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

  # nix utilities
  programs.nh.enable = true;
  # FIXME: isn't this a chicken-and-egg sort of problem?
  # programs.nh.flake = "${config.users.users.ty.home}/.config/nixos";
  programs.nix-ld.enable = true;

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.hyprlock.enable = true;
  programs.waybar.enable = true;

  programs.git.enable = true;
  programs.git.lfs.enable = true;

  # shells
  programs.zsh.enable = true;
  programs.fish.enable = true;
  # programs.dash.enable = true; TODO: set as legacy /bin/sh?

  # Touchpad support (enabled by default in most DEs)
  services.libinput.enable = true;

  # firefox nightly upstream overlay
  #
  # nixpkgs.overlays =
  #   let
  #     moz-rev = "master";
  #     moz-url = builtins.fetchTarball {
  #       url = "https://github.com/mozilla/nixpkgs-mozilla/archive/${moz-rev}.tar.gz";
  #       # sha256 = lib.fakeSha256;
  #       sha256 = "sha256:0xxhiads5fd4jwbr685k1m527za50sl5z4bliigz99ciqxvzyf0z";
  #     };
  #     nightlyOverlay = (import "${moz-url}/firefox-overlay.nix");
  #   in [
  #     (final: prev: {
  #       firefox-bin = { channel ? "release", ... } @ args: prev.firefox-bin;
  #     })
  #
  #     nightlyOverlay
  #   ];

  programs.firefox = {
    enable = true;
    package = inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
    nativeMessagingHosts.packages = with pkgs; [
      pywalfox-native
      # ff2mpv-native-messaging-host-git
    ];
    # package = pkgs.latest.firefox-nightly-bin;
    # package = inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.firefox_nightly;
    # package = pkgs.firefox;
    # package = latest.firefox-nightly-bin;
    # package = pkgs.librewolf;
    # package = pkgs.firedragon;
    policies = {
      Preferences = {
        "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
        "browser.compactmode.show" = true;
        "image.jxl.enabled" = true;
      };
    };
  };

  # programs.neovim = {
  #   enable = true;
  #   vimAlias = true;
  #   viAlias = true;
  #   defaultEditor = true;
  # };

  environment.variables.EDITOR = "nvim";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ty = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      # audio
      # render
      "libvirt"
      # human # is this better than 'users' as a group name?
      # i2c
      # boinc
      # plugdev
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  # mesa-git.enable = true;
  chaotic.mesa-git.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+ /opt/rocm     - - - - ${rocmEnv}"
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];

  # Packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # util
    eza
    ripgrep
    file
    bat
    rsync
    croc
    wget
    p7zip
    jq
    yq-go
    # silver-searcher
    fd
    killall
    pandoc
    tree
    broot
    just
    khal
    khard
    bc
    # which
    # buku

    # gaming:
    #
    mangohud   # -git
    # lutris   # -git
    # steamcmd
    #
    # inputs.chaotic.packages.${pkgs.stdenv.hostPlatform.system}.mesa_git
    # mesa-tkg       # -git
    # lib32-mesa-tkg # -git
    #
    # gamemode
    # lib32-gamemode
    # gamescope
    # reshade-shaders-git
    # vkbasalt
    # lib32-vkbasalt
    #
    # mesa-demos
    #
    # dualsensectl-git
    # dxvk-mingw-git
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
    # supertuxkart
    # neverball
    xonotic

    # ricing:
    #
    fastfetch
    wallust
    cmatrix
    cava
    catnip
    pipes
    pipes-rs
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    openrazer-daemon
    # themix-full   -git
    # lxappearance
    # wraith-master -bin
    # matugen       -bin
    # neo-matrix    -git
    # neofetch
    # capitaine-cursors
    #
    # razer things:
    #
    # razercommander   -git
    # python-openrazer -git
    # polychromatic
    #
    # spicetify-cli-git

    # dev tools:
    #
    # compilers:
    #
    gcc
    clang
    # go
    # gcc-fortran
    # ghc
    #
    # llvm:
    #
    # llvm-libs
    # lib32-llvm-libs
    # compiler-rt
    #
    # toolchains:
    #
    # binutils
    # bison
    # flex
    # lld
    #
    # nodejs
    # nuget # c#
    # r
    # ruby
    #
    # language servers:
    #
    bash-language-server
    # pyright
    #
    # containers:
    #
    # docker
    # docker-buildx
    # podman
    buildah
    #
    # debugging:
    #
    gdb
    # lldb
    #
    # build systems:
    #
    gnumake
    # autoconf
    # automake
    # pkgconf
    #
    # package managers:
    #
    # pixi
    # uv
    # yarn
    # npm
    # cpanminus
    #
    # repo # git wrapper for android dev
    ccache # cache (for c)

    # browsers:
    #
    brave
    tor-browser
    qutebrowser
    # lynx

    # browser utils
    browserpass
    pywalfox-native

    # gpu:
    #
    # xf86-video-amdgpu
    # rocmPackages
    # rocmPackages.rocm-smi
    nvtopPackages.amd
    # drm_monitor -git
    # libdrm      -git

    # terminals
    kitty
    ghostty
    alacritty
    # foot
    # wezterm -git

    # terminal utilities:
    #
    chafa
    # trash-cli
    # ueberzugpp
    # urlscan
    # vimv      -git
    # ttyqr     -git
    # tty-clock -git
    # libsixel

    vdirsyncer # contacts/calendar sync

    # file management
    yazi
    yaziPlugins.piper
    yaziPlugins.ouch
    yaziPlugins.git
    lf
    dragon-drop
    # transgender

    # media:
    #
    ffmpeg_7-full
    yt-dlp
    # mediainfo
    # atomicparsley
    # vdpauinfo
    # ffmpegthumbnailer
    #
    # music:
    mpc
    mpd
    mpdris2
    (pkgs.ncmpcpp.override { visualizerSupport = true; })
    # mpdscribble
    mpris-scrobbler
    spotify
    # spotifyd
    # ncspot
    # nicotine+
    #
    # video player:
    #
    mpv
    # mpv-mpris
    # mpv-quality-menu-git
    # mpv-thumbfast-git
    # mpv-visualizer-git
    #
    # vlc
    #
    # gstreamer
    # gst-plugins-base

    # pdf:
    #
    zathura
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    # evince
    #
    # pdfjs
    # pdftk

    # firmware:
    #
    # linux-firmware-amdgpu
    # linux-firmware-intel
    # linux-firmware-other
    # linux-firmware-whence
    #
    # amd-ucode
    # zenpower3-dkms
    # fwupd
    #
    # modprobed-db # hardware prober
    #
    # hardware testing:
    #
    # memtest86+

    # notifications:
    #
    mako
    # dunst

    # mail:
    #
    neomutt
    # thunderbird
    # mutt-wizard-git

    # text editors:
    #
    neovim
    neovim-remote
    # kakoune
    # helix
    libreoffice-fresh
    sc-im

    nixVersions.latest # nixVersions.git
    nix-index
    nixfmt-rfc-style

    # window managers:
    #
    sway
    # i3-wm
    hyprland
    #
    # window manager utilities:
    #
    # status bar:
    waybar
    wttrbar # -git
    inputs.gpu-usage-waybar.packages.${pkgs.stdenv.hostPlatform.system}.default
    # i3blocks
    # i3lock-color
    #
    hypridle
    # swayidle
    #
    hyprlock
    # swaylock-effects
    #
    hyprpaper
    hyprpicker
    #
    # wallpaper utilities:
    #
    # swww
    #
    # clipboard management:
    #
    wl-clipboard
    # xsel
    # xclip
    # clipman
    # clipmenu
    # clipnotify
    #
    wdisplays # TODO: -git?
    # arandr
    #
    wev
    # xorg-xev
    #
    # wlr-randr-git
    # xorg-xrandr
    #
    # wf-recorder-git
    # wlrobs-hg
    # obs-studio
    # obs-vaapi
    #
    # desktop portals:
    #
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-wlr
    #
    # xorg-xinit
    # xorg-xset
    # xdo

    # messaging:
    #
    vesktop
    teams-for-linux
    # discord

    # menus:
    #
    fuzzel # TODO: move to -git?
    fzf
    dmenu-wayland
    # dmenu
    # rofi

    # asciiquarium

    # 3d modeling:
    #
    # assimp
    # blender

    # bluetooth:
    #
    # blueman
    # bluez
    # bluez-libs
    # bluez-utils

    # security:
    #
    # ca-certificates-mozilla

    # libraries:
    #
    icu
    # capnproto
    # nlohmann-json

    # compute:
    #
    # clinfo

    # fortune cookies:
    #
    fortune
    cowsay
    # cowfortune
    # fortune-mod-off
    # sex

    libnotify # for notify-send

    # cpio
    # criu
    # csvtools-git
    # cups

    # dbus

    # ddcutil
    #
    # dialog

    # motherboard info:
    #
    # dmidecode

    # dos2unix
    # dosbox
    # dosfstools

    # disk usage:
    #
    # dua-cli
    dust

    # e3

    # easyeffects
    # easyeffects-git-debug

    # editline
    # efibootmgr
    # fakeroot
    # fcft

    # featherwallet-bin

    # festival

    # flatpak

    # file system:
    #
    # fuse-overlayfs
    # davfs2
    # ntfs-3g

    # gammastep
    # redshift

    # gegl
    # gengetopt
    # ghostscript

    # gifsicle

    gimp

    # git-credential-manager-bin
    # git-lfs
    # github-cli

    # system monitors:
    #
    # glances
    htop
    # btop
    lm_sensors
    bottom

    # gjs
    # glibmm-2.68
    # gmni-git

    # graphics:
    #
    # glfw
    # glslang

    # google-earth-pro

    # grabc

    # gtk-vnc

    # gtk:
    #
    # lib32-gtk3
    # gtk4

    # gtkmm-4.0
    # gurk
    # gutenprint

    # hashcat # password cracking:

    # hidapi
    # highlight
    # ht-editor
    # hunspell-en_us

    # i2c-tools
    # ifuse

    # imv

    # inotify-info-git
    # inotify-tools

    # iperf
    # itch-setup-bin

    # kooha

    inkscape
    krita

    # kdeconnect
    lan-mouse

    lazygit

    # legendary
    # lensfun

    # lib32-dbus
    # lib32-giflib

    # lib32-gst-plugins-base-libs

    # lib32-libdrm-git
    # lib32-libomxil-bellagio
    # lib32-libxslt

    # lib32-mpg123
    # lib32-nss
    # lib32-openal

    # audio:
    #
    # lib32-pipewire
    # wireplumber
    # lib32-libpulse
    # alsa-card-profiles
    # alsa-utils
    #
    # chromaprint-fftw
    # cli-visualizer-git
    #
    # libldac
    # libpulse
    #
    # noise-repellent

    # graphics engine:
    #
    # lib32-sdl2-compat

    # camera:
    #
    # lib32-v4l-utils
    # v4l2loopback-dkms
    # v4l2loopback-utils
    # cheese

    # libclc
    # libcurlpp

    # libirecovery-git

    # libnfc

    # cad:
    #
    # librecad

    # librist
    # libtool

    # video:
    # libva-utils

    # virtualization:
    #
    # libvirt

    # linuxwave

    # liquidctl-git
    # lksctp-tools

    # lolcat

    # lowdown

    # lshw

    # lsof
    # luarocks
    # luit

    # lvm2

    # screenshotting:
    #
    # maim
    slurp
    grim
    # grimblast-git

    # mame

    # microsoft -_-:
    #
    # mingw-w64-binutils
    # mingw-w64-crt
    # mingw-w64-gcc
    # mingw-w64-headers
    # mingw-w64-winpthreads
    #
    # mono
    # mono-msbuild

    # mpg123
    # mtools

    # rss reader:
    #
    # newsboat

    nvimpager

    # note taking:
    #
    # obsidian

    # openmp

    # opencv

    # opensc
    # opensmtpd

    # auth:
    #
    # pam-gnupg # TODO: -git?
    pinentry-curses

    pass # TODO: -git?
    # passff-host

    # patch

    # emulation:
    #
    # pcsx2 # TODO: -git?
    # qemu-system-x86
    # qemu-user-static
    # virt-manager
    # retroarch
    # libretro-flycast
    # libretro-ppsspp

    # peda

    # peek

    # pegtl

    # perf

    # perl-image-exiftool

    # audio server:
    #
    # pipewire
    # pipewire-alsa
    # pipewire-pulse
    # portaudio

    # social media:
    #
    # pleroma-bin

    # databases:
    #
    # postgresql

    # premake

    # music visualizer:
    #
    # projectm

    # audio controller:
    #
    pavucontrol
    # pulsemixer
    # ncpamixer

    # python-asciimatics
    # python-beautifulsoup4
    # python-defusedxml
    # python-frontmatter
    # python-graphviz
    # python-mutagen
    # python-notify2
    # python-opencv
    # python-pillow
    # python-pipx
    # python-psycopg2
    #
    # audio:
    # python-pyalsa
    #
    # bluetooth:
    # python-pybluez
    #
    # python-pycryptodome
    # python-pylast
    #
    # neovim:
    # python-pynvim
    #
    # python-pyscard
    # python-pystray

    # python-pywalfox

    # python-regex
    # python-scikit-learn
    # python-seaborn
    # python-sympy
    # python-tldextract
    # python-typing_extensions

    # AI/ML/NLP:
    # python-vadersentiment

    # qrencode
    # qt5-base
    # qt5-styleplugins
    # quickjs-ng

    # rapidcheck

    # monitor metadata:
    #
    # read-edid

    # ruby-dbus
    # ruby-rexml

    # ruffle-nightly-bin
    # rust-bindgen

    # ryzen_smu-dkms-git

    # samba

    # scrcpy
    # shaderc

    # code linters:
    #
    # shellcheck
    # shfmt

    signal-desktop

    # smartmontools

    # speedtest++

    # spin

    # ssh:
    #
    # ssh-audit
    # openssh
    # sshfs

    # shell prompt:
    #
    # starship

    # astronomy:
    #
    # stellarium

    # torrents:
    #
    # stig-git
    # transmission-cli
    # transmission-gtk
    # inputs.transg-tui.packages.${pkgs.stdenv.hostPlatform.system}.default

    # stocks:
    #
    # stonks

    # system-config-printer

    # system monitors:
    #
    # systemctl-tui

    # linters:
    #
    # taplo-cli # toml lint and format

    # data recovery:
    #
    # testdisk
    # ddrescue

    # documentation:
    #
    # mdbook
    # man-pages
    # m4
    # groff
    #
    # texinfo
    # texlab
    #
    # texlive-bibtexextra
    # texlive-fontsextra
    # texlive-formatsextra
    # texlive-games
    # texlive-humanities
    # texlive-latexextra
    # texlive-mathscience
    # texlive-music
    # texlive-pictures
    # texlive-pstricks
    # texlive-publishers

    # tllist

    # tmux

    # toml11

    # tor
    # torsocks

    # usbutils

    # vapoursynth-git

    # remote desktop:
    #
    # vinagre
    # sunshine???

    # vulkan:
    #
    # vulkan-headers
    # vulkan-icd-loader
    vulkan-tools
    # vulkan-validation-layers
    # waifu2x-ncnn-vulkan
    # dain-ncnn-vulkan-git
    # vkmark
    # srmd-ncnn-vulkan-git
    # lib32-vulkan-icd-loader

    # networking:
    #
    # whois
    # bearssl
    # netctl
    # networkmanager
    # dhcpcd
    #
    # dns:
    #
    # bind
    # dnsmasq
    #
    # network debugging:
    #
    # traceroute
    # tcpdump
    # wireshark-cli
    # wireshark-qt
    # termshark
    #
    # wireguard-tools
    # wireless_tools
    # wpa_supplicant
    #
    # nmap
    # nspr
    # nss

    # wine:
    #
    # wine-gecko
    # wine-mono
    # wine-staging
    # winetricks-git

    # diffing:
    #
    # xdelta3

    xdg-user-dirs

    # xorg(ew):
    #
    # xkblayout-state-git
    # xorg-bdftopcf
    # xorg-font-util
    # xorg-fonts-100dpi
    # xorg-fonts-75dpi
    # xorg-fonts-encodings
    # xorg-iceauth
    # xorg-mkfontscale
    # xorg-server
    # xorg-server-common
    # xorg-server-devel
    # xorg-server-xephyr
    # xorg-server-xnest
    # xorg-server-xvfb
    # xorg-sessreg
    # xorg-setxkbmap
    # xorg-smproxy
    # xorg-x11perf
    # xorg-xauth
    # xorg-xbacklight
    # xorg-xcmsdb
    # xorg-xcursorgen
    # xorg-xdpyinfo
    # xorg-xdriinfo
    # xorg-xeyes
    # xorg-xgamma
    # xorg-xhost
    # xorg-xinput
    # xorg-xkbcomp
    # xorg-xkbevd
    # xorg-xkbutils
    # xorg-xkill
    # xorg-xlsatoms
    # xorg-xlsclients
    # xorg-xmodmap
    # xorg-xpr
    # xorg-xprop
    # xorg-xrdb
    # xorg-xrefresh
    # xorg-xsetroot
    # xorg-xvinfo
    # xorg-xwayland
    # xorg-xwd
    # xorg-xwininfo
    # xorg-xwud

    # zimg

    # zita-alsa-pcmi
    # zita-resampler

    # do these exist on NixOS?
    #
    # linux-headers
    # linux-zen-headers

    # arch-specific:
    #
    # base
    # base-devel
    #
    # chaotic-keyring
    # arch-install-scripts
    #
    # pacman
    # pacman-contrib
    # paru
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
    # settings = {
    #   allow-preset-passphrase = true;
    #   default-cache-ttl = 34560000;
    #   max-cache-ttl = 34560000;
    # };
  };

  # ssh daemon
  services.openssh.enable = true;

  services.mullvad-vpn.enable = true; # TODO: beta?

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

  services.playerctld.enable = true;

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
