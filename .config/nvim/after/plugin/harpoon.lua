local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-p>", ui.toggle_quick_menu) -- C-o overrides jumping in vim and C-e sucks in termux (scroll down action)

-- dvorak local keys = {"<C-h>", "<C-t>", "<C-n>", "<C-s>", "<C-leader>"}
local keys = {"<C-h>", "<C-j>", "<C-k>", "<C-l>"}
for i, key in ipairs(keys) do
    vim.keymap.set("n", key, function() ui.nav_file(i) end)
end
