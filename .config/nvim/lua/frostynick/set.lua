-- thicc cursor vim.opt.guicursor = ""
local o = vim.o -- vim.opt == vim.o 
o.nu = true
o.relativenumber = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true

--[[ saves all backups to undotree. might try l8r
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
]]
o.incsearch = true

o.termguicolors = true

o.scrolloff = 8
-- o.signcolumn = "yes"
-- o.isfname:append("@-@")

o.updatetime = 50

o.colorcolumn = "80"
o.ttyfast = true -- will it speed up scrolling?
-- o.swapfile = false

