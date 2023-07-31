## File descriptions

<details>
  <summary>See list</summary>

  ##### Legend
  `x`      = definitely works
  `i`      = supported with issues <br>
  `ip`     = planning support <br>
  ` `      = not supported <br>
  `%%%`    = not git pushed <br>
  `?`      = no clue <br>

  ##### Info
  | Config file | Description | Ubuntu 20.04+ | Termux | Windows 10 |
  | --- | --- | --- | --- | --- |
  | [~/.config/nvim](.config/nvim/) | Config for Neovim; powerful text editor / PDE | x | i | ? |
  | [~/.config/ranger](.config/ranger) | File manager in terminal; planning to remove later | x | x |
  | [~/.config/Vencord](.config/Vencord) | Vencord is a Discord client | ? | ? |
  | [~/.config/Kvantum](.config/Kvantum) | Force dark mode on some apps | x | ? |
  | [~/.config/i3](.config/i3) | Window Manager for X11 compositor on Linux | x | ? |
  | [~/.config/kitty](.config/kitty) | Terminal emulator | x |
  | [~/.config/mimeapps.list](.config/mimeapps.list) | Fix for i3 default links on Ubuntu | x |
  | [~/.config/picom.conf](.config/picom.conf) | Compositor for X11; allows for transparent windows | x | ? |
  | [~/.config/screenkey.json](.config/screenkey.json) | See keys typed on screen | x | ? |
  | [~/.termux/font.tff%%%](.termux/font.tff) | Set default font in Termux | | x |
  | [~/.local/share/fonts](.local/share/fonts) | Set default font in Ubuntu | x |
  | [~/.fzf](.fzf) | file fuzzy finder | x | ? | ? |
  | [~/.newsboat](.newsboat) | Terminal RSS reader with vim keybinds in config | x | ? | ? |
  | [~/.bashrc](.bashrc) | bash shell config | x | ? |
  | [~/.bash_aliases](.bash_aliases) | aliases for shell | x | ? |
  | [~/.profile](.profile) | another startup file found by default in Ubuntu 20.04 | x | ? |
  
</details>


## Neovim config

[See .config\/nvim\/](.config/nvim/)

## Install nerd fonts

Click Download on any of the fonts in the link below; they all contain nerd fonts.
[NerdFonts Install](https://nerdfonts.com/font-downloads)

Place it in [`~/.local/share/fonts`](.local/share/fonts) and create the fonts folder if it doesn't already exist.

For my case I downloaded with cURL:
```
cd ~/.local/share/fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Mononoki.zip
unzip Mononoki.zip
```
After that, I changed the default fonts in the kitty terminal. In your case, see your config settings for your terminal if it doesn't apply on its own.

In Termux:
```
cd ~/.termux
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Mononoki.zip
unzip Mononoki.zip
mv MononokiNerdFont-Regular.ttf font.ttf
termux-reload-settings
# Font should be changed on Termux now and neovim.

rm M*.ttf LICENSE.txt
rm Mononoki.zip
```

## Showcase

![image](https://github.com/FrostyNick/dotfiles/assets/57016218/dc492a6c-f389-45b4-b874-b4850f5ea08a)
