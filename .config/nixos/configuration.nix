# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, chaotic, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

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
    ];
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://chaotic-nyx.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "chaotic-nyx.cachix.org-1:Z1OsgFx+V3eyGEIYirsc7blQLuui3CFbfvdqZQhSLaw="
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
    hostName = "noveria"; # Define your hostname.

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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  fonts.packages = with pkgs; [
    nerd-fonts.terminess-ttf
  ];

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  services.interception-tools = {
    enable = true;
    plugins = with pkgs.interception-tools-plugins; [
      caps2esc
      dual-function-keys
    ];
    # udevmonConfig = "/home/ty/.config/interception-tools/udevmon.yaml";
    udevmonConfig =
      ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE \
            | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c ${config.users.users.ty.home}/.config/interception-tools/dual-function-keys/kbd.yaml \
            | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [[KEY_F12]]
      '';
  };

  # CUPS
  services.printing.enable = true;

  # Drive Configuration
  #
  # If the options attribute is not set, it'll default to "defaults"
  # boot options for fstab. Search up fstab mount options you can use
  # "users": Allows any user to mount and unmount
  # "nofail": Prevent system from failing if this drive doesn't mount

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

  # 3TB Seagate Barracuda
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/1cc1e9b2-6994-4ec0-a4e2-93583f1e483f";
    fsType = "ext4";
    options = [
      "rw"
      "relatime"
      # dump=0 pass=2
    ];
  };

  # 1TB Western Digital - Pretty old
  fileSystems."/mnt/old" = {
    device = "/dev/disk/by-uuid/80e51b2c-98b3-41f9-b4c9-51b6fc27122d";
    fsType = "ext4";
    options = [
      "rw"
      "relatime"
      # dump=0 pass=2
    ];
  };

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

  # programs.firefox = {
  #   enable = true;
  #   package = pkgs.latest.firefox-nightly-bin;
  #   policies = {
  #     Preferences = {
  #       "sidebar.revamp" = true;
  #       "sidebar.verticalTabs" = true;
  #       "browser.compactmode.show" = true;
  #       "image.jxl.enabled" = true;
  #     };
  #   };
  # };

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
    # human i2c boinc plugdev render audio
    extraGroups = [
      "wheel"
      "video"
      "libvirt"
    ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  # mesa-git.enable = true;

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
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

  # List packages installed in system profile.
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
    fd
    killall
    pandoc
    tree
    broot
    just
    khal
    khard
    # which
    # buku

    # gaming:
    #
    mangohud # TODO: -git?
    # steamcmd
    # supertuxkart
    # neverball
    # moon-buggy
    # lutris-git
    # mesa-demos
    # mesa-tkg-git
    # lib32-gamemode
    # gamemode
    # gamescope
    # chaotic.packages.${pkgs.stdenv.hostPlatform.system}.mesa_git
    # lib32-mesa-tkg-git
    # lib32-vkbasalt

    # ricing:
    #
    cmatrix
    cava
    catnip
    pipes
    pipes-rs
    fastfetch
    openrazer-daemon
    # themix-full-git
    # lxappearance
    # wraith-master-bin
    wallust
    # matugen-bin
    # neo-matrix-git
    # neofetch
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    # capitaine-cursors
    #
    # razer things:
    #
    # razercommander-git
    # python-openrazer-git
    # polychromatic

    # status bar
    waybar
    wttrbar # TODO: track git?
    inputs.gpu-usage-waybar.packages.${pkgs.stdenv.hostPlatform.system}.default

    # compilers:
    #
    gcc
    clang
    #
    # build systems:
    #
    # make
    # autoconf
    # automake
    #
    # dev tools:
    #
    # binutils
    # bison
    # flex
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
    # cache:
    #
    ccache
    #
    # debugging:
    gdb

    # sys admin
    bottom

    # browsers:
    #
    inputs.firefox-nightly.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin
    brave
    # chaotic.packages.${pkgs.stdenv.hostPlatform.system}.firefox_nightly
    # firefox
    # latest.firefox-nightly-bin
    # librewolf
    # firedragon
    tor-browser
    qutebrowser
    # lynx

    # browser utils
    browserpass

    # gpu:
    #
    # xf86-video-amdgpu
    # rocmPackages
    # rocmPackages.rocm-smi
    nvtopPackages.amd

    # terminals
    kitty
    ghostty
    alacritty
    # foot
    # wezterm-git

    vdirsyncer

    # file management
    yazi
    yaziPlugins.piper
    yaziPlugins.ouch
    yaziPlugins.git
    lf
    dragon-drop

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

    # pdf readers:
    #
    zathura
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    # evince

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


    # do these exist on NixOS?
    #
    # linux-headers
    # linux-zen-headers

    # notifications:
    #
    mako
    # dunst

    # mail:
    #
    neomutt
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

    sway

    # messaging:
    #
    teams-for-linux
    # discord
    vesktop

    # menus:
    #
    fuzzel # TODO: move to -git?
    fzf
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

    chafa

    # audio:
    #
    # chromaprint-fftw
    # cli-visualizer-git

    # compute:
    #
    # clinfo

    # compilers:
    #
    # llvm:
    #
    # compiler-rt

    # clipboard management:
    #
    # clipman
    # clipmenu
    # clipnotify

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

    # dash
    # dashbinsh

    # davfs2

    # dbus

    # ddcutil
    # ddrescue
    # dhcpcd
    # dialog

    # motherboard info:
    #
    # dmidecode

    # dos2unix
    # dosbox
    # dosfstools

    # drm_monitor-git

    # disk usage:
    #
    # dua-cli
    dust

    # gaming:
    #
    # dualsensectl-git
    # dxvk-mingw-git

    # e3

    # easyeffects
    # easyeffects-git-debug

    # editline
    # efibootmgr
    # fakeroot
    # fcft

    # featherwallet-bin

    # festival

    # ff2mpv-native-messaging-host-git

    # flatpak

    # file system:
    #
    # fuse-overlayfs

    # gammastep

    # gegl
    # gengetopt
    # ghostscript

    # gifsicle

    gimp

    # window manager utilities:
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    # i3-wm
    # i3blocks
    # i3lock-color

    # git-credential-manager-bin
    # git-lfs
    # github-cli

    # system monitors:
    #
    # glances
    htop
    # btop
    lm_sensors

    # gjs
    # glfw
    # glibmm-2.68
    # glslang
    # gmni-git

    # language toolchains:
    #
    # go
    # ghc
    # gcc-fortran
    # nodejs
    # nuget # c#

    # game dev:
    #
    # godot

    # google-earth-pro

    # grabc

    # gst-plugins-base
    # gstreamer

    # gtk-vnc
    # gtk4
    # gtkmm-4.0
    # gurk
    # gutenprint
    # hashcat
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

    # lib32-gtk3
    # lib32-libdrm-git
    # lib32-libomxil-bellagio
    # lib32-libxslt
    # lib32-llvm-libs

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

    # lib32-sdl2-compat

    # camera:
    #
    # lib32-v4l-utils

    # libclc
    # libcurlpp

    # gpu:
    #
    # libdrm-git

    # libirecovery-git

    # libnfc

    # audio:
    #
    # libldac
    # libpulse

    # cad:
    #
    # librecad

    # libretro-flycast
    # libretro-ppsspp

    # librist
    # libsixel
    # libtool
    # libva-utils

    # virtualization:
    #
    # libvirt

    # linuxwave

    # liquidctl-git
    # lksctp-tools

    # lld

    # lldb
    # llvm-libs

    # lolcat

    # love
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

    # documentation:
    #
    # mdbook
    # man-pages
    # m4

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

    # music:
    #
    # ncspot
    # nicotine+

    # rss reader:
    #
    # newsboat

    # library:
    #
    # nlohmann-json

    # networking:
    #
    # nmap
    # nspr
    # nss

    # audio:
    #
    # noise-repellent

    # ntfs-3g

    nvimpager

    # obs-studio
    # obs-vaapi

    # note taking:
    #
    # obsidian

    # openmp

    # opencv

    # opensc
    # opensmtpd

    # openssh

    # fonts:
    #
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

    # pacman
    # pacman-contrib
    # paru

    # pam-gnupg-git

    pass # TODO: -git?

    # passff-host
    # patch

    pavucontrol

    # emulation:
    #
    # pcsx2-git
    # retroarch
    # qemu-system-x86
    # qemu-user-static
    # virt-manager

    # pdfjs
    # pdftk

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
    # projectm

    # audio controller:
    #
    # pulsemixer

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
    # python-pyalsa
    # python-pybluez
    # python-pycryptodome
    # python-pylast
    # python-pynvim
    # python-pyscard
    # python-pystray

    pywalfox-native
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

    # r

    # rapidcheck

    # monitor metadata:
    #
    # read-edid

    # redshift

    # dev tools:
    #
    # repo

    # gaming:
    #
    # reshade-shaders-git

    # ruby
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
    # spicetify-cli-git
    # spin
    # ssh-audit

    # shell:
    #
    # starship

    # sshfs

    # astronomy:
    #
    # stellarium

    # stig-git

    # stonks

    # sudo

    # swayidle

    # swaylock-effects

    # swww

    # system-config-printer

    # system monitors:
    #
    # systemctl-tui

    # taplo-cli

    # networking:
    #
    # tcpdump

    # data recovery:
    #
    # testdisk

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
    #
    # groff

    # the_silver_searcher

    # thunderbird

    # tllist

    # tmux

    # toml11

    # tor
    # torsocks

    # traceroute
    # transg-tui-git
    # transgender

    # transmission-cli
    # transmission-gtk

    # fonts:
    #
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

    # usbutils

    # terminal utilities:
    #
    # ttyqr-git
    # ueberzugpp
    # urlscan
    # tty-clock-git
    # trash-cli

    # games:
    #
    # tty-solitaire-git
    # vitetris

    # package managers:
    #
    # pixi
    # uv
    # yarn
    # npm
    # cpanminus
    #
    # build tools:
    #
    # pkgconf

    # camera utils:
    #
    # v4l2loopback-dkms
    # v4l2loopback-utils
    # cheese

    # vapoursynth-git

    # terminal utils:
    #
    # vimv-git

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
    # vkbasalt
    # vkmark
    # srmd-ncnn-vulkan-git
    # lib32-vulkan-icd-loader

    # networking:
    #
    # whois
    # bearssl
    # netctl
    # networkmanager
    #
    # dns:
    #
    # bind
    # dnsmasq
    #
    # network debugging:
    #
    # wireshark-cli
    # wireshark-qt
    # termshark
    #
    # wireguard-tools
    # wireless_tools
    # wpa_supplicant

    # wine:
    #
    # wine-gecko
    # wine-mono
    # wine-staging
    # winetricks-git

    # wayland utilities:
    #
    # wdisplays-git
    # arandr
    #
    # wev
    #
    # wf-recorder-git
    #
    wl-clipboard
    # wlr-randr-git
    # wlrobs-hg
    #
    # desktop portals:
    #
    # xdg-desktop-portal-gtk
    # xdg-desktop-portal-hyprland
    # xdg-desktop-portal-wlr

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
    # xorg-xev
    # xorg-xeyes
    # xorg-xgamma
    # xorg-xhost
    # xorg-xinit
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
    # xorg-xrandr
    # xorg-xrdb
    # xorg-xrefresh
    # xorg-xset
    # xorg-xsetroot
    # xorg-xvinfo
    # xorg-xwayland
    # xorg-xwd
    # xorg-xwininfo
    # xorg-xwud
    # xsel
    # xclip
    # xdo

    # zimg

    # zita-alsa-pcmi
    # zita-resampler

    # pretty sure these are arch-specific:
    #
    # base
    # base-devel
    #
    # chaotic-keyring
    # arch-install-scripts
  ];

  chaotic.mesa-git.enable = false;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
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
