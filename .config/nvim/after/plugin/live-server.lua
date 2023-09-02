local l = require('live-server')
l.setup(--[[ args = {"--browser=librewolf"} ]])
vim.g.liveservertoggle = true
vim.keymap.set('n', '<leader>lf', function()
    vim.g.liveservertoggle = true
    l.start()
end)
vim.keymap.set('n', '<leader>lt', function()
    vim.g.liveservertoggle = false
    l.stop()
end)

vim.keymap.set('n', '<leader>ll', function()
    if vim.g.liveservertoggle then
        l.start()
    else
        l.stop()
    end
    vim.g.liveservertoggle = not vim.g.liveservertoggle
end)
