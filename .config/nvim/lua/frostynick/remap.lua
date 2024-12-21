local uv = vim.uv or vim.loop -- :help luvref.txt
local k = vim.keymap
local c = vim.cmd

vim.g.mapleader = ' '
vim.g.treesitterOn = true
k.set("v", "J", ":m '>+1<CR>gv=gv")
k.set("v", "K", ":m '<-2<CR>gv=gv")

--- cursors are opinionated
k.set("n", "J", "mzJ`z", { desc = "keeps cursor in same place when doing J"})
k.set("n", "n", "nzzzv")
k.set("n", "N", "Nzzzv")
k.set("n", "~", "~h")

--- system clipboard
k.set({ "n", "v" }, "<leader>y", [["+y]])
k.set("n", "<leader>Y", [["+Y]])
k.set({ "n", "v" }, "<leader>pp", [["+p]])
k.set("n", "<leader>P", [["+P]])

k.set({ "n", "v" }, "<leader>d", [["_d]])

--
k.set("n", "Q", "<nop>")

k.set("n", "<leader>cwd", function() vim.notify(uv.cwd()) end)
k.set('n', '<leader>,', "<cmd>bro o<CR>", { desc="(fallback to Telescope): old files" })

-- k.set("n", "<leader>dk", function() vim.diagnostic.jump({count=1, float=true}) end, {desc="LSP: prev diagnostic"})
k.set("n", "<leader>dk", vim.diagnostic.goto_prev, {desc="LSP: prev diagnostic"}) -- WARNING: Deprecated in nvim 0.11 probably / nightly (2024-10-16)
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
-- useless macro: isusu€kb
-- macro: cwk,€kb.setwa"n", $2F'2F"$2F"i{desc=$i}


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
k.set("t", "<Esc>q", "<c-\\><c-n>")

k.set("n", "<leader>zd", [[:!dict <C-r><C-w><CR>g]], {silent = true, desc="Get word definition from word that's on your cursor (requires dict to be installed and configured correctly)"})
k.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
--- I should make a different mode at this point...
-- *insert removing end of yt links*
k.set("n", "<leader>myts", [[:%s#www.youtube.com/shorts/#youtu.be/#gI<CR>]], {desc="Shorten YouTube short URLs"})
k.set("n", "<leader>mytv", [[:%s#www.youtube.com/watch?v=#youtu.be/#gI<CR>]], {desc="Shorten YouTube URLs"})
---- below is work in progress
-- k.set("n", "<leader>mk", ":norm blysiW]f]a()<CR>", {desc="Markdown lin[k] (requires nvim-surround)"})
-- k.set("n", "<leader>mw", ":norm blysiW]f]a()<CR>2hT[", {desc="Markdown link [w]ord (requires nvim-surround)"})

k.set("n", "<leader>dt", [[:diffthis<CR><C-w><C-w>:diffthis<CR><C-w><C-p>]])
-- * does the same thing k.set("n", "<leader>/", "/<C-r><C-w><CR>")
k.set("n", "<leader>x", [[GVgg"+x]], { silent = true }) -- cuts all text to clipboard
k.set("n", "<leader>mr", [[:put =range(1,)<Left>]], { desc="Insert text: math range" })
k.set("n", "<leader>cm", "<cmd>!chmod +x %<CR>", { silent = true })
k.set("n", "<leader>cs", "<cmd>!chmod +x %<CR>", { silent = true })
-- k.set("n", "<leader>mb", [[}kI- ]], { desc="Markdown bullet points" }) -- does nothing cuz (macro != keymap function)
k.set("n", "<leader>me", function()
    c.tabe(); vim.opt.filetype = 'markdown' end)

k.set("n", "<leader>vpc",
"<cmd>e " .. vim.fn.stdpath('config') .. "/lua/frostynick/lazy.lua<CR>");

k.set('n', '<leader>vpp',
'<cmd>Telescope find_files hidden=true search_dirs=$HOME/p/<CR>',
{desc="Telescope: find code in projects directory"})

k.set('n', '<leader>vp2p',
'<cmd>Telescope find_files hidden=true search_dirs=$HOME/backup*/p/<CR>',
{desc="Telescope: find code in projects directory"})

k.set('n', '<leader>vpb',
'<cmd>Telescope find_files hidden=true search_dirs=$HOME/backup*/<CR>',
{desc="Telescope: find code in backup directory"})

-- below doesnt work because i is powerful af. fix later.
k.set("n", "<leader>vpi", "<cmd>tabe ~/backup2022nov*/markor/ideas.md<CR>")
k.set("n", "<leader>vpt", "<cmd>tabe ~/backup2022nov*/markor/todo.md<CR>")
k.set("n", "<leader>vpg", function()
    c.tabe("~/backup2022nov*/markor/gfl.md")
    vim.notify("<leader>g{o,p} also make new branch")
end);


-- local leader = ' '
-- I cannot get below to work. Above is the best solution I could make.
-- vim.api.nvim_set_keymap('n', ' <Space>vpv', [[:nmap  <Space>vp<CR>]], { noremap = true, silent = true })
-- k.set("n", "<leader>vpv", "<cmd>nmap " .. space .. "vp<CR>");
-- k.set("n", "<leader>vpv", [[:execute 'nmap ' .. mapleader .. 'vp' | echomsg ''<CR>]]);
-- k.set("n", "<leader>vpv", [[:echo 'nmap <leader>vp'<CR>]]);
k.set("n", "<leader>ia", "<cmd>e ~/backup2022nov*/markor/ideas.md<CR>");

--- xdg-open miscellaneous
-- Future: If using Windows or MacOS, alias different open command
-- norg only loads in .norg file; setup in Lazy. Result: about -11ms startup but it sometimes takes really long to load (50ms) when it loads for some reason. I might be a bit off though haven't tested it much.
k.set("n", "<leader>o", -- project open
"<cmd>!xdg-open . &<CR><CR>", { silent = true, desc = "xdg-open directory" })
k.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true }) -- cuts all text to clipboard

-- "explorer" is for Windows. Probably broken; needs Git Bash for pipes to work.
k.set("n", "<leader>po",
"<cmd>!xdg-open % & | open % | explorer %<CR><CR>",
{ silent = true, desc = "xdg-open file" })

--- Git shortcuts
k.set("n", "<leader>ghs",
"<cmd>!gh status<CR>",
{ silent = true, desc = "github status (requires gh / github-cli)" })
k.set("n", "<leader>gho",
"<cmd>Octo<CR>",
{ silent = true, desc = "octo list (requires gh)" })

k.set("n", "<leader>gg", c.Git)
k.set("n", "<leader>gl", "<cmd>Git log --oneline --pretty=reference --date=relative --decorate --graph --all<CR>") -- date=relative can be date=iso (yyyy-mm-dd hh:mm:ss -n) See git log --help /date=rel
k.set("n", "<leader>gd", "<cmd>Git diff<CR>")
k.set("n", "<leader>gp", function()
    c.vs()
    c.term()

    local keys -- changes based on if ":Vterm" exists from termim plugin
    if vim.fn.exists(":Vterm") == 2 then
        keys = "gitp"
    else
        keys = "igitp"
    end

    vim.api.nvim_feedkeys(keys, "n", false)
    -- WARNING: If termim is removed, below should be "igitp"
    -- c("<C-w>v<cmd>term<CR>igitp")
end)

-- if in git repository, open 1st remote url.
-- Above should use git fugitive ... I just have a terminal dependant password inserting thing that makes git fugitive not work well. (:G push)

--- Run prgm
k.set("n", "<leader>lo", function() c("!love %:h") end, {desc="Run with Love2D; assuming that parent is project root folder."})
k.set("n", "<leader>p5",
"<cmd>!xdg-open ~/p/p5-reference/index.html || xdg-open https://p5js.org/reference/ || open https://p5js.org/reference/<CR><CR>",
{ silent = false }) -- "open" not tested yet on Windows / MacOS.

---- Markdown shortcuts
k.set("n", "<leader>mm", c.MarkdownPreviewToggle)
k.set("n", "<leader>mt", function()
    vim.g.treesitterOn = not vim.g.treesitterOn
    c.TableModeToggle()
    if vim.g.treesitterOn then
        vim.treesitter.start()
    else
        vim.treesitter.stop()
    end
end)

---- Compiler shortcuts
-- Replace later with vim autogroup to an extent maybe.
k.set("n", "<leader>r", c.RunCode)
-- k.set("n", "<leader>???", function() vim.notify"code: run docs soon. (see tj tutorial)" end)
-- ^ goals: support lua; py; live-server/js; p5.js; binaries for crablang + c-based-langs

k.set("n", "<leader>cr", c.CompilerOpen) -- compiler run
k.set("n", "<leader>ct", c.CompilerToggleResults)

-- <leader>cx is in lazy.lua if it still exists

--- Open terminal shortcuts
k.set("n", "<leader>zt", "<C-w>v<cmd>term<CR>")
k.set("n", "<leader>t", "<cmd>tabe<CR><cmd>term<CR>")
k.set("n", "<leader><CR>", c.term)

--- Buffer shortcuts
k.set("n", "<leader>qb", c.bd, {desc=":bd Delete buffer"})
local function bufToNewTab(isBackground)
    local id = vim.api.nvim_get_current_buf()
    vim.api.nvim_win_hide(0)
    c.tabe()
    vim.api.nvim_set_current_buf(id)
    if isBackground then
        c.tabp()
    end
end

k.set("n", "<leader>zm", bufToNewTab, {desc="Move to new tab"})
k.set("n", "<leader>zM", function() bufToNewTab(true) end, {desc="Move to new tab (stay in same tab)"})

--- Vim shortcuts
k.set("n", "<leader>w", c.w)
k.set("n", "<leader>ze", [[GVgg"+x<cmd>e ~/backup2022nov*/j/Backup/sessions-watch l8r 2024.md<CR>gg}ma"+p2o<Esc>`a3O<Esc><cmd>.!date +\%F<CR>]])
k.set("n", "<leader>e", c.tabe)
k.set("n", "<leader>`", function()
    c.cd()
    vim.notify("cwd: ~")
end, {desc="Move cwd to ~"}) -- In future: if cd == ~ .. otherwise go to current dir

k.set("n", "<leader>~", function()
    c("cd %:h")
    vim.notify(uv.cwd())
end, {desc="Move cwd .. of current file"})

k.set("n", "<leader>m.", function()
    c("cd ..")
    vim.notify(uv.cwd())
end, {desc="Move cwd .. of cwd (previously <leader>.)"})

--[[ above todo:
- Doesn't delete empty buffer. Avoid :bd!
- IP: Use marks instead of paragraph jumps. Otherwise date will be inserted incorrectly. Or changelist?
- Because of above, new lines don't work.
- g`"
--]]

k.set("n", "<leader>pv", c.Ex, { desc = "Project view :Ex"})
k.set("n", "<leader>pt", c.TodoLocList, { desc = ":TodoLocList"})
k.set("n", "<leader>pd", function() vim.notify("stub: no prject dir fn")
end, { desc = "Project directory"})

--- not keyboard shortcut
vim.api.nvim_create_user_command("Godot", function() -- Runs on :Godot
    local path = "project.godot"
    local pathExists = uv.fs_stat(path)
    if not pathExists then
        -- vim.notify("where u at godot????")
        local handle = vim.uv.fs_scandir(".")
        if not handle then
            vim.notify("nvim godot: Failed to get directory contents from cwd.")
            return
        end

        while true do -- check cwd
            local name, typ = vim.uv.fs_scandir_next(handle)
            if not name then break end
            if typ == "directory" then
                path = name .. "/project.godot"
                pathExists = uv.fs_stat(path)
                if pathExists then break end
            end
        end
    end

    if pathExists then
        vim.notify("Launching Godot from " .. path)
        -- c("!godot project.godot") -- same thing as below, but nvim can't be used while Godot is open in this case

        require'plenary.job':new({
            command = "godot", args = {path}, cwd = uv.cwd(),
            on_exit = function(j, res) print(j:result()); print(res) end
        }):start()
    else
        vim.notify("Could not find project.godot.\ncwd: " .. uv.cwd())
    end

end, {})

k.set("n", "<leader>go", c.Godot)

-- l8r: make it like an API that can be accessed anywhere
local function i_txt(txt)
    -- :help nvim_buf_set_text
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { txt })
end

local function i_date()
    i_txt(tostring(os.date("%x"))
        -- To learn more: https://www.lua.org/pil/20.2.html
        :gsub('(%d+)/(%d+)/(%d+)', '%3-%1-%2')
        -- Leading zeros show up only on some operating systems.
        :gsub("-0", "-"))
end

vim.api.nvim_create_user_command("Date", i_date, {})
k.set("n", "<leader>da", i_date, {desc="Insert date"}) -- note: doesn't work on all distros and platforms for some reason

-- local function getReg()
--     return vim.fn.getreg('+') -- no arguments = vim clipboard
-- end

local function getReg(reg)
    reg = reg or '+'
    return vim.fn.getreg(reg)
    -- below technically works but why
    -- return vim.api.nvim_exec2("echo @+", { output = true }).output
end

local function qrCmd()
    -- c("!qrencode -t UTF8 \"" .. getClipboard():gsub('"', '\\"') .. '\""')
    local txt = tostring(getReg())

    -- prevents error when text starts with -- by adding space. broken with <leader>qr right now.
    if string.sub(txt,1,2) == "--" then
        txt = " " .. txt
    end
    txt = txt:gsub("\n", " ") -- new lines break stuff for some reason. `qrencode` does work with new lines.
    -- txt = txt:gsub('-', '\\-')

    -- \n test
    vim.notify('after filtering: "' .. tostring(txt) .. '"')
--[[

this text is here for testing

yup
--]]
    c('!qrencode -t UTF8 "' .. txt .. '"')
end
vim.api.nvim_create_user_command("Qr", qrCmd, {}) -- this is DIFFERENT than <leader>qr ... just in case there's more bugs with newer way

-- k.set("n", "<leader>qr", qrCmd, {desc="Get QR code from system clipboard (+ register)"})
k.set("n", "<leader>qr", [[:!qrencode -t UTF8 "<c-r>+"<CR>]], {desc="Get QR code from system clipboard (+ register) (escapes don't work for now)"})

-- WARNING: only works in systems with "ls" and wildcards
--- @return table|nil
local function ls_filter(txt)
    txt = txt or ""

    -- WARNING: Nothing below handles stderr (why cursor text shows up on err)
    local file, err
    file, err = io.popen("ls " .. txt)

    if not file then -- lua lang server wants me to check for some reason
        vim.notify("Error in probably ls_filter(): "..tostring(err)) return
    end

    local lines = vim.split(file:read('*a'), '\n', {trimempty=true})
    -- local lines = file:lines()

    file:close()
    return lines
end

local function vsall(range)
    range = range:gsub(" ", "\\ ")
    local lines = ls_filter(range)
    if not lines or #lines == 0 then
        vim.notify("Canceled vsall. Expected: "..tostring(range))
        return
    end

    vim.print(lines)
    for _, name in pairs(lines) do
        if name ~= "" then
            c.vs(name)
        end
    end
end

-- k.set("n", "<leader>md") -- markdown delete duplicates (better name / etc. l8r)

k.set("n", "<leader>dc", function()
    -- sync conflict files made automatically by syncthing
    vsall(vim.fn.expand('%:r') .. ".sync-conflict-*")
end, {desc="Diff conflict files (might do more in future)"})

k.set("n", "<leader>pt", c.TodoLocList, { desc = ":TodoLocList"})

local isVisible = false
k.set("n", "<leader>ht", function()
    isVisible = not isVisible
    if isVisible then
        c.hi("Normal", "guifg=#333333", "guibg=#000000")
    else
        c.hi("Normal", "guifg=xxx", "guibg=Clear")
    end
end, { desc = "Less visible text. tags: invisible, hidden"})

k.set("n", "<leader>hh", "<cmd>nohl<CR>", { desc = "Hide highlight after searching. tags: invisible, hidden"})
k.set("n", "<leader>hn", "<cmd>set nu! rnu!<CR>", { desc = "Toggle number / relative number. tags: invisible, hidden"})

-- -- future problem
-- vim.api.nvim_create_autocmd("NerdTreeAutocd", {
-- })

-- https://youtu.be/9gUatBHuXE0
-- Autorun on save. Useful but not in this case. Useful example: .md -> .html
-- vim.api.nvim_create_autocmd("BufWritePost", {
--     group = vim.api.nvim_create_augroup("Codeee", { clear = true }),
--     pattern = "project.godot",
--     callback = function()
--         c("!godot project.godot")
--     end,
-- })

-- !pup text{} | sed '/^\s*$/d' # doesn't work smh cuz sed and vim recognizing it differently... make new shell script i guess
