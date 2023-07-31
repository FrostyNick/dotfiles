local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local k = vim.keymap

k.set("n", "<leader>a", mark.add_file)
k.set("n", "<C-p>", ui.toggle_quick_menu) -- C-o overrides jumping in vim and C-e sucks in termux (scroll down action)

-- dvorak local keys = {"h", "t", "n", "s", "leader"}
local keys = {"h", "j", "k", "l"}
for i, key in ipairs(keys) do
    k.set("n", "<C-"..key..">", function() ui.nav_file(i) end)
end
