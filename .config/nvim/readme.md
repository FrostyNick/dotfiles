## Starting with Vim

If you are completely new to Vim, focus on Vim motions.

- Open Vim and type `:help` to get started. 
- In the future, `:help <topic>` is pretty useful.

## Most simple config setup for beginners
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

<details>
  <summary>Example: Shorter config on Windows 10 with transparent theme, Telescope, comment.nvim, leader key, and keymaps</summary>

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

--            :lua vim.print(vim.api.nvim_get_color_map())
--            :Telescope highlights
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

- *best starting point for learning to make your config in Lua* [nvim\-lua\/kickstart\.nvim\: A launch point for your personal nvim configuration](https://github.com/nvim-lua/kickstart.nvim)
- [jmbuhr\/quarto\-nvim\-kickstarter\: A neovim configuration to get you up to speed](https://github.com/jmbuhr/quarto-nvim-kickstarter "This sounds like a promising alternative to kickstart\.nvim\. Haven't tried this though\.")
- [0 to LSP \: Neovim RC From Scratch \- YouTube](https://youtu.be/w7i4amO_zaE)
- [Effective Neovim\: Instant IDE \- YouTube](https://youtu.be/stqUbv-5u2s&t=171s)
- Install Nvchad / Astrovim to have a good config setup right away. Might be a bit complex to change it to your specific use case though.

#### More ideas

- [neovim topic on GitHub](https://github.com/topics/neovim)
- [My neovim list](https://github.com/stars/FrostyNick/lists/neovim-vim)

## Neovim Installation

[Tags (for releases) · neovim\/neovim](https://github.com/neovim/neovim/tags)

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

## Neovim config installation

```bash
# cd to ~ and clone directory tree
cd && git clone -n --depth=1 --filter=tree:0 https://github.com/FrostyNick/dotfiles.git
# Only download/checkout files from .config/nvim
cd dotfiles/ && git sparse-checkout set --no-cone .config/nvim
git checkout && cd

# Create ~/.config/ if it doesn't already exist
mkdir -p ~/.config
# Create a soft link to nvim directory.
ln -s ~/dotfiles/.config/nvim/ ~/.config/nvim
```

Then:
- Install nerd fonts. See main [readme.md](readme.md) (not neovim readme)
- See `:checkhealth` for any other missing dependencies.

#### Termux

Known issues:
- Codeium doesn't and doesn't plan to support Termux. Search for Termux in codeium issues for more info.
- Treesitter is buggy in Termux. Will investigate.

Incomplete instructions for Treesitter:
`pkg install clang`

You should probably install clang. I have not tested this with treesitter yet.
In theory, you could substitute clang with: `cc` `gcc` `clang` `cl` [`zig`](https://ziglang.org/download/)

### Lazy installation

Everything here is tested with Neovim v0.9.0 - v0.9.4 and may not work with
older versions. 

Note: If migrating from the previously used nvim config using packer.nvim,
check `:checkhealth` and remove files from there.

If any new changes were made: 
`:w`

`:so` likely required first time but I may be wrong.
Then `:Lazy` (or `:La`)

No need to source the file again. Lazy is always available with the `:La`
command.

By design, I didn't enable auto-updating. To update all plugins, type `:La update`, `:Lazy update`, or open up lazy and press <kbd>U</kbd>.

### Lazy config

Restart Neovim and run `:Lazy` to apply new changes.

Read Lazy docs for more info.

### Packer installation (no longer using packer.nvim)

Note: This no longer works! Kept it here for educational purposes.

<details>
<summary>
Packer installation
</summary>
  
In packer.lua:
Install packer with [instructions](https://github.com/wbthomason/packer.nvim)
on the web
([ThePrimeagen video with timestamp](https://youtu.be/w7i4amO_zaE?t=234))

If any new changes are made, you need to `:w` so Packer.nvim can see the
changes.

Then:
`:so`

If errors show up for above command, (`ZQ`) quit out of vim, reopen the
packer.lua file in Neovim and repeat. 

`:PackerSync`

A screen should show up that everything installed successfully.

After all that, close and open and open up again, some errors and tips will
show up. Wait for everything to install.
</details>

### Codeium setup 

Note: If you don't set this up, there will be warnings or errors depending on
your version of Codeium. Remove it (or comment it out) from your plugin config
or set it up.

Create an account on [Codeium](https://codeium.com/) and then type
`:Codeium Auth` to link to your account.

If I missed anything else, create an issue and/or check out:
[Getting Started](https://github.com/Exafunction/codeium.vim#-getting-started)

### Alternative ideas for config

Minimal plugin; works with classic vim too:
[vim-plug](https://github.com/junegunn/vim-plug)

