## Most simple config setup for beginners
minimalist / without plugins

<details>
<summary>
init.lua (Neovim)
</summary>

Create [~/.config/nvim/init.lua](init.lua) folders and files if not created,
then add the following lines and customize it to your hearts content:

```lua
-- this is a comment in lua
--[[
this is a 
*multiline*
comment

]]
local o = vim.o -- short for vim.opt
o.nu = true -- true or false
o.relativenumber = true

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

Lua vs Vimscript:

- Thanks to [LuaJIT](https://github.com/LuaJIT/LuaJIT) (based on Lua 5.1),
this is generally about 10x faster than vimscript8. vimscript9 might be much
closer in speed to LuaJIT. Take benchmarks with a grain of salt though.
- Lua is a skill that can be used outside of Vimscript. Vimscript is stuck in
Vim world. If you go deeper into the language, you probably should learn some
Vimscript and Vim API to use Lua in Neovim though.
- It's worth noting that Neovim is backwards compatible with vimscript8. (vimscript9 is a work in progress.)

</details>

<details>
<summary>
init.vim (Neovim; Vim; Vi)
</summary>


Didn't test code below! It's possible some of these lines of code don't work.
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

- [0 to LSP \: Neovim RC From Scratch \- YouTube](https://youtu.be/w7i4amO_zaE)
- [Effective Neovim\: Instant IDE \- YouTube](https://youtu.be/stqUbv-5u2s&t=171s)
- Install Nvchad / Astrovim to have a good config setup right away.

#### More ideas

- [neovim topic on GitHub](https://github.com/topics/neovim)
- [My neovim list](https://github.com/stars/FrostyNick/lists/neovim-vim)

### Lazy installation

Everything here is tested with Neovim v0.9.0 and may not work with older
versions. Also this hasn't been tested on other devices yet so instructions
may need improvements.

Note: If migrating from the previously used nvim config using packer.nvim,
check `:checkhealth` and remove files from there.

If any new changes were made: 
`:w`

Likely required first time. If I'm wrong, ignore below:
`:so` then `:Lazy`

No need to source the file again. Lazy is always available with the `:Lazy`
command.

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


