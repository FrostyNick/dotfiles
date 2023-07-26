## Compatability

##### Legend
x = definitely works <br> ? = no clue <br> empty = not supported <br> %%% = not git pushed

| File | Ubuntu 20.04+ | Termux | Windows 10 |
| --- | --- | --- | --- |
| ~/.config/nvim | x | x | ? |
| ~/.config/ranger | x | x | |
| ~/.config/BetterDiscord | x | ? | ? |
| ~/.config/Kvantum | x | ? | |
| ~/.config/i3 | x | ? | |
| ~/.config/kitty | x | | |
| ~/.config/mimeapps.list | x | | |
| ~/.config/picom.conf | x | ? | |
| ~/.config/screenkey.json | x | ? | |
| ~/.termux/font.tff%%% | | x | | 
| ~/.local/share/fonts | x | | |
| ~/.fzf | x | ? | ? |
| ~/.newsboat | x | ? | ? |
| ~/.bashrc | x | ? | |
| ~/.bash_aliases | x | ? | |
| ~/.profile | x | ? | |

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
