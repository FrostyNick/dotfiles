-- missing: comment shortcut

local k = vim.keymap
vim.g.mapleader = ' '
k.set("v", "J", ":m '>+1<CR>gv=gv")
k.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursors are better
k.set("n", "J", "mzJ`z", { desc = "keeps cursor in same place when doing J"})
k.set("n", "<C-d>", "<C-d>zz")
k.set("n", "<C-u>", "<C-u>zz")
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv") -- greatest remap ever k.set("x", "<leader>p", [["_dP]])

-- system clipboard
k.set({ "n", "v" }, "<leader>y", [["+y]])
k.set("n", "<leader>Y", [["+Y]])

k.set({ "n", "v" }, "<leader>d", [["_d]])

--
k.set("n", "Q", "<nop>")
-- not yet. k.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
k.set("n", "<leader>f", vim.lsp.buf.format)

-- overrided by new harpoon shortcuts
-- k.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- k.set("n", "<C-j>", "<cmd>cprev<CR>zz")
k.set("n", "<leader>k", "<cmd>lnext<CR>zz")
k.set("n", "<leader>j", "<cmd>lprev<CR>zz")

k.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
k.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

k.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/frostynick/lazy.lua<CR>");
k.set("n", "<leader>vpr", "<cmd>e ~/p/Rhythm-Swipe<CR>");
k.set("n", "<leader>vs", function() io.write('noooo <C-wv> instead\nsmh') end);
k.set("n", "<leader>o", function() io.write('noo o --> ,') end);

k.set("n", "<leader>gr",
"<cmd>!xdg-open $(git remote -v | awk '{ print $2 }' | head -n 1 | sed '$s/\\.git//')&<CR>")
k.set("n", "<leader>gf", vim.cmd.Git)
k.set("n", "<leader>gp", "<leader>tgitp") -- if in git repository, open 1st remote url.

k.set("n", "<leader>t", "<C-wv><cmd>term<CR>i")
k.set("n", "<leader>cr", vim.cmd.CompilerOpen) -- compiler run
k.set("n", "<leader>ct", vim.cmd.CompilerToggleResults)
-- k.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");"

k.set("n", "<leader>ws", function()
    vim.cmd("w | so")
end)

local pv
local miniFiles = pcall(function()
    pv = function() vim.cmd("lua MiniFiles.open()") end
end)
if not miniFiles then
    print("MiniFiles plugin not loaded. Using :Vex")
    pv = vim.cmd.Vex
end

k.set("n", "<leader>pv", pv)

--[[ missing lsp stuff
k.set("n", "gd", function()
    vim.lsp.buf.definition()
end) -- missing opts arg, probably wont work
]]
