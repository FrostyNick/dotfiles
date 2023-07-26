## File descriptions

<details>
  <summary>See list</summary>

  ##### Legend
  x = definitely works <br> ? = no clue <br> empty = not supported <br> %%% = not git pushed

  ##### Info
  | Config file | Description | Ubuntu 20.04+ | Termux | Windows 10 |
  | --- | --- | --- | --- | --- |
  | ~/.config/nvim | Config for powerful text editor / PDE | x | x | ? |
  | ~/.config/ranger | File manager in terminal; planning to remove later | x | x |
  | ~/.config/BetterDiscord | BetterDiscord config files; might switch to Vencord | ? | ? |
  | ~/.config/Kvantum | Force dark mode on some apps | x | ? |
  | ~/.config/i3 | Window Manager for X11 compositor on Linux | x | ? |
  | ~/.config/kitty | Terminal emulator | x |
  | ~/.config/mimeapps.list | Fix for i3 default links on Ubuntu | x |
  | ~/.config/picom.conf | Compositor for X11; allows for transparent windows | x | ? |
  | ~/.config/screenkey.json | See keys typed on screen | x | ? |
  | ~/.termux/font.tff%%% | Set default font in Termux | | x |
  | ~/.local/share/fonts | Set default font on most linux distros | x |
  | ~/.fzf | file fuzzy finder | x | ? | ? |
  | ~/.newsboat | RSS reader in terminal with vim keybinds | x | ? | ? |
  | ~/.bashrc | bash shell config | x | ? |
  | ~/.bash_aliases | aliases in shell | x | ? |
  | ~/.profile | another startup file found by default in Ubuntu 20.04 | x | ? |
  
</details>


## Neovim config

[See .config\/nvim\/](.config/nvim/)

## Install nerd fonts

Click Download on any of the fonts in the link below; they all contain nerd fonts.
[NerdFonts Install](https://nerdfonts.com/font-downloads)

Place it in `~/.local/share/fonts` and create the fonts folder if it doesn't already exist.

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
