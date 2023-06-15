-- thicc cursor vim.opt.guicursor = ""
-- vim.cmd("set autochdir") same as o.autochdir = true
local o = vim.o -- vim.opt == vim.o 
o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true
o.ignorecase = true

--[[ saves all backups to undotree. might try l8r
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
]]
o.incsearch = true

o.termguicolors = true

o.scrolloff = 6 -- This should be dynamically determined based on how many lines are on the screen. sucks on small screens.
-- o.signcolumn = "yes"
-- o.isfname:append("@-@")

o.updatetime = 50

o.colorcolumn = "80"
o.ttyfast = true -- will it speed up scrolling?
-- o.swapfile = false

o.foldlevelstart = 1 -- 99 = don't close anything, default -1
o.conceallevel = 2 -- for future plugin or idk
