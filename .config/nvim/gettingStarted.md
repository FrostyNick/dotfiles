Related: readme.md

## Starting with Vim/Neovim

If you are completely new to Vim or Neovim, focus on Vim motions.

- Run `vimtutor` if it's installed on your system and learn the basics.
  Otherwise, open Vim and type `:help` to get started.

### After Starting
- `:help <topic>` is pretty useful.
- Check out [this cheatsheet by potatokuka](https://github.com/potatokuka/Intro_to_Vim/blob/0e4c06babe8c8b8443f909bccba1a8d6db9e7961/Vim_Cheatsheet.txt)
  as a reference for common actions you may do.
- In general, search "how to *your question* vim".
- Don't be afraid of `:help vimrc` to change some default behaviors.

## Most simple configuration setup for beginners
minimalist / without plugins

<details>
<summary>
init.lua (Neovim)
</summary>

Create [~/.config/nvim/init.lua](init.lua) folders and files (`:help vimrc` for
all other possible locations) if not created, then add the following lines and
customize these to your hearts content:

```lua
-- this is a comment in lua
--[[
this is a
*multiline*
comment
]]

local o = vim.o -- short for vim.opt; possibly might behave diff in some cases
o.nu = true -- :set number, true or false
o.rnu = true -- relativenumber

-- four spaced tabbing
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.termguicolors = true  -- color support
o.ignorecase = true -- ignores case when searching, etc.
-- below line: cursor is always 6 lines away from top or bottom of your window
o.scrolloff = 6
o.colorcolumn = "80"
o.swapfile = false -- don't use swap files

o.shellslash = true -- On Windows, this will use '/' instead of the default '\'
```

<!-- old example was here -->

Learn more about Neovim + Lua here: `:help lua-guide`. If your neovim is too old, check out [nanotee\/nvim\-lua\-guide\: A guide to using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide). Newest guide online: [Lua\-guide \- Neovim docs](https://neovim.io/doc/user/lua-guide.html#lua-guide)

Lua vs Vimscript:

- Thanks to [LuaJIT](https://github.com/LuaJIT/LuaJIT) (based on Lua 5.1),
this is generally about 10x faster than vimscript8. vimscript9 might be much
closer in speed to LuaJIT. Take benchmarks with a grain of salt though.
- Lua is a skill that can be used outside of Vimscript. Vimscript is stuck in
Vim world. If you go deeper into the language, you probably should learn some
Vimscript and Vim API to use Lua in Neovim though.
- It's worth noting that Neovim is backwards compatible with vimscript8 and not vimscript9.

</details>

<details>
  <summary>init.lua but less minimalist (Neovim)</summary>

  This example has a transparent theme, Telescope, comment.nvim, leader key, and keymaps.
  This will work on Windows, Linux, and likely macOS as well.

```lua
-- Note: Git Bash doesn't work with :term (at least on nvim)

--- Set
local o = vim.o
o.nu = true
o.rnu = true
o.acd = true

-- four spaced tabbing
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.smartindent = true

o.termguicolors = true  -- color support
o.ignorecase = true -- ignores case when searching, etc.
-- below line: cursor is always 6 lines away from top or bottom of your window
o.scrolloff = 6
o.colorcolumn = "80"
o.linebreak = true

-- If you want to change shellslash during fresh install, do it AFTER selecting
-- something in telescope.
-- This is due to a bug with paths in plenary + set shellslash:
-- https://github.com/nvim-telescope/telescope.nvim/issues/2651
o.shellslash = false -- Only affects Windows: This will use '/' instead of the default '\'

--- Keymaps
vim.g.mapleader = ' '

local k = vim.keymap
k.set("n", "<leader>lo", function() vim.cmd("!love %/..") end, {desc="Run with Love2D; assuming that parent is project root folder."})
k.set("n", "<leader>,", function() vim.cmd("bro o") end, {desc=":bro o -> Telescope oldfiles"})
k.set("n", "<leader>cd", "<cmd>cd %:h<CR>", {desc="cd to current file parent (:cd %:h)"})
k.set("n", "<leader>w", "<cmd>w<CR>")
k.set("n", "<leader>t", "<cmd>winc v<CR><cmd>term<CR>")
-- If on Windows this is very useful imo over above command:
-- k.set("n", "<leader>t", "<cmd>winc v<CR><cmd>shell powershell<CR><cmd>term<CR><cmd>shell cmd<CR>")
k.set("t", "<Esc>q", [[<C-\><C-n>]]) -- this line has not been tested. might do nothing.

print("See oldfiles: <leader>,")

-- system clipboard
k.set({ "n", "v" }, "<leader>y", [["+y]])
k.set({ "n", "v" }, "<leader>p", [["+p]])
k.set("n", "<leader>x", [[ggVG"+x]], {desc="(normal mode) Cut all text to clipboard."})
k.set("v", "<leader>x", [["+x]])

-- Don't copy lines below if you don't want plugins.
--- Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy Plugins
local plugins = {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    -- or                          , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      k.del("n", "<leader>,") -- this is backup remap; telescope will break probably
      k.set("n", "<leader>,", function() vim.cmd("Telescope oldfiles") end, {desc=":bro o -> Telescope oldfiles"})
    end
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      vim.cmd.colorscheme("rose-pine")

--      :lua vim.print(vim.api.nvim_get_color_map())
--      :Telescope highlights
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

      -- Makes telescope transparent
      vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  },
  { 'numToStr/Comment.nvim', opts = {} },
}

require("lazy").setup(plugins, {})
-- lua vim.print(vim.api.nvim_get_color_map().Brown)
```
</details>


<details>
<summary>
init.vim (Neovim; Vim; Vi)
</summary>

This is not updated much as I mostly focus on lua script lately.

If this is in `init.vim` file, the equivalent works in Vi, Vim, and Neovim:

```vim
" This is a comment.
" Double quote comment means it's also valid vimrc code; commented out.
" There's no difference between single and multiline comments in vim.

set nu
set relativenumber

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set termguicolors
set colorcolumn=80

set scrolloff=6
set colorcolumn=80
set noswapfile


"" set ai " auto indent
set tabstop

set shellslash
" i forgot if this is important
" set guicursor=""
```
</details>

## Plugin setup

<!--
I paste this link so many times I should be using markdown slightly better..
-->

### General sources

#### Get started with your Neovim config

One might work better for you than others.

- *probably best series* [From 0 to IDE in NEOVIM from scratch \- typescript \- YouTube](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn)
- *good start config* [nvim\-lua\/kickstart\.nvim\: A launch point for your personal nvim configuration](https://github.com/nvim-lua/kickstart.nvim)
- [jmbuhr\/quarto\-nvim\-kickstarter\: A neovim configuration to get you up to speed](https://github.com/jmbuhr/quarto-nvim-kickstarter "This sounds like a promising alternative to kickstart\.nvim\. Haven't tried this though\.")
- [0 to LSP \: Neovim RC From Scratch \- ThePrimeagen \- YouTube](https://youtu.be/w7i4amO_zaE)
- [Effective Neovim\: Instant IDE \- YouTube](https://youtu.be/stqUbv-5u2s&t=171s)
- Install LazyVim to have a good config setup right away. Might be time consuming to remove default mappings / plugins; but it seems like the most configurable neovim distro. NvChad has more features .. less configurable though.

#### More ideas

- [neovim topic on GitHub](https://github.com/topics/neovim)
- [My neovim list](https://github.com/stars/FrostyNick/lists/neovim-vim)

## Neovim Installation

- [Tags (for releases) · neovim\/neovim](https://github.com/neovim/neovim/tags)
#### Windows
- If you have [scoop](https://github.com/ScoopInstaller/Scoop) installed:

##### Stable
```powershell
scoop bucket add main
scoop install main/neovim
```

Run this to get the latest update:
```powershell
scoop update neovim
```

##### Nightly
*Note: You might run into dependency hell if you have both stable and nightly installed.*
```powershell
scoop bucket add versions
scoop install versions/neovim-nightly
```

Run this to get the latest update:
```powershell
scoop update neovim-nightly
```

##### Alternative frontends
[Scoop - Apps (neovim)](https://scoop.sh/#/apps?q=neovim)

#### Ubuntu

Download v0.9.0 AppImage; recommended file format to install neovim. Download link for AppImage: https://github.com/neovim/neovim/releases/download/v0.9.0/nvim.appimage

Then:
```bash
# Make it executable
chmod u+x nvim.appimage && ./nvim.appimage
# ZQ out of that if it executes. If it doesn't work, you probably don't have FUSE. See https://github.com/AppImage/AppImageKit/wiki/FUSE#fallback

# This likely requires sudo. You may want it in `~/.local/bin` instead if that is setup. Otherwise:
mv nvim.appimage /usr/bin

# Now you can run Neovim by typing:
nvim.appimage # you probably want an alias in .bashrc so it's just nvim/nv

# If you plan to use telescope, install ripgrep as shown below.
# If using dict (<leader>zd), add dict to the list:
sudo apt install rg dict
```

#### Termux

You should probably skim and copy over what you want and don't want;
make it for yourself.

```bash
pkg update && pkg upgrade
# Install neovim.
# If using telescope.nvim plugin, install (rg) ripgrep.
# If using dict, install (dictd) dict daemon.
pkg install nvim rg dictd
```

