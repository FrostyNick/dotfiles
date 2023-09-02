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
o.backup = false
o.incsearch = true

o.termguicolors = true

o.scrolloff = 6 -- This should be dynamically determined based on how many lines are on the screen. sucks on small screens.
-- o.signcolumn = "yes"
-- o.isfname:append("@-@")

o.updatetime = 50
o.timeoutlen = 300 -- timeout for key strokes

o.colorcolumn = "80"
o.ttyfast = true -- will it speed up scrolling?
-- o.swapfile = false
-- vim.o.clipboard = 'unnamedplus' -- use system clipboard

o.foldlevelstart = 1 -- 99 = don't close anything, default -1
o.conceallevel = 2 -- for future plugin or idk

o.hidden = true -- rm annoying buffer error message https://linuxhandbook.com/vim-buffers/

-- Taken from: https://github.com/vim/vim/blob/master/runtime/defaults.vim
vim.cmd([[
" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | exe 'au!' | augroup END"
augroup vimStartup
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END
]])
