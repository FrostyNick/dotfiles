--[[
local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = true,
}).setup()

lsp.setup()
--]]


-- require('lsp-zero').preset('recommended').nvim_workspace().setup() -- errors w/ nvim ws
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

