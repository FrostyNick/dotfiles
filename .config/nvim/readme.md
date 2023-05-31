There might be a few missing details.
[This video](https://youtu.be/w7i4amO_zaE)
probably fills in all the details you might run into.
<!--
I paste this link so many times I should be using markdown slightly better..
-->

### General sources to get started with your Neovim config

One might work better for you than others.

- Install Nvchad / Astrovim to have a good config setup right away.
- [0 to LSP \: Neovim RC From Scratch \- YouTube](https://youtu.be/w7i4amO_zaE)
- [Effective Neovim\: Instant IDE \- YouTube](https://youtu.be/stqUbv-5u2s&t=171s)

### Installation

In packer.lua:
Install packer with [instructions](https://github.com/wbthomason/packer.nvim)
on the web
([ThePrimeagen video with timestamp](https://youtu.be/w7i4amO_zaE?t=234))

If any new changes are made, you need to `:w` so Packer.nvim can see the changes.

Then:
`:so`

If errors show up for above command, (`ZQ`) quit out of vim, reopen the
packer.lua file in Neovim and repeat. 

`:PackerSync`

A screen should show up that everything installed successfully.

After all that, close and open and open up again, some errors and tips will show up. Wait for everything to install.

### Codium setup 

Note: If you don't set this up, there will be warnings or errors. Remove it (or comment it out) from packer.nvim or set it up.

[Getting Started](https://github.com/Exafunction/codeium.vim#-getting-started)

### Future

[Lazy.nvim](https://github.com/folke/lazy.nvim) is tempting over Packer.nvim

#### Why?
- Packer.nvim hasn't been updated for a while. Also [Is this project dead? \#1229: packer.nvim](https://github.com/wbthomason/packer.nvim/issues/1229)
- It's faster thanks to lazy loading.
- Hot loading also automates the compilation; no `:LazyVimSync` in sight.
- From what I have heard it might be easier to start with too.


