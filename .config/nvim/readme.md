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

`:so`

If errors show up for above command, (`ZQ`) quit out of vim, reopen the
packer.lua file in Neovim and repeat. 

`:PackerSync`

A screen should show up that everything installed successfully. If not, try
checking out ThePrimeagen video or hit me up.

After all that, close and open and open up again, some errors and tips will
show up. Wait for everything to install. After that, you're ready!

### Future

[Lazy.nvim](https://github.com/folke/lazy.nvim) is tempting over Packer.nvim
... it's faster thanks to lazy loading and from what I have heard it might be
easier to start with too.


