-- refactored version of https://kulala.mwco.app/docs/requirements#jq 2024-7-18
local k = require('kulala')
local s = vim.keymap.set
local t = { noremap = true, silent = true }
s("n", "<c-k>", function() k.jump_next() end, t)
s("n", "<c-j>", function() k.jump_prev() end, t)
s("n", "<c-l>", function() k.run() end, t)
