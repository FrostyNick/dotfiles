local l = require('live-server')
l.setup(--[[ args = {"--browser=librewolf"} ]])
vim.keymap.set('n', '<leader>lt', l.start) -- t=true, f=false
vim.keymap.set('n', '<leader>lf', l.stop)
