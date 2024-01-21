I am open to PR requests, issues or questions (in discussions). Just make an
issue and then after getting my feedback you can work on the PR. Other than
that, feel free to learn and take any amount of code to tweak or do whatever
you want.

If you learn something, consider adding a star or commenting.


## Preview

![Setup showcase](https://github.com/FrostyNick/dotfiles/assets/57016218/dc492a6c-f389-45b4-b874-b4850f5ea08a)


## File descriptions

<details>
  <summary>See list</summary>

  ##### Legend
  `x`      = definitely works
  `!`      = supported with issues <br>
  `ip`     = planning support <br>
  ` `      = not supported <br>
  `%%%`    = not git pushed <br>

  ##### Descriptions
  | Config file                                                                            | Description                                            | Ubuntu | Termux | Windows 10 |
  | ---                                                                                    | ---                                                    | -      | -      | -          |
  | [~/.config/nvim/](.config/nvim/)                                                       | Neovim config; powerful text editor / PDE              | x      | !      | ip         |
  | [~/.config/doom/](.config/doom/)                                                       | Doom Emacs config; IDE I rarely use; favorite mode     | x      | ?      |
  | [~/.config/Vencord/](.config/Vencord)                                                  | Vencord is a Discord client                            | x      |        | x          |
  | [~/.config/VencordDesktop/VencordDesktop/themes/](.config/VencordDesktop/V.../themes/) | Vesktop is a (Discord) Vencord client                  | x      |        | x          |
  | [~/.config/alacritty.toml](.config/alacritty.toml)                                     | Terminal emulator (made for speed; .toml conf)         | x      |        | x          |
  | [~/.config/kitty/](.config/kitty)                                                      | Terminal emulator                                      | x      |
  | [~/.config/wezterm/](.config/wezterm)                                                  | Terminal emulator (more features built-in; .lua conf)  | x      |        | x          |
  | [~/.config/Kvantum/](.config/Kvantum)                                                  | Force dark mode on some apps                           | x      |
  | [~/.config/mimeapps.list](.config/mimeapps.list)                                       | Fix for i3 default links on Ubuntu                     | x      |
  | [~/.config/i3/](.config/i3)                                                            | Window Manager for X11 compositor on Linux             | x      |
  | [~/.config/picom.conf](.config/picom.conf)                                             | Compositor for X11; transparent windows, effects, etc. | x      |
  | [~/.config/screenkey.json](.config/screenkey.json)                                     | See keys typed on screen                               | x      |
  | [~/.config/zathura/](.config/zathura/)                                                 | Tiny vim-like PDF/epub/other viewer                    | x      |
  | [~/.termux/font.tff%%%](.termux/font.tff)                                              | Set default font in Termux                             |        | x      |
  | [~/.local/share/fonts/](.local/share/fonts)                                            | Set default font in Ubuntu                             | x      |
  | [~/.fzf](.fzf/)                                                                        | Fuzzy finder                                           | x      | !      |
  | [~/.newsboat/](.newsboat)                                                              | Terminal RSS+atom reader with vim keybinds in config   | x      | x      |
  | [~/.bashrc](.bashrc)                                                                   | Bash shell config                                      | x      | ?      |
  | [~/.bash_aliases](.bash_aliases)                                                       | Aliases for bash shell                                 | x      | x      |
  | [~/.profile](.profile)                                                                 | Another startup file found by default in Ubuntu 20.04  | x      |
 
</details>


## Neovim config

[See `.config/nvim/`](.config/nvim/) for learning Vim/Neovim or learning how
the config works.

<details>
    <summary>What's in this config?</summary>

- Working LSP. Search LSP in <kbd>leader + ?</kbd> for LSP
  keybinds.
    - <kbd>gr</kbd> - rename variable based on code context. (it won't mess up
      other variables)
    - <kbd>gd</kbd> - go to definition.
- Aggressively testing code and new plugins. Things might break once in a while.
- Space = leader key.
- Live server for web testing. <kbd>leader + l + l</kbd> - Toggle live
  server; there's no toggle in original plugin. Powered by
  barrett-ruth/live-server.nvim. Requires npm; yarn works too, see live-server
  readme and modify config.
- Sane defaults for coding, tabs, etc.
- Minimal look and feel.
- Startup time is about 32ms.
    - "VeryLazy" is about 65ms (doesn't include plugins that aren't loaded
  yet).
    - Note: Benchmarks vary a lot. Startup time for neovim plugins
  are 5-20x slower on Windows compared to Linux for some reason if you somehow
  get it running there based on my rough testing (native nvim + Wezterm).
- Several keybinds while being mindful about existing vim keybinds; especially
  if they're useful keybinds.
    - <kbd>leader + ,</kbd> to see previous files. In plain vim, <kbd>:bro
      o</kbd> is the shortest alternative.
    - <kbd>leader + t</kbd> to open terminal in a vertical split.
    - <kbd>leader + b</kbd> to switch/see buffers.
    - <kbd>leader + z + d</kbd> to get definition of a word. (Needs dependency
      `dict` to work and in some Linux distros you may also need another
      package for specifically the english/other-language part of dictionary.)
- Uses the Lazy plugin manager.
- 30+ plugins; plugin configuration is located in
  [...`/nvim/lua/frostynick/lazy.lua`](.config/nvim/lua/frostynick/lazy.lua)
    <!-- .config/nvim/lua/frostynick/lazy.lua -->
    <!-- if you're in vim remember gf - go to file for above -->
    - Telescope, Treesitter - A must have for Neovim.
    - Treesitter textobjects - For now you can <kbd>dif</kbd> to
      delete inside a function, <kbd>caf</kbd> to delete around a function,
      etc. There's a lot of potential for this since it's just the start of
      this part of the config.
    - Use nvim surround for many new keybinds. Starts with <kbd>ys</kbd> "you
      surround"
    - Format markdown tables with `:Tableize` or <kbd>leader + m + t</kbd>.
      Preview markdown in the web with `:MarkdownPreviewToggle` or <kbd>leader
      \+ m + m</kbd>. Requires `npm` or possibly `yarn` with config changes.
    - Git fugitive. Access with <kbd>leader + g + f</kbd>
    - Neorg support.
    - Comment.nvim (gcc to comment current line; gc(motions) to select where to
      comment; many vim like shortcuts supported)
    - Zen mode, Harpoon, Lua line.
    - Much more.
- Lua based plugins whenever it's better in speed or functionality.
- Not familiar with the keybinds for this config? <kbd>leader + ?</kbd>
  (leaderkey is space for everything)
- Rose pine theme. (The Showcase screenshot is likely outdated if it has a
  different theme)

</details>

## Install nerd fonts

For all the icons to be displayed correctly in the terminal, you will need to install a nerd font. (If you use WezTerm, note it has a nerd font pre-installed as a fallback and glyph characters, so no setup is needed with nerd fonts.)

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

rm MononokiNerdFont*.ttf LICENSE.txt
rm Mononoki.zip
```

<!--
## Vencord themes

# mv to
# vencord themes:
# https://raw.githubusercontent.com/Dyzean/Tokyo-Night/main/tokyo-night.theme.css

# (My preference) black mode + padding theme + modern notifications:

# Follow instructions: https://refact0r.github.io/midnight-discord/
# See ~/.config/VencordDesktop/VencordDesktop/themes/midnight.theme.css from my dotfiles for css variables to quickcss in Vencord to add opinionated padding + make the theme black rather than just dark.
# Add to Vencord: https://discord-extensions.github.io/modern-indicators/src/source.css

# video game themed discord:
# https://saltssaumure.github.io/pios-discord-theme/piOS.theme.css

# really cool but not lightweight probably because of background blur
# https://capnkitten.github.io/BetterDiscord/Themes/Translucence/css/source.css

# idk below
# https://discord-extensions.github.io/compact-userarea/src/source.css
-->


## Dotfile info

- https://dotfiles.github.io/ (I haven't looked at this it just looks promising)
- DT YT video about dotfiles + take notes + comment section.

