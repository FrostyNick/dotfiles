I am open to PR requests, issues or questions (in discussions). Just make an
issue and then after getting my feedback you can work on the PR. Otherwise, you
can fork this into something better probably.

## File descriptions

<details>
  <summary>See list</summary>

  ##### Legend
  `x`      = definitely works
  `!`      = supported with issues <br>
  `ip`     = planning support <br>
  ` `      = not supported <br>
  `%%%`    = not git pushed <br>
  `?`      = no clue <br>

  ##### Info
  | Config file                                        | Description                                           | Ubuntu | Termux | Windows 10 |
  | ---                                                | ---                                                   | -      | -      | -          |
  | [~/.config/nvim](.config/nvim/)                    | Config for Neovim; powerful text editor / PDE         | x      | !      | ?          |
  | [~/.config/ranger](.config/ranger)                 | File manager in terminal; planning to remove later    | x      | x      |
  | [~/.config/Vencord](.config/Vencord)               | Vencord is a Discord client                           | ?      | ?      |
  | [~/.config/Kvantum](.config/Kvantum)               | Force dark mode on some apps                          | x      | ?      |
  | [~/.config/i3](.config/i3)                         | Window Manager for X11 compositor on Linux            | x      | ?      |
  | [~/.config/kitty](.config/kitty)                   | Terminal emulator                                     | x      |
  | [~/.config/mimeapps.list](.config/mimeapps.list)   | Fix for i3 default links on Ubuntu                    | x      |
  | [~/.config/picom.conf](.config/picom.conf)         | Compositor for X11; allows for transparent windows    | x      | ?      |
  | [~/.config/screenkey.json](.config/screenkey.json) | See keys typed on screen                              | x      | ?      |
  | [~/.termux/font.tff%%%](.termux/font.tff)          | Set default font in Termux                            |        | x      |
  | [~/.local/share/fonts](.local/share/fonts)         | Set default font in Ubuntu                            | x      |
  | [~/.fzf](.fzf)                                     | file fuzzy finder                                     | x      | ?      | ?          |
  | [~/.newsboat](.newsboat)                           | Terminal RSS reader with vim keybinds in config       | x      | ?      | ?          |
  | [~/.bashrc](.bashrc)                               | bash shell config                                     | x      | ?      |
  | [~/.bash_aliases](.bash_aliases)                   | aliases for shell                                     | x      | ?      |
  | [~/.profile](.profile)                             | another startup file found by default in Ubuntu 20.04 | x      | ?      |
  
</details>


## Neovim config

[See `.config\/nvim\/`](.config/nvim/) for learning vim or learning how the
config works.

Comes with:
- Working LSP. Search LSP in `leader + ?` for LSP keybinds.
- Much more sane defaults for coding, tabs, etc.
- Minimal design.
- Loads in about 100ms as of today; after optimizing a few of the new plugins,
  it would probably drop to around 80ms. Also benchmarks vary on other devices.
- Many things revolve around the existing vim keybinds especially if they're
  useful keybinds.
    - `leader + ,` to see previous files. In plain vim, `:bro o` is the
      shortest alternative.
    - `leader + t` to open terminal in a vertical split.
    - `leader + b` to switch/see buffers.
- Uses the Lazy plugin manager some time before Packer was archived.
- 30+ plugins; plugin configuration is located in
  [...`/nvim/lua/frostynick/lazy.lua`](~/.config/nvim/lua/frostynick/lazy.lua)
  <!-- if you're in vim remember gf - go to file for above -->
    - Treesitter textobjects; basically for now you can <kbd>dif</kbd> to
      delete inside a function, <kbd>caf</kbd> to delete around a function,
      etc. There's a lot of potential for this since it's very barebones.
    - Use nvim surround for many new keybinds. Starts with <kbd>ys</kbd> "you
      surround"
    - Format markdown tables with `:Tableize` or `leader + m + t`. Preview
      markdown in the web with `:MarkdownPreviewToggle` or `leader + m + m`.
- Lua based whenever it's better in speed or functionality.
- Not familiar with the keybinds for this config? <kbd>leader + ?</kbd>
  (leaderkey is space for everything)
- Rose pine theme. (The screenshot is likely outdated if it has a different
  theme)
- Lua line 

## Install nerd fonts

Click Download on any of the fonts in the link below; they all contain nerd fonts.
[NerdFonts Install](https://nerdfonts.com/font-downloads)

Place it in [`~/.local/share/fonts`](.local/share/fonts) and create the fonts
folder if it doesn't already exist.

For my case I downloaded with cURL:
```
cd ~/.local/share/fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/Mononoki.zip
unzip Mononoki.zip
```
After that, I changed the default fonts in the kitty terminal. In your case,
see your config settings for your terminal if it doesn't apply on its own.

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

## Dotfile info

- https://dotfiles.github.io/ (I haven't looked at this it just looks promising)
- DT YT video about dotfiles + take notes + comment section.

## Showcase

![image](https://github.com/FrostyNick/dotfiles/assets/57016218/dc492a6c-f389-45b4-b874-b4850f5ea08a)
