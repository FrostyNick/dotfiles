
local k = vim.keymap
vim.g.mapleader = ' '
k.set("v", "J", ":m '>+1<CR>gv=gv")
k.set("v", "K", ":m '<-2<CR>gv=gv")

--- cursors are better
k.set("n", "J", "mzJ`z", { desc = "keeps cursor in same place when doing J"})
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv") -- greatest remap ever k.set("x", "<leader>p", [["_dP]])

--- system clipboard
k.set({ "n", "v" }, "<leader>y", [["+y]])
k.set("n", "<leader>Y", [["+Y]])
k.set({ "n", "v" }, "<leader>p", [["+p]])
k.set("n", "<leader>P", [["+P]])

k.set({ "n", "v" }, "<leader>d", [["_d]])

--
k.set("n", "Q", "<nop>")
k.set("n", "<leader>cd", "<cmd>cd %:h<CR>", {desc="cd to current file parent (:cd %:h)"})
k.set('n', '<leader>,', "<cmd>bro o<CR>", { desc="(fallback to Telescope): old files" })

k.set("n", "<leader>dk", vim.diagnostic.goto_prev, {desc="LSP: prev diagnostic"})
k.set("n", "<leader>dj", vim.diagnostic.goto_next, {desc="LSP: next diagnostic"})

-- Keep clipboard contents after pasting with p in visual mode.
-- Thanks to: https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua#L52C1-L52C31
k.set("v", "p", '"_dP')

-- v conflicts with gcc
-- kLsp("gca", vim.lsp.buf.code_action, "code action")
k.set("n", "gt", vim.lsp.buf.type_definition, {desc="LSP: type definition"})
k.set("n", "gr", vim.lsp.buf.rename, {desc="LSP: rename"})
-- ga overrides vim keybind which could be useful in the future
k.set("n", "gA", vim.lsp.buf.code_action, {desc="LSP: code action"})
k.set("n", "gf", "<cmd>e <cfile><CR>", {desc="gf but also create file if it doesn't exist."})

-- yank/put: " + macro + y/p
-- useless macro: isusu�kb
-- macro: cwk,�kb.setwa"n", $2F'2F"$2F"i{desc=$i}


-- overrided by new harpoon shortcuts
-- k.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- k.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- I don't use this. Maybe if I learn how to use this it would be useful.
-- k.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- k.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- <leader>zo moved to lazy.lua
k.set("n", "<leader>gv", [[:Gvdiffsplit]], {desc="Gvdiffsplit - fill in: git vertical split"})
-- k.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
k.set("t", "<C-h>", "<C-\\><C-N><cmd>sleep! 100m<CR><C-w>h")
k.set("n", "<leader>zd", [[:!dict <C-r><C-w><CR>g]], {silent = true, desc="Get word definition from word that's on your cursor (requires dict to be installed and configured correctly)"})
k.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
k.set("n", "<leader>myt", [[:%s#www.youtube.com/watch?v=#youtu.be/#gI<CR>]], {desc="Shorten YouTube URLs"})
k.set("n", "<leader>dt", [[:diffthis<CR><C-w><C-w>:diffthis<CR><C-w><C-p>]])
-- * does the same thing k.set("n", "<leader>/", "/<C-r><C-w><CR>")
k.set("n", "<leader>x", [[GVgg"+x]], { silent = true }) -- cuts all text to clipboard
k.set("n", "<leader>mr", [[:put =range(1,)<Left>]], { desc="Insert text: math range" })
k.set("n", "<leader>cm", "<cmd>!chmod +x %<CR>", { silent = true })

k.set("n", "<leader>vpp",
"<cmd>e " .. vim.fn.stdpath('config') .. "/lua/frostynick/lazy.lua<CR>");

k.set("n", "<leader>vpr", "<cmd>e ~/p/Rhythm-Swipe<CR>");
k.set("n", "<leader>vps", "<cmd>e ~/backup2022nov10/j/Sources/App_web sources.md<CR>");
-- below doesnt work because i is powerful af. fix later.
k.set("n", "<leader>vpi", "<cmd>e ~/backup2022nov10/markor/ideas.md<CR>");


-- local leader = ' '
-- I cannot get below to work. Above is the best solution I could make.
-- vim.api.nvim_set_keymap('n', ' <Space>vpv', [[:nmap  <Space>vp<CR>]], { noremap = true, silent = true })
-- k.set("n", "<leader>vpv", "<cmd>nmap " .. space .. "vp<CR>");
-- k.set("n", "<leader>vpv", [[:execute 'nmap ' .. mapleader .. 'vp' | echomsg ''<CR>]]);
-- k.set("n", "<leader>vpv", [[:echo 'nmap <leader>vp'<CR>]]);
k.set("n", "<leader>ia", "<cmd>e ~/backup2022nov10/markor/ideas.md<CR>");

--- xdg-open miscellaneous
-- Future: If using Windows or MacOS, alias different open command
-- norg only loads in .norg file; setup in Lazy. Result: about -11ms startup but it sometimes takes really long to load (50ms) when it loads for some reason. I might be a bit off though haven't tested it much.
k.set("n", "<leader>n", "<cmd>e ~/backup2022nov10/notes/index.norg<CR>")
k.set("n", "<leader>po", -- project open
"<cmd>!xdg-open . &<CR><CR>", { silent = true, desc = "xdg-open directory" })
-- For windows, replace xdg-open with explorer.

k.set("n", "<leader>o",
"<cmd>!xdg-open % & | open % | explorer %<CR><CR>",
{ silent = true, desc = "xdg-open file" })

k.set("n", "<leader>q", "<cmd>bd<CR>", {desc=":bd Delete buffer"})

--- Git shortcuts
k.set("n", "<leader>gr", -- rare edge-case: breaks when git exists earlier I think
"<cmd>!xdg-open $(git remote -v | awk '{ print $2 }' | head -n 1 | sed '$s/\\.git//')&<CR><CR>",
{ silent = true })

k.set("n", "<leader>gg", vim.cmd.Git)
k.set("n", "<leader>gl", "<cmd>Git log --oneline --decorate --graph --all<CR>")
k.set("n", "<leader>gd", "<cmd>Git diff<CR>")
k.set("n", "<leader>gp", "<C-w>v<cmd>term<CR>igitp") -- if in git repository, open 1st remote url.
-- Above should use git fugitive ... I just have a terminal dependant password inserting thing that makes git fugitive not work well. (:G push)

--- Run prgm
k.set("n", "<leader>lo", function() vim.cmd("!love %:h") end, {desc="Run with Love2D; assuming that parent is project root folder."})
k.set("n", "<leader>p5",
"<cmd>!xdg-open ~/p/p5-reference/index.html || xdg-open https://p5js.org/reference/ || open https://p5js.org/reference/<CR><CR>",
{ silent = false }) -- "open" not tested yet on Windows / MacOS.

---- Markdown shortcuts
k.set("n", "<leader>mm", "<cmd>MarkdownPreviewToggle<CR>")
k.set("n", "<leader>mt", "<cmd>TableModeToggle<CR>")

---- Compiler shortcuts
-- Replace later with vim autogroup to an extent maybe.
k.set("n", "<leader>r", function() print"code: run general code soon. also try <leader>co. self-note: see tj tutorial" end)
k.set("n", "<leader>dc", function() print"code: run docs soon. (see tj tutorial)" end)
-- ^ goals: support lua; py; live-server/js; p5.js; binaries for crablang + c-based-langs

k.set("n", "<leader>cr", vim.cmd.CompilerOpen) -- compiler run
k.set("n", "<leader>ct", vim.cmd.CompilerToggleResults)

-- k.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");"
-- <leader>cx is in lazy.lua if it still exists

--- Vim shortcuts
k.set("n", "<leader>t", "<C-w>v<cmd>term<CR>")
k.set("n", "<leader>w", [[:w<CR>]])
k.set("n", "<leader>e", [[GVgg"+x<cmd>e ~/backup2022nov10/j/Backup/sessions-watch l8r 2024.md<CR>gg}ma"+p2o<Esc>`a3O<Esc><cmd>.!date +\%F<CR>]])

--[[ above todo:
- Doesn't delete empty buffer. Avoid :bd!
- IP: Use marks instead of paragraph jumps. Otherwise date will be inserted incorrectly. Or changelist?
- Because of above, new lines don't work.
- This won't work outside of Linux because of date command. Might consider lua os.date() instead. Pros: Cross-platform; might be faster. Cons: Only neovim.
- g`"
--]]

k.set("n", "<leader>pv", vim.cmd.Ex)

-- if vim.g.vscode then
-- --[[ Original:
-- xmap gc  <Plug>VSCodeCommentary
-- nmap gc  <Plug>VSCodeCommentary
-- omap gc  <Plug>VSCodeCommentary
-- nmap gcc <Plug>VSCodeCommentaryLine
-- --]]
--
-- -- The alternative provided in the docs works worse from my experience :/
--
--     -- k.del({"x", "n", "o"}, "gc")
--     -- k.del("n", "gcc")
--
--     -- k.set({"x", "n", "o"}, "gc", "<Plug>(VSCodeCommentary)")
--     -- k.set("n", "gcc", "<Plug>(VSCodeCommentaryLine)")
-- end

--- not keyboard shortcut
vim.api.nvim_create_user_command("Godot", function() -- Runs on :Godot
    vim.cmd("!godot project.godot")
end, {})
k.set("n", "<leader>go", vim.cmd.Godot)

-- l8r: make it like an API that can be accessed anywhere
local function i_txt(txt)
    vim.cmd("norm O")

    -- :help nvim_buf_set_text
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { txt })
end

local function i_date()
    i_txt( os.date("%x"):gsub(
        -- To learn more: https://www.lua.org/pil/20.2.html
        -- Update: the docs don't show Linux output correctly ... bruh
        -- [that's why this commit blame exists here]
        -- Anyway, it works on Windows and Linux (with a bonus zero).
        '(%d+)/(%d+)/(%d+)','%3-%1-%2'))
end

vim.api.nvim_create_user_command("Date", i_date, {})
k.set("n", "<leader>da", i_date, {desc="Insert date"})

-- https://youtu.be/9gUatBHuXE0
-- Autorun on save. Useful but not in this case. Useful example: .md -> .html
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("Codeee", { clear = true }),
--     pattern = "project.godot",
--     callback = function()
--         vim.cmd("!godot project.godot")
--     end,
-- })

