# My Dotfiles
Here are my dotfiles so you can have fun spending hours fucking around with configuration files too!

![Rice](rice.png "rice")

## Installing my dotfiles
Installing my dotfiles on your own pc is as simple as

```sh
git clone https://gitgud.io/t/friedrice ; rsync -av friedrice/* ~ ; rsync -av friedrice/.* ~ ; rm -rf friedrice
```

## Configs that I store here
**Note: Configs with a '*' have variables that are managed by [wpgtk](https://github.com/deviantfero/wpgtk)**

*wpgtk templates are stored in .config/wpg/templates/*

* [shell aliases](.shal) - usually outdated in favor of [.zshal](.zshal)
* [manpage and less colors](.mancolors)
* [.profile](.profile)
* [zsh](.zsh)
  - [zsh expanded aliases](.zshal)
  - [zsh completion options](.zsh/compopt)
* [bash](.bashrc)
* [yay](.config/yay/config.json)
* [.xinitrc](.xinitrc)
* [i3](.config/i3/config)
* [i3blocks*](.config/i3blocks)
* [tmux](.tmux.conf)
* [rofi*](.config/rofi/config)
* [qutebrowser](.config/qutebrowser)
  - [colorscheme*](.config/qutebrowser/appearance.py)
  - [search engines](.config/qutebrowser/searchengines.py)
  - [keybinds](.config/qutebrowser/keybinds.py)
* [ranger](.config/ranger)
  - [rc.conf](.config/ranger/rc.conf)
  - [custom devicons](.config/ranger/devicons.py)
* [neovim + plugins](.config/nvim/init.vim)
* [neofetch](.config/neofetch)
* [mpv*](.config/mpv)
  - [keybinds](.config/mpv/input.conf)
* [mpd](.config/mpd/mpd.conf)
* [ncmpcpp](.ncmpcpp)
  - [keybinds](.ncmpcpp/bindings)
* [.inputrc](.inputrc)
* [dunst*](.config/dunst/dunstrc)
* [cava](.config/cava/config)
* [st*](prg/st/config.h)
* [slock*](prg/slock/config.h)
* [dmenu*](prg/dmenu/config.h)
* [dwm](prg/dwm/config.h)
* [.Xresources](.Xresources)
* [my shell scripts](bin)
* [wpgtk](.config/wpg)
  - [templates](.config/wpg/templates)
* [lynx](.lynxrc)
* [w3m](.w3m)
  - [keybinds](.w3m/keymap)
* [calcurse](.calcurse)
  - [keybinds](.calcurse/keys)
* [urlscan](.config/urlscan/config.json)
* [zathura](.config/zathura/zathurarc)
* [neomutt](.config/mutt)
  - [colors](.config/mutt/muttcols)
* [htop](.config/htop/htoprc)
* [newsboat](.config/newsboat/config)
* [vis](.config/vis/config)
* [linux steam integration](.config/linux-steam-integration.conf)
* [tty keyboard remap](.config/ttymaps.kmap)
* other stuff I/you might want/need

![winblows](windows_and_cameras.png "winblows")
