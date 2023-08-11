local l = require('live-server')
l.setup(--[[ args = {"--browser=librewolf"} ]])
vim.g.liveservertoggle = true
vim.keymap.set('n', '<leader>lt', l.start) -- t=true, f=false
vim.keymap.set('n', '<leader>lf', l.stop)
vim.keymap.set('n', '<leader>ll', function()
    if vim.g.liveservertoggle then
        l.start()
    else
        l.stop()
    end
    vim.g.liveservertoggle = not vim.g.liveservertoggle
end)
