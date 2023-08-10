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

-- Diagnostic shortcuts
local function kLsp(map, todo, desc)
    -- desc = desc or map
    k.set("n", map, todo, {buffer=0, desc="LSP: "..desc or map})
end
kLsp("<leader>dk", vim.diagnostic.goto_prev, "prev diagnostic")
kLsp("<leader>dj", vim.diagnostic.goto_next, "next diagnostic")
kLsp("<leader>dl", "<cmd>Telescope disagnostics<CR>", "Telescope diagnostics")

-- LSP shortcuts
-- k.set("n", "<leader>f", vim.lsp.buf.format)
-- k.set("n", "K", vim.lsp.buf.format, {buffer=0})
kLsp("gt", vim.lsp.buf.type_definition, "type definition")
kLsp("gr", vim.lsp.buf.rename, "rename")
kLsp("gca", vim.lsp.buf.code_action, "code action")


-- k.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
-- k.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
-- k.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
-- k.set("n", "<leader>dl", "<cmd>Telescope disagnostics<CR>", {buffer=0})

-- k.set("n", "<leader>dl", "<cmd>Telescope lsp_references<CR>", {buffer=0})
-- rename not found in js.. fix later
-- also C-q to move diagnostics to quickfix ls

-- overrided by new harpoon shortcuts
-- k.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- k.set("n", "<C-j>", "<cmd>cprev<CR>zz")
k.set("n", "<leader>k", "<cmd>lnext<CR>zz")
k.set("n", "<leader>j", "<cmd>lprev<CR>zz")

k.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
k.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

k.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/frostynick/lazy.lua<CR>");
k.set("n", "<leader>vpr", "<cmd>e ~/p/Rhythm-Swipe<CR>");
k.set("n", "<leader>vs", function() io.write('noooo <C-wv> instead\nsmh') end);

-- Git shortcuts
k.set("n", "<leader>gr",
"<cmd>!xdg-open $(git remote -v | awk '{ print $2 }' | head -n 1 | sed '$s/\\.git//')&<CR><CR>", { silent = true })
k.set("n", "<leader>gf", vim.cmd.Git)
k.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<CR>")
k.set("n", "<leader>gp", "<C-w>v<cmd>term<CR>igitp") -- if in git repository, open 1st remote url.
k.set("n", "<leader>m", "<C-w>v<cmd>term<CR>igitp") -- if in git repository, open 1st remote url.

-- xdg-open miscellaneous
k.set("n", "<leader>o",
"<cmd>!xdg-open .&<CR><CR>", { silent = true, desc = "Open working dir" })
k.set("n", "<leader>p5",
"<cmd>!xdg-open ~/p/p5-reference/index.html<CR><CR>", { silent = true })

-- Terminal shortcuts
k.set("n", "<leader>t", "<C-w>v<cmd>term<CR>i")
k.set("n", "<leader>cr", vim.cmd.CompilerOpen) -- compiler run
k.set("n", "<leader>ct", vim.cmd.CompilerToggleResults)
-- k.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");"

-- Vim shortcuts
k.set("n", "<leader>ws", function()
    vim.cmd("w | so")
end)
-- k.set("n", "<leader>pv", vim.cmd.Ex)
k.set("n", "<leader>pv", function()
    local path = vim.b.netrw_curdir
    require("oil").open(path)
end, { desc = "open+fix oil+netrw", buffer = true })

-- Markdown shortcuts
k.set("n", "<leader>mm", "<cmd>MarkdownPreviewToggle<CR>")
k.set("n", "<leader>mt", "<cmd>TableModeToggle<CR>")
