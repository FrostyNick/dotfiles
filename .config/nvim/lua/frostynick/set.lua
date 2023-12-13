-- thicc cursor vim.opt.guicursor = ""
-- :options
-- set nohlsearch
-- vim.cmd("set autochdir") same as o.autochdir = true
local o = vim.o -- vim.opt == vim.o 
o.nu = true
o.rnu = true

-- o.splitbelow = true

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true -- spaces instead of tabs

o.smartindent = true
o.ignorecase = true

-- looking back at below when I didn't understand it: Not having a backup or swapfile seems like a bad idea imo just in case like power goes out.. you have less info.
--[[ saves all backups to undotree. might try l8r
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true
]]
o.backup = false
o.incsearch = true

o.termguicolors = true -- full color support

o.scrolloff = 6 -- This should be dynamically determined based on how many lines are on the screen. sucks on small screens.
-- o.signcolumn = "yes"
-- o.isfname:append("@-@")

o.updatetime = 50
o.timeoutlen = 300 -- timeout for key strokes

o.colorcolumn = "80"
-- o.swapfile = false
-- vim.o.clipboard = 'unnamedplus' -- use system clipboard

o.foldlevelstart = 1 -- 99 = don't close anything, default -1
o.conceallevel = 2 -- for future plugin or idk

o.acd = true -- autochdir changes directory whenever you open something.
o.hid = true -- rm annoying buffer error message https://linuxhandbook.com/vim-buffers/
-- o.linebreak = true

-- Speed up diff:
vim.g.diff_translations = 0

o.virtualedit = "block"
o.inccommand = "split"

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

-- local mygroup = vim.api.nvim_create_augroup('vimStartup', {clear = true}) -- rm clear?
-- vim.api.nvim_create_autocmd("BufReadPost", {
--     pattern = "*",
--     group = mygroup,
--     command = [[
--     vim.o.au = false -- is this needed?
--     -- still needs to be converted f vimscript. this is psudocode. might break vim. there's probably a better way to do this.
--     local pos = vim.cmd('line("\'\\"")') -- this probably won't work.
--     if pos >= 1 and pos <= vim.cmd(vim.cmd('line("$")')) and ???? then
--         -- press g`"
--     end
--     ]], 
-- })
