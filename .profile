#!/bin/sh
# ~/.profile
#
# do the shellcheck y stuff disable=1091
#
# Put stuff here that you only want sourced when
# initializing login shells

. "$HOME/.mancolors"
. "$HOME/.config/lf/ico"
. "$HOME/.secret"

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/go/bin:$PATH"
# export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"

export PATH

# Default Programs
export EDITOR="edit"
export VISUAL="$EDITOR"
export TERMINAL="kitty -1"
# export TERMINAL="wezterm"
# export TERM=xterm-kitty
export BROWSER="firefox-nightly firedragon librewolf firefox qutebrowser"
export PAGER="nvimpager -p"
export FILEMAN="yazi"
export TASKMAN="htop" # btop "ytop -p" btm
export MUSICPLAYER="ncmpcpp"
export NEWSREADER="newsboat"
export READER="zathura"
export MAILREADER="neomutt"
export STATUSBAR="waybar"

# RICE!!!!!
export FONT="Mononoki Nerd Font"
export FONT_SIZE="11"
export GTK_THEME="oomox"
export QT_QPA_PLATFORMTHEME="gtk3"

# Program Configuration
export LYNX_CFG="$HOME/.lynxrc"
# Because some programs can't find the pulse cookie on their own I guess
export PULSE_COOKIE="$HOME/.pulse-cookie"

# XDG AppDirs
## NOTE: symlinked to ~/.local/etc and ~/etc
export XDG_CONFIG_HOME="$HOME/.config"
## TODO: symlink to ~/.local/cache or ~/cache or ~/var/cache?
export XDG_CACHE_HOME="$HOME/.cache"
## TODO: symlink to ~/share?
export XDG_DATA_HOME="$HOME/.local/share"
## TODO: symlink to ~/var/log?
export XDG_STATE_HOME="$HOME/.local/state"

## Wine
export WINEESYNC=1
export WINEFSYNC=1
# export STAGING_SHARED_MEMORY=1
# export STAGING_WRITECOPY=1
## DXVK
export DXVK_HUD="compiler"
export DXVK_ASYNC=0
## Graphics
export AMDVLK_ENABLE_DEVELOPING_EXT="all"
export ENABLE_VKBASALT=0
export RUSTICL_ENABLE=radeonsi
# export mesa_glthread=true
# export RADV_FORCE_VRS="2x2"
export RADV_PERFTEST="rt,sam,nv_ms" # pswave32,gewave32,cswave32
export VAAPI_MPEG4_ENABLED=true

# Dev Environment
export GOPATH="$XDG_DATA_HOME/go"
export CLASSPATH="$CLASSPATH:/usr/share/java/*"
## LaTeX plugins
export TEXINPUTS="$HOME/doc/tex/*/:$TEXINPUTS"
export PYO3_USE_ABI3_FORWARD_COMPATIBILITY=1

[ "$TERM" = linux ] \
    && [ -f "$XDG_CACHE_HOME/wal/colors-tty.sh" ] \
    && . "$XDG_CACHE_HOME/wal/colors-tty.sh"

[ -d "$HOME/.themes/$GTK_THEME" ] || {
    echo >&2 "Error: $GTK_THEME is not installed."
    echo "Fix this right now!"
}

# my super simple login manager
[ "$WAYLAND_DISPLAY" ] || [ "$DISPLAY" ] || [ "$SSH_TTY" ] || [ "$TMUX" ] || {
    login_options=$(
        cat <<EOF
tty
sway
xorg
hyprland
EOF
    )

    header="How do you wish to log in?"
    disp=$(echo "$login_options" | fzf --header "$header" --header-first)

    case $disp in
        tty)
            echo "NOTE: Setting repeat and delay rate (Requires root)"
            sudo -n kbdrate -r 35 -d 150 >/dev/null
            # TODO: Remap caps lock and escape using interception
            echo "NOTE: Remapping keys (Requires root)"
            sudo loadkeys /etc/keystrings
            ;;
        xorg)
            # Set up multi-monitor FreeSync correctly by piggy-backing off wayland's better FreeSync support
            # sway &
            # sleep 5
            # SWAYSOCK="/run/user/$(id -u)/sway-ipc.$(id -u).$(pgrep -x sway).sock" sway exit
            startx
            ;;
        sway | hyprland)
            # export WLR_RENDERER=vulkan
            # export QT_QPA_PLATFORM=wayland
            # export SDL_VIDEODRIVER=wayland
            # export XDG_CURRENT_DESKTOP="$disp"
            export MOZ_ENABLE_WAYLAND=1
            export ELECTRON_OZONE_PLATFORM_HINT=wayland
            if hash uwsm 2>/dev/null && uwsm check may-start; then # && uwsm select
                exec uwsm start "${disp}-uwsm.desktop"
            else
                case $disp in sway) flags='--unsupported-gpu' ;; esac
                exec $disp $flags
            fi
            ;;
    esac
}

[ "$TERM" = linux ] && {
    echo "NOTE: Setting repeat and delay rate (Requires root)"
    sudo -n kbdrate -r 35 -d 150 >/dev/null
    # TODO: Remap caps lock and escape using interception
    echo "NOTE: Remapping keys (Requires root)"
    sudo loadkeys /etc/keystrings
}

# FIXME: uh is this recommended? we're currently spawning hella ssh agents
[ "$SSH_AGENT_PID" ] || {
    eval "$(ssh-agent)"
    ssh-add "$HOME/.ssh/id_rsa"
}

source_if_exists() { [ -e "$1" ] && . "$1"; }

source_if_exists "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer
source_if_exists "$HOME/.cargo/env"
