-- missing: comment shortcut

local k = vim.keymap
local telescopeBi = require("telescope.builtin")
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
local function kLsp(map, action, desc)
    -- desc = desc or map
    k.set("n", map, action, {buffer=0, desc="LSP: "..desc or map})
end
-- Stopped working:
-- kLsp("<leader>dk", vim.diagnostic.goto_prev, "prev diagnostic")
-- kLsp("<leader>dj", vim.diagnostic.goto_next, "next diagnostic")
-- kLsp("<leader>dl", telescopeBi.diagnostics, "Telescope diagnostics")

k.set("n", "<leader>dk", vim.diagnostic.goto_prev, {desc="prev diagnostic"})
k.set("n", "<leader>dj", vim.diagnostic.goto_next, {desc="next diagnostic"})
k.set("n", "<leader>dl", telescopeBi.diagnostics, {desc="Telescope diagnostics"})

-- LSP shortcuts
-- k.set("n", "<leader>f", vim.lsp.buf.format)
-- k.set("n", "K", vim.lsp.buf.format, {buffer=0})

-- Stopped working:
-- kLsp("gt", vim.lsp.buf.type_definition, "type definition")
-- kLsp("gr", vim.lsp.buf.rename, "rename")
-- v conflicts with gcc
-- kLsp("gca", vim.lsp.buf.code_action, "code action")
k.set("n", "gt", vim.lsp.buf.type_definition, {desc="type definition"})
k.set("n", "gr", vim.lsp.buf.rename, {desc="rename"})
k.set("n", "ga", vim.lsp.buf.code_action, {desc="code action"})

-- yank/put: " + macro + y/p
-- useless macro: isusu€kb
-- macro: cwk,€kb.setwa"n", $2F'2F"$2F"i{desc=$i}


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
-- * does the same thing k.set("n", "<leader>/", "/<C-r><C-w><CR>")
k.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- doing this again should do the opposite
k.set("n", "<leader>vs", function() io.write('noooo <C-wv> instead\nsmh') end);

k.set("n", "<leader>vpp",
"<cmd>e " .. vim.fn.stdpath('config') .. "/lua/frostynick/lazy.lua<CR>");
k.set("n", "<leader>vpr", "<cmd>e ~/p/Rhythm-Swipe<CR>");
-- below doesnt work because i is powerful af. fix later.
k.set("n", "<leader>vpi", "<cmd>e ~/backup2022nov10/markor/ideas.md<CR>");
k.set("n", "<leader>ia", "<cmd>e ~/backup2022nov10/markor/ideas.md || echo fail<CR>");

-- xdg-open miscellaneous
-- Future: If using Windows or MacOS, alias different open command
-- norg only loads in .norg file; setup in Lazy. Result: about -11ms startup
k.set("n", "<leader>n", "<cmd>e ~/backup2022nov10/notes/index.norg<CR>")
k.set("n", "<leader>o",
"<cmd>!xdg-open .&<CR><CR>", { silent = true, desc = "Open working dir" })
k.set("n", "<leader>p5",
"<cmd>!xdg-open ~/p/p5-reference/index.html || xdg-open https://p5js.org/reference/ || open https://p5js.org/reference/<CR><CR>",
{ silent = false }) -- "open" not tested yet on Windows / MacOS.

-- Git shortcuts
k.set("n", "<leader>gr", -- rare edge-case: breaks when git exists earlier I think
"<cmd>!xdg-open $(git remote -v | awk '{ print $2 }' | head -n 1 | sed '$s/\\.git//')&<CR><CR>",
{ silent = true })
k.set("n", "<leader>gf", vim.cmd.Git)
k.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<CR>")
k.set("n", "<leader>gd", "<cmd>Git diff<CR>")
k.set("n", "<leader>gp", "<C-w>v<cmd>term<CR>igitp") -- if in git repository, open 1st remote url.

-- Compiler shortcuts
k.set("n", "<leader>t", "<C-w>v<cmd>term<CR>")
k.set("n", "<leader>cr", vim.cmd.CompilerOpen) -- compiler run
k.set("n", "<leader>ct", vim.cmd.CompilerToggleResults)
-- k.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");"
-- <leader>cx is in lazy.lua if it still exists

-- Vim shortcuts
k.set("n", "<leader>ws", function()
    vim.cmd("w | so")
end)
-- k.set("n", "<leader>pv", vim.cmd.Ex)
k.set("n", "<leader>pv", vim.cmd.Ex); -- function()

-- Markdown shortcuts
k.set("n", "<leader>mm", "<cmd>MarkdownPreviewToggle<CR>")
k.set("n", "<leader>mt", "<cmd>TableModeToggle<CR>")
