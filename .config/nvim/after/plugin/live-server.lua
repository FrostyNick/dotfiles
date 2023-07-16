local l = require('live-server')
l.setup(--[[ args = {"--browser=librewolf"} ]])
vim.keymap.set('n', '<leader>lt',
"<cmd>!i3-msg workspace 1:󰖟<CR><cmd>LiveServerStart<CR>") -- t=true, f=false
vim.keymap.set('n', '<leader>lf', l.stop)
