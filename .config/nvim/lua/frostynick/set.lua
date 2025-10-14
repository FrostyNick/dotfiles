-- thicc cursor vim.opt.guicursor = ""
-- :options
-- set nohlsearch
local o = vim.o -- vim.opt == vim.o 
local cmd = vim.cmd
o.nu = true
o.rnu = true

-- cmd("set autochdir") same as o.autochdir = true
-- o.splitbelow = true

-- guess-indent loads on buffer enter, unless manually with ":GuessIndent"
-- commented out below is not needed bc nmac427/guess-indent.nvim plugin.
-- o.tabstop = 4
-- o.softtabstop = 4
-- o.shiftwidth = 4
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

o.scrolloff = 2 -- This should be dynamically determined based on how many lines are on the screen. sucks on small screens.
-- o.signcolumn = "yes"
-- o.isfname:append("@-@")

-- o.sidescrolloff = 8 -- this is useful if you're not autowrapping lines I guess
-- vim.opt.iskeyword:append("-") -- Treat dash as part of word
vim.opt.path:append("**") -- include subdirectories in search (doesn't work with vim.o)

-- vim.opt.nofoldenable = true -- folds are closed by default (THIS CAUSES ERROR IN NVIM)
-- o.foldlevelstart = 99 -- folds stay open when switching buffers supposedly
-- o.foldlevelstart = 1

local a,b = pcall(function()
end)
if not a then
  print("An error occured: " .. tostring(b))
end

-- :mkview :loadview (save/load folds) zf to create fold

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

-- Make <c-x><c-s> work without the underlines
-- Add groups from `:help spell` if other groups reoccur too often.
o.spell = true
-- note these need to be also set in colorscheme config.
cmd.hi("clear", "SpellBad")
cmd.hi("clear", "SpellCap")

-- src: https://github.com/vim/vim/blob/master/runtime/defaults.vim
cmd([[
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

cmd.ca("tan tabe")
-- cmd.ca("|awk", "| awk'{print $}")
-- cmd.ab("ao about")
-- src: https://web.archive.org/web/20230117225946/https://stackoverflow.com/questions/7894330/preserve-last-editing-position-in-vim
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Try when ya got time. Works but could be improved maybe.
-- TODO: Above may be the solution!

--[[ Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})
--]]

-- local mygroup = vim.api.nvim_create_augroup('vimStartup', {clear = true}) -- rm clear?
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   pattern = "*",
--   group = mygroup,
--   command = [[
--   vim.o.au = false -- is this needed?
--   -- still needs to be converted f vimscript. this is psudocode. might break vim. there's probably a better way to do this.
--   local pos = cmd('line("\'\\"")') -- this probably won't work.
--   if pos >= 1 and pos <= cmd('line("$")') and ???? then
--     -- press g`"
--   end
--   ]], 
-- })
