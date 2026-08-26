{
pkgs,
hyprlandPkgs,
rosePineHyprcursorPkgs,
# hyprDynamicCursorsPkgs,
...
}:

{
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = with pkgs; [
    hyprlandPkgs.hyprland

    # cursors:
    rosePineHyprcursorPkgs.default
    capitaine-cursors
    # hyprDynamicCursorsPkgs.hypr-dynamic-cursors

    tty-clock

    bubblewrap # sandboxing

    dragon-drop

    ghostty

    quickshell

    libreoffice

    # notifications:
    #
    mako
    # dunst

    themix-gui
    papirus-icon-theme # fuzzel.ini uses icon-theme=Papirus

    # window managers:
    #
    sway
    # i3
    #
    # window manager utilities:
    #
    # status bar:
    # i3blocks
    #
    hypridle
    # swayidle
    #
    hyprlock
    # swaylock-effects
    # i3lock-color
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

    # system menus
    fuzzel
    dmenu-wayland
    # dmenu
    # rofi

    system-config-printer

    lm_sensors
    systemctl-tui

    gimp

    kooha # gif recorder

    slurp
    grim

    # audio controller:
    #
    pavucontrol
    pulsemixer
    ncpamixer

    # display metadata:
    #
    read-edid
    ddcutil

    wineWow64Packages.stagingFull

    # pdf:
    #
    zathura
    zathuraPkgs.zathura_djvu
    zathuraPkgs.zathura_pdf_mupdf
    # evince
    #
    # pdfjs
    # pdftk

    # kdeconnect
    lan-mouse

    qutebrowser
  ];
}
