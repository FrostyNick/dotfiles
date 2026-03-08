vim.opt.shada = "!,%5,'200,f1,<50,s10,h" -- 200 oldfiles now. :help 'shada' :help 'v:ol'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("frostynick.set")
require("frostynick.lazy")
require("frostynick.remap")
vim.notify("Check todo and pomodoro (cmd)")
