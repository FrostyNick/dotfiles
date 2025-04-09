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

k.set('n', '<leader>,', "<cmd>bro o<CR>", { desc="(fallback to Telescope): old files" })

-- k.set("n", "<leader>dk", function() vim.diagnostic.jump({count=1, float=true}) end, {desc="LSP: prev diagnostic"})
k.set("n", "<leader>dk", vim.diagnostic.goto_prev or vim.diagnostic.jump({count=1, float=true}), {desc="LSP: prev diagnostic"})
k.set("n", "<leader>dj", vim.diagnostic.goto_next or vim.diagnostic.jump({count=-1, float=true}), {desc="LSP: next diagnostic"})

-- Keep clipboard contents after pasting with p in visual mode.
-- Thanks to: https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua#L52C1-L52C31
k.set("v", "p", '"_dP')

-- v conflicts with gcc
-- kLsp("gca", vim.lsp.buf.code_action, "code action")
k.set("n", "gt", vim.lsp.buf.type_definition, {desc="LSP: type definition"})
k.set("n", "gr", vim.lsp.buf.rename, {desc="LSP: rename"})
-- ga overrides vim keybind for character code under current cursor.
k.set("n", "gA", vim.lsp.buf.code_action, {desc="LSP: code action"})
k.set("n", "gf", "<cmd>e <cfile><CR>", {desc="gf + also create unsaved file if it doesn't exist"})
-- <leader>zo moved to lazy.lua

-- yank/put: " + macro + y/p
-- useless macro: isusu€kb
-- macro: cwk,€kb.setwa"n", $2F'2F"$2F"i{desc=$i}

-- Might be useful if you use quickfix list
-- k.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- k.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- k.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- k.set("n", "<C-j>", "<cmd>cprev<CR>zz")

k.set("n", "<C-h>", "<C-w><c-h>")
k.set("n", "<C-j>", "<C-w><c-j>")
k.set("n", "<C-k>", "<C-w><c-k>")
k.set("n", "<C-l>", "<C-w><c-l>")
-- k.set("n", "<TAB>", "<cmd>tabn<CR>", {desc="Next tab"}) -- might override existing shortcuts
-- k.set("n", "<S-TAB>", "<cmd>tabp<CR>", {desc="Prev tab"})
k.set("n", "<leader>zk", "<cmd>tabn<CR>", {desc="Next tab"})
k.set("n", "<leader>zj", "<cmd>tabp<CR>", {desc="Prev tab"})

-- k.set("t", "<C-h>", "<cmd>winc h<CR>", {remap=true, silent=true}) -- doesn't seem to work
-- k.set("t", "<C-j>", "<cmd>winc j<CR>", {remap=true, silent=true})
-- k.set("t", "<C-k>", "<cmd>winc k<CR>", {remap=true, silent=true})
-- k.set("t", "<C-l>", "<cmd>winc l<CR>", {remap=true, silent=true})

k.set("v", "<", "<gv")
k.set("v", ">", ">gv")

k.set("n", "<leader>gr", -- rare edge-case: breaks when git exists earlier I think 
"<cmd>!xdg-open $(git remote -v | grep -i $(git config user.name) | awk '{ print $2 }' | head -n 1 | sed '$s/\\.git//')&<CR><CR>",
{ desc = "Opens git remote origin link with your username as configured in git. For opening the exact file and line in github from all users, use <leader>2gr instead.", silent = true })

k.set("n", "<leader>gv", [[:Gvdiffsplit]], {desc="Gvdiffsplit - fill in: git vertical split"})
-- k.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
k.set("t", "<C-h>", "<C-\\><C-N><cmd>sleep! 100m<CR><C-w>h")
k.set("t", "<Esc>q", "<c-\\><c-n>")

k.set("n", "<leader>zd", [[:!dict <C-r><C-w><CR>g]], {silent = true, desc="Get word definition from word that's on your cursor (requires dict to be installed and configured correctly)"})
-- related: >st
k.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
k.set("n", "<leader>sR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--- I should make a different mode at this point...
-- *insert removing end of yt links*
k.set("n", "<leader>myts", [[:%s#www.youtube.com/shorts/#youtu.be/#gI<CR>]], {desc="Shorten YouTube short URLs"})
k.set("n", "<leader>mytv", [[:%s#www.youtube.com/watch?v=#youtu.be/#gI<CR>]], {desc="Shorten YouTube URLs"})
---- below is work in progress
-- k.set("n", "<leader>mk", ":norm blysiW]f]a()<CR>", {desc="Markdown lin[k] (requires nvim-surround)"})
-- k.set("n", "<leader>mw", ":norm blysiW]f]a()<CR>2hT[", {desc="Markdown link [w]ord (requires nvim-surround)"})

k.set("n", "yc", "yygccp", {desc="Text: Copy line; comment; paste in next line.", remap=true}) -- credit: u/santas on reddit
k.set("n", "<leader>dt", [[:diffthis<CR><C-w><C-w>:diffthis<CR><C-w><C-p>]])
k.set("n", "<leader>dq", [[:diffo<CR><C-w><C-p>:diffo<CR><C-w><C-p>]])
k.set("n", "<leader>do", "<cmd>windo set scrollbind!<CR>") -- might not be working
-- * does the same thing k.set("n", "<leader>/", "/<C-r><C-w><CR>")
k.set("n", "<leader>x", [[GVgg"+x]], { silent = true }) -- cuts all text to clipboard
k.set("n", "<leader>mr", [[:put =range(1,)<Left>]], { desc="Insert text: math range" })
-- :vmap _a <Esc>`>a<CR><Esc>`<i<CR><Esc>!!date<CR>kJJ -- :help visual_example
-- k.set("v", "<leader>yt", "<Esc>`>a<CR><Esc>`<i<CR><Esc>!!date<CR>kJJ")
-- k.set("n", "<leader>mb", [[}kI- ]], { desc="Markdown bullet points" }) -- does nothing cuz (macro != keymap function)
k.set("n", "<leader>me", function()
  c.tabe(); vim.opt.filetype = 'markdown' end)

k.set("n", "<leader>vpc",
"<cmd>e " .. vim.fn.stdpath('config') .. "/lua/frostynick/lazy.lua<CR>");

k.set('n', '<leader>vpp',
'<cmd>Telescope find_files hidden=true search_dirs=$HOME/p/<CR>',
{desc="Telescope: find code in projects directory"})

-- below doesnt work because i is powerful af. fix later.
k.set("n", "<leader>vpi", "<cmd>tabe ~/bk*/markor/ideas.md<CR>")
k.set("n", "<leader>vpt", "<cmd>tabe ~/bk*/markor/todo.md<CR>")
k.set("n", "<leader>vpg", function()
  c.tabe("~/bk*/markor/gfl.md")
  vim.notify("<leader>g{o,p} also make new branch")
end);

k.set("n", "<leader>ia", "<cmd>e ~/bk*/markor/ideas.md<CR>");

--- xdg-open miscellaneous
-- Future: If using Windows or MacOS, alias different open command
-- norg only loads in .norg file; setup in Lazy. Result: about -11ms startup but it sometimes takes really long to load (50ms) when it loads for some reason. I might be a bit off though haven't tested it much.
k.set("n", "<leader>o", -- project open
"<cmd>!xdg-open . &<CR><CR>", { silent = true, desc = "xdg-open directory" })
k.set("n", "<leader>fx", "<cmd>!chmod +x \"%\"<CR>", { silent = true, desc = "chmod +x current file" })
-- k.set("n", "<leader>fd", function() vim.notify("Temporary deletion not supported. Captial D to delete file permanently.") end, { silent = true, desc = "permanantly delete file" })
k.set("n", "<leader>fd", "<cmd>!trash-put \"%\" # reminder: not permanent.<CR>" , { silent = true, desc = "Temporarily delete file (requires trash-cli)." })
k.set("n", "<leader>fD", "<cmd>!rm \"%\"<CR>", { silent = true, desc = "Permanantly delete file." })

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
k.set("n", "<leader>2gl", "<cmd>Git log --oneline --pretty=reference --date=relative --decorate --graph --all<CR>") -- date=relative can be date=iso (yyyy-mm-dd hh:mm:ss -n) See git log --help /date=rel
k.set("n", "<leader>2gd", "<cmd>Git diff<CR>")

local function getReg(reg)
  reg = reg or '+'
  return vim.fn.getreg(reg)
  -- below technically works too
  -- return vim.api.nvim_exec2("echo @+", { output = true }).output
end

local function getTermCode(txt)
  return vim.api.nvim_replace_termcodes(txt, true, true, true)
end

local function termExec(rawKeys, doCR)
  c("vs | te")

  local keys
  if vim.fn.exists(":Vterm") == 2 then
    -- below changes if termim plugin exists
    keys = rawKeys
  else
    keys = "i" .. rawKeys
  end

  if not doCR then
    vim.api.nvim_feedkeys(keys, "n", false)
    return
  end
  local keyCR = getTermCode("<CR>")

  vim.api.nvim_feedkeys(keys .. keyCR, "n", false)
end

local function getVSel()
  -- credit to u/PaperCupsAhoy old.reddit.com/r/neovim/comments/oo97pq/comment/h5xiuyn
  vim.cmd('noau normal! "vy"')
  return getReg('v')
end

k.set("n", "<leader>gp", function()
  termExec("gitp", true)
end)

k.set("n", "<leader>at", function()
  termExec("tgpt -m", true)
end, { desc = "ai tgpt"})

k.set("n", "<leader>Wt", function() -- [[:!dict <C-r><C-w><CR>g]], {silent = true, desc="Get word definition from word that's on your cursor (requires dict to be installed and configured correctly)"})
  c("<cmd>norm yiW<CR>")
  -- termExec(getTermCode("<Esc>") .. "p", true)
end, { desc = "open WORD in terminal" })

k.set("v", "<leader>zt", function()
  local txt = getVSel()
  if txt:sub(-1) == "\n" then txt = txt:sub(1, -2) end
  -- vim.notify(txt)
  -- c("winc v")
  termExec(txt, false)
end, { desc = "Write visual selection to new vertical split terminal" })

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
k.set("n", "<leader>zt", "<C-w>v<cmd>te<CR>")
k.set("n", "<leader>t", "<cmd>tabe<CR><cmd>te<CR>")
k.set("n", "<leader><CR>", c.te)

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
k.set("n", "<leader>w", c.up)
k.set("n", "<leader>zw", c.wa)
k.set("n", "<leader>qw", c.xa)
k.set("n", "<leader>zie", [[GVgg"+x<cmd>e ~/bk*/j/Backup/sessions-watch l8r 2024.md<CR>gg}ma"+p2o<Esc>`a3O<Esc><cmd>.!date +\%F<CR>]])
k.set("n", "<leader>ze", c.vne)
k.set("n", "<leader>e", c.tabe)

--- Working directory
k.set("n", "<leader>`", function()
  c.cd()
  vim.notify("cwd: ~")
end, {desc="Move cwd to ~"}) -- In future: if cd == ~ .. otherwise go to current dir
k.set("n", "<leader>cwd", function() vim.notify(uv.cwd()) end)

k.set("n", "<leader>~", function()
  c("cd %:h")
  vim.notify(uv.cwd())
end, {desc="Move cwd .. of current file"})

k.set("n", "<leader>.", function()
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
  local date = tostring(os.date("%x"))
    -- To learn more: https://www.lua.org/pil/20.2.html
    :gsub('(%d+)/(%d+)/(%d+)', '%3-%1-%2')
    -- Leading zeros show up only on some operating systems. LuaJIT issue?
    :gsub("-0", "-")

  if date:sub(3,3) == "/" then
    date = "20" .. date
  end
  i_txt(date)
end

vim.api.nvim_create_user_command("Date", i_date, {})
k.set("n", "<leader>da", i_date, {desc="Insert date"}) -- note: doesn't work on all distros and platforms for some reason

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
vim.api.nvim_create_user_command("Qr", qrCmd, {desc = "Note: This is different than the keybind for testing purposes."})
vim.api.nvim_create_user_command("TSPlaygroundToggle", function()
  vim.notify("nvim-treesitter/playground is deprecated for these dotfiles. Use :InspectTree, :Inspect, and (v0.10+) :EditQuery")
  vim.cmd.InspectTree()
end, {})
k.set("n", "<leader>kk", "<cmd>Screenkey<CR>", { desc = "Toggle displaying screenkey visibility."})

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
    vim.notify("Error in ls_filter(): "..vim.inspect(err)) return
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

local function getYId()
  local txtLs, id = getVSel()

  for _,txt in pairs(vim.split(txtLs, ' ', {trimempty=true})) do
    txt = txt:gsub("\n", "")
    -- txt = txt:gsub(")]", "")
    txt = txt:gsub("[()]", "")

    local len = string.len(txt)
    if len >= 11 then
      txt = txt:sub(-11)
      id = txt
      break
    end
  end

  if id then
    -- vim.notify("success! yid=" .. vim.inspect(id))
    return id
  end
  vim.notify("That doesn't appear to be a valid yid. yid=" .. vim.inspect(id))
end

local function y2(cmd)
  local id = getYId()
  if id then termExec(cmd .. tostring(id), true) end
end

k.set("v", "<leader>y2", function()
  y2("y2 -a ")
end, {desc="Grab the yid in visual mode, then run it like this: y2 -a <id>"})

k.set("v", "<leader>y3", function()
  y2("y2 -x ")
end, {desc="Grab the yid in visual mode, then run it like this: y2 -x <id>"})

k.set("v", "<leader>y9", function() vim.notify("yid = " .. tostring(getYId())) end)
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
--   group = vim.api.nvim_create_augroup("Codeee", { clear = true }),
--   pattern = "project.godot",
--   callback = function()
--     c("!godot project.godot")
--   end,
-- })

-- !pup text{} | sed '/^\s*$/d' # doesn't work smh cuz sed and vim recognizing it differently... make new shell script i guess
