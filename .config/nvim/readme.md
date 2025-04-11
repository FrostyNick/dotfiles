## Starting with Vim/Neovim

If you're stuck you may want to check out:
gettingStarted.md


## This Neovim config installation

> [!IMPORTANT]  
> Recommended:
> - `v0.9.4` minimum recommended due to snacks.nvim -- if you manually decide to remove and modify plugins, then v0.9.0 is recommended minimum instead. See commit in this repo when snacks.nvim was added: 08cbe5c79d7a73e00428bf63454bcafcbd68fffe)
> - `latest stable version` - for non-essential plugins which are assigned with a note in <leader>? if there's keybinds with it
> - Not recommended minimum: `v0.8.0` (there may be some errors, but it should be usable)


```bash
# clone directory tree
git clone -n --depth=1 --filter=tree:0 https://github.com/FrostyNick/dotfiles.git
# Only download/checkout files from .config/nvim
cd dotfiles/ && git sparse-checkout set --no-cone .config/nvim
git checkout && cd ..

# if you want to use github.com/FrostyNick/fgit, you can replace above steps with:
fgit https://github.com/FrostyNick/dotfiles .config/nvim
cd ../..

# Create ~/.config/ if it doesn't already exist
mkdir -p ~/.config
# Create a soft link to nvim directory.
ln -s $(pwd)/dotfiles/.config/nvim/ ~/.config/nvim
```

Then:
- Install nerd fonts. See main [readme.md](../../readme.md) (not neovim readme)
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

Warning: `codeium.vim` is not supported in Termux and I haven't gotten it to
work. There might have a workaround though. See issue 8 from
[here](https://github.com/Exafunction/codeium.vim/issues?q=is%3Aissue+termux+is%3Aclosed).
Haven't tested `codeium.nvim` on Termux yet.
<!-- GitHub will send a notification to everyone in that issue
if I directly paste the issue here 🙁 -->

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

