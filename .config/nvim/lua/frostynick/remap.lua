local uv = vim.uv or vim.loop -- :help luvref.txt
local k = vim.keymap
local c = vim.cmd

vim.g.mapleader = ' '
local treesitterOn = true
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

k.set('n', '<leader>2,', "<cmd>bro o<CR>", { desc="(fallback from Telescope): old files" })
k.set('n', '<leader>2ff', ":find <c-d>", { desc="(fallback from Telescope): find files (command mode)" }) -- NOTE: vim.opt.path:append("**") -- include subdirectories in search (already in set.lua)
k.set('n', '<leader>fof', ":find <c-d>", { desc="find files (command mode)" })
k.set('n', '<leader>2b', ":b <c-d>", { desc="find buffer (fallback from Telescope; command mode)" })
k.set('n', '<leader>fls', ":b <c-d>", { desc="find buffer (command mode)" })
k.set('n', '<leader>fo?', "<cmd>map<CR>", { desc="(fallback from Telescope): keyboard shortcuts (just normal mode)" })
k.set('n', '<leader>2fi', ':colorscheme <c-d><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS><BS>lua ColorMyPencils("")<Left><Left>', { desc='colorschemes "find ink" (command mode)' })
k.set('n', '<leader>fy', ":lua vim.opt.filetype = ''<Left>", { desc="set filetype" })

-- k.set("n", "<leader>dk", function() vim.diagnostic.jump({count=1, float=true}) end, {desc="LSP: prev diagnostic"})
-- k.set("n", "<leader>D", function() pcall(function() vim.diagnostic.jump({count=-1,float=true}) end) or vim.diagnostic.goto_prev; end, {desc="LSP: prev diagnostic"})
k.set("n", "<leader>D", function() vim.diagnostic.jump({count=-1,float=true}) end or vim.diagnostic.goto_prev, {desc="LSP: prev diagnostic"})
k.set("n", "<leader>d", function() vim.diagnostic.jump({count=1, float=true}) end or vim.diagnostic.goto_next, {desc="LSP: next diagnostic"})
k.set("n", "<leader>dj", function() vim.notify("Alternative: leader d/D."); vim.diagnostic.jump({count=1,float=true}) end, {desc="LSP: next diagnostic"})

-- Keep clipboard contents after pasting with p in visual mode.
-- Thanks to: https://github.com/LunarVim/Neovim-from-scratch/blob/02-keymaps/lua/user/keymaps.lua#L52C1-L52C31
k.set("v", "p", '"_dP')

-- v conflicts with gcc
-- kLsp("gca", vim.lsp.buf.code_action, "code action")
-- k.set("n", "gt", vim.lsp.buf.type_definition, {desc="LSP: type definition"}) -- conflicts with tab switching
k.set("n", "gr", vim.lsp.buf.rename, {desc="LSP: rename"})
-- ga overrides vim keybind for character code under current cursor.
k.set("n", "gA", vim.lsp.buf.code_action, {desc="LSP: code action"})
k.set("n", "gf", "<cmd>e <cfile><CR>", {desc="gf + also create new buffer (unsaved file) if it doesn't exist"})
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

k.set("n", "<leader>gb", -- rare edge-case: breaks when git exists earlier I think 
"<cmd>!xdg-open $(git remote -v | grep -i $(git config user.name) | awk '{ print $2 }' | head -1 | sed '$s/\\.git//')&<CR><CR>",
{ desc = 'Opens git browsing (remote origin link) with your username as configured in git. For opening the exact file and line in github from all users, use <leader>2gr instead.', silent = true })

k.set("n", "<leader>gv", [[:Gvdiffsplit]], {desc="Gvdiffsplit - fill in: git vertical split"})
-- k.set("t", "<C-h>", "<C-\\><C-N><C-w>h")
k.set("t", "<C-h>", "<C-\\><C-N><cmd>sleep! 100m<CR><C-w>h")
k.set("t", "<Esc>q", "<c-\\><c-n>")

k.set("n", "<leader>zd", [[:!dict <C-r><C-w><CR>g]], {silent = true, desc="Get word definition from word that's on your cursor (requires dict to be installed and configured correctly)"})
-- related: >st
k.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]])
k.set("n", "<leader>sR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
k.set("n", "<leader>dr", [[:%s///gIc<Left><Left><Left><Left><Left>]])
k.set("n", "<leader>dR", [[:%s///gI<Left><Left><Left><Left>]]) -- maybe autofill a char in future
--- I should make a different mode at this point...
-- *insert removing end of yt links*
k.set("n", "<leader>mys", [[:%s#www.youtube.com/shorts/#youtu.be/#gI<CR>]], {desc="Shorten YouTube short URLs"})
k.set("n", "<leader>myv", [[:%s#www.youtube.com/watch?v=#youtu.be/#gI<CR>]], {desc="Shorten YouTube URLs"})
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

k.set("n", "<leader>vpc",
"<cmd>e " .. vim.fn.stdpath('config') .. "/lua/*/lazy.lua<CR>");

-- k.set('n', '<leader>vpp', -- snacks
-- '<cmd>Telescope find_files hidden=true search_dirs=$HOME/p/<CR>',
-- {desc="Telescope: find code in projects directory"})

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
k.set("n", "<leader>zo", -- project open
"<cmd>!xdg-open . &<CR><CR>", { silent = true, desc = "xdg-open directory" })
k.set("n", "<leader>fx", "<cmd>!chmod +x %:S<CR>", { silent = true, desc = "chmod +x current file" })
-- k.set('n', '<leader>fe', function() vim.notify(vim.inspect(uv.fs_mkstemp("tfrni"))) end, { desc = "Save as temporary file"} )
k.set('n', '<leader>fe', ":sav " .. uv.os_tmpdir() .. "/vifrni.", { desc = "Save as temporary file (also waits to pick file extension)"} )

-- k.set("n", "<leader>fd", function() vim.notify("Temporary deletion not supported. Captial D to delete file permanently.") end, { silent = true, desc = "permanantly delete file" })
k.set("n", "<leader>fd", "<cmd>!trash-put %:S # reminder: not permanent.<CR>" , { silent = true, desc = "Temporarily delete file (requires trash-cli)." })
k.set("n", "<leader>fD", "<cmd>!rm %:S<CR>", { silent = true, desc = "Permanantly delete file." })

-- "explorer" is for Windows. Probably broken; needs Git Bash for pipes to work.
k.set("n", "<leader>po",
"<cmd>!xdg-open %:S & | open %:S | explorer %:S<CR><CR>",
{ silent = true, desc = "xdg-open file" })

--- Git shortcuts
k.set("n", "<leader>ghs",
"<cmd>!gh status<CR>",
{ silent = true, desc = "github status (requires gh / github-cli)" })
k.set("n", "<leader>gho",
"<cmd>Octo<CR>",
{ silent = true, desc = "octo list (requires gh)" })

k.set("n", "<leader>gg", c.Git, {desc = "Open git fugitive"})
k.set("n", "<leader>2gl", "<cmd>Git log --oneline --pretty=reference --date=relative --decorate --graph --all<CR>") -- date=relative can be date=iso (yyyy-mm-dd hh:mm:ss -n) See git log --help /date=rel
k.set("n", "<leader>2gd", "<cmd>Git diff<CR>")

k.set("n", "<leader>gr", function()
  -- :he filename-modifiers
  vim.cmd("!cp %:r{,.sync-conflict-git}.%:e && git restore %:S")
  vim.notify("You may want to do <le.>dc now.")
end, { desc = "Git restore + backup which is compatible with <le.>dc"} )
k.set("n", "<leader>gR", "<cmd>!git restore \"%\"<CR>", { desc = "Git restore (no backup)" })

local function getReg(reg)
  return vim.fn.getreg(reg or '+')
  -- below technically works too
  -- return vim.api.nvim_exec2("echo @+", { output = true }).output
end

local function setReg(v, reg) -- tag: c_txt
  if v == nil then
    vim.notify("Skipped: setReg is missing first argument.")
    return
  end
  vim.fn.setreg(reg or '+', v)
  -- i didnt change if nvim-exclusive alternative works.
end

local function getTermCode(txt)
  return vim.api.nvim_replace_termcodes(txt, true, true, true)
end

local function termExec(rawKeys, doCR, cTxt)
  c(cTxt or "sp | winc 9- | te") -- "vs te"
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

local function i_txt(txt)
  -- :help nvim_buf_set_text
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { tostring(txt) })
end

local function i_date()
  local date = tostring(os.date("%x"))
    -- To learn more: https://www.lua.org/pil/20.2.html
    :gsub('(%d+)/(%d+)/(%d+)', '%3-%1-%2')
    :gsub("-0", "-")
    :gsub("^(%d)(%d)-", "20%1%2-") -- In termux: Year is "25" probably due to LuaJIT / nvim bug.

  i_txt(date)
end

local function getNums()
  local txt = tostring(getVSel()):gsub("[ 	]", "\n"):gsub("[^%d%.%s]", "")
  txt = vim.split(txt, "\n", {trimempty=true, plain=true})
  local nums = {}
  for _, v in pairs(txt) do
    if tonumber(v) then
      nums[#nums + 1] = tonumber(v)
    end
  end
  return nums
end

local function getMNums()
  local txt = tostring(getVSel()):gsub("[ 	]", "\n"):gsub("[^%d%.%s]", "")
  txt = vim.split(txt, "\n", {trimempty=true, plain=true})
  local sum = 0
  local count = 0
  for _, v in pairs(txt) do
    if tonumber(v) then
      sum = sum + tonumber(v)
      count = count + 1
    end
  end
  -- vim.notify(count .. " = sum (" .. count .. " numbers found.)")
  vim.notify(count .. " numbers found.")
  return sum, count
end

k.set("v", "<leader>mp", function()
  local nums = getNums()
  local n = nums[1]
  for i = 2,#nums do
    n = n * nums[i]
  end
  if n then
    vim.notify("Result copied to clipboard: " .. n)
    setReg(n)
  else
    vim.notify("No results found.")
  end
end, { desc="Insert text: math product" })

k.set("v", "<leader>ms", function()
  local sum = getMNums()
  vim.notify("Result copied to clipboard: " .. sum)
  setReg(sum)
end, { desc="Insert text: math sum" })

k.set("v", "<leader>ma", function()
  local sum, count = getMNums()
  local a = sum / count
  vim.notify("Result copied to clipboard: " .. a)
  setReg(a)
end, { desc="Insert text: math average" })

k.set("v", "<leader>ma", function()
  local txt = tostring(getVSel()):gsub(" ", "\n")
  txt = vim.split(txt, "\n", {trimempty=true, plain=true})
  local nums = 0
  local count = 0
  for _, v in pairs(txt) do
    if tonumber(v) then
      nums = nums + tonumber(v)
      count = count + 1
    end
  end
  vim.notify("Found " .. count .. " numbers in total.")
  i_txt(nums / count)
end, { desc="Insert text: math average" })

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

k.set("n", "<leader>zb", "<cmd>tabe | te newsboat<CR>", { desc = "Open newsboat"})

local function vTe(cTxt, L, R)
  local txt2 = getVSel()
  if R and txt2:sub(-1,-1) == "\n" then
    txt2 = txt2:sub(1,-2)
    R = R .. "\n"
  end
  local blocks = vim.split(txt2, "`", {trimempty=true, plain=true})
  if txt2:sub(-1) == "`" then -- get last code area
    txt2 = blocks[#blocks]
  else
    txt2 = blocks[#blocks - 1] or blocks[1]
  end
  if txt2:sub(1,3) == "// " then
    vim.notify('Removed "// " from start.')
    txt2 = txt2:sub(4)
  end
  local comments = vim.split(txt2, "#", {trimempty=true, plain=true}) -- this function is also used to launch bash programs which happen to have comments at the end, which can break extra code intended for "R" variable.
  if #comments > 1 then
    local comment = comments[#comments]
    vim.notify('Removed everything continuing from "#": ' .. comment)
    txt2 = txt2:sub(1, -(string.len(comment)+2) )
    vim.notify("Code: " .. txt2)
  end
  local txt = (L or "") .. txt2 .. (R or "")
  vim.notify(txt)
  termExec(txt, false, cTxt)
end

k.set("v", "<leader>zt", vTe,
{ desc = "Visual selection is put in new terminal buf in vertical split" })
k.set("v", "<leader>lt", function() vTe(nil, " (", " &) ; sleep 0.1 ; exit") end,
{ desc = "'launch program from terminal and exit' Visual selection is put in new terminal buf in vertical split" })
k.set("v", "<leader>t", function() vTe("tabe | te") end,
{ desc = "Visual selection is put in new terminal buf in new tab" })
-- if in git repository, open 1st remote url.
-- Above should use git fugitive ... I just have a terminal dependant password inserting thing that makes git fugitive not work well. (:G push)

local function toggleTs()
  treesitterOn = not treesitterOn
  if treesitterOn then
    vim.treesitter.start()
  else
    vim.treesitter.stop()
  end
end

---- Markdown shortcuts

-- WARNING: <leader>smr is broken
k.set("v", "<leader>smr", function() -- visual select; convert "this text is https://a.link" -> "[this text is](https://a.link)"
  local txtLs = vim.trim(getVSel())
  vim.api.nvim_feedkeys(getTermCode("<Esc>"), "v", false)
  local s = vim.split(txtLs, " ", {trimempty=true})
  vim.notify(vim.inspect(s))
  local sEnd, sStart = "", ""
  if #s > 1 then
    sEnd = s[#s]
    sStart = txtLs:sub(1, -(string.len(sEnd) + 2))
    s = ("[" .. sStart .. "](" .. sEnd .. ")")
    vim.notify("Copied to clipboard: " .. vim.inspect(s))
    -- vim.api.nvim_paste(s, false, -1) -- it works, but doesn't replace text.
    -- vim.fn.setreg("+", s)
  else
    vim.notify("There must be at least one space in visual selection. " .. vim.inspect(s))
  end
end, { desc = "EXPERIMENTAL: Get markdown link from visually selected text."})

k.set("n", "<leader>me", function()
  c.tabe(); vim.opt.filetype = 'markdown' end)

local function panmap(char, f, t)
  local nf = (f == "gfm" and "gfm (markdown)") or f
  local nt = (t == "gfm" and "gfm (markdown)") or t
  -- local fT = f.. " -t " ..t.. " --no-highlight<CR>" -- according to pandoc: [WARNING] Deprecated: --no-highlight.
  local fT = f.. " -t " ..t.. " --syntax-highlighting=none<CR>"

  k.set("v", "<leader>p" .. char, ":!pandoc -f " .. fT,
    { desc="Pandoc: " ..nf.. " -> " .. nt, noremap=true, silent=true })
  k.set("n", "<leader>p" .. char, ":%!pandoc -f " .. fT,
    { desc="Pandoc: " ..nf.. " -> " .. nt, noremap=true, silent=true })
end

panmap("to", "html", "org")
panmap("ta", "html", "asciidoc")
panmap("fa", "asciidoc", "html")
panmap("m", "html", "markdown_strict")
panmap("gm", "html", "gfm")
panmap("h", "gfm", "html")
-- panmap("sm", "gfm", "markdown_strict") -- this is ineffective compared to starting with html for some reason
panmap("tt", "gfm", "typst")
panmap("ft", "typst", "gfm")
panmap("fl", "latex", "typst")

-- new attributes not tested from pandoc.org/try ( i should look at more formats like docuwiki, djot, context, asciidoc)
panmap("fr", "rtf", "html") -- how about... to typst instead?

k.set("n", "<leader>cfy", [[:%!grep -- "- \[x\]"<CR>]], { desc = "checkmark (markdown): filter = 'yes' values (requires grep)"})
k.set("n", "<leader>cfi", [[:%!grep -- "- \[-\]"<CR>]], { desc = "checkmark (markdown): filter = 'in-progress' values (requires grep)"})
k.set("n", "<leader>cfn", [[:%!grep -- "- \[ \]"<CR>]], { desc = "checkmark (markdown): filter = 'no' values (requires grep)"})
k.set("n", "<leader>cay", [[:exe 'norm m`' | %s/- \[.\]/- \[x]/gI | norm g``<CR>]], { desc = "checkmark (markdown): all = 'yes' values"})
k.set("n", "<leader>cai", [[:exe 'norm m`' | %s/- \[.\]/- \[-]/gI | norm g``<CR>]], { desc = "checkmark (markdown): all = 'in-progress' values"})
k.set("n", "<leader>can", [[:exe 'norm m`' | %s/- \[.\]/- \[ ]/gI | norm g``<CR>]], { desc = "checkmark (markdown): all = 'no' values"})

k.set("n", "<leader>mm", c.MarkdownPreviewToggle)
k.set("n", "<leader>mt", function()
  c.TableModeToggle()
  toggleTs()
end)

---- Run shortcuts

local function getRunPath(path)
  local pathExists = uv.fs_stat(path)
  if not pathExists then
    local handle = vim.uv.fs_scandir(".")
    if not handle then
      vim.notify("getRunPath(" .. tostring(vim.inspect(path)) .. "): Failed to get directory contents from path.")
      return
    end

    while true do -- check cwd
      local name, typ = vim.uv.fs_scandir_next(handle)
      if not name then break end
      if typ == "directory" then
        -- path = name .. "/project.godot"
        path = name .. "/project.godot"
        pathExists = uv.fs_stat(path)
        if pathExists then break end
      end
    end
  end
  return (pathExists and path)
end

local function runGodot() -- Runs on :Godot
  local path = getRunPath("project.godot")
  if path then
    vim.notify("Launching Godot from " .. path)
    -- c("!godot project.godot") -- same thing as below, but nvim can't be used while Godot is open in this case

    require'plenary.job':new({
      command = "godot", args = {path}, cwd = uv.cwd(),
      on_exit = function(j, res) print(j:result()); print(res) end
    }):start()
  else
    vim.notify("Could not find project.godot.\ncwd: " .. uv.cwd())
  end
end

vim.api.nvim_create_user_command("Godot", runGodot, {})

local function run(typ)
  local ext = vim.fn.expand("%:e")
  local typ = typ or tostring(vim.opt.filetype._value) or tostring(ext)
  vim.notify("filetype or fallback: " .. tostring(typ) .. "\nExt (fallback): " .. tostring(ext))

  --[[ alternatively...
  local options = {
    ["typst"] = function()
      local n1 = vim.fn.expand("%")
      local n2 = vim.fn.expand("%:r") .. ".pdf"
      termExec("(zathura " .. n2 .. " &) ; typst watch " .. n1 .. " " .. n2, true)
    end,
  }
  --]]
  if typ == "typst" then
    local n1 = vim.fn.expand("%")
    local n2 = vim.fn.expand("%:r") .. ".pdf"

    -- termExec("(zathura " .. n2 .. " &) ; typst watch " .. n1 .. " " .. n2, true)
    -- experimental: but below should load things IF they're not running.
    termExec("clear ; ([ $(ps aux | awk '{print $11$12}' | grep '^zathura" .. n2 .. "$') ] || zathura " .. n2 .. " &) ; [ $(ps aux | awk '{print $11$12}' | grep '^typstwatch$') ] || typst watch " .. n1 .. " " .. n2, true)
  elseif typ == "zig" then
    local path = getRunPath("build.zig")
    if path then -- file found
      termExec(" cd $(dirname ../" .. path .. ") && zig build && ./zig-out/bin/*", true)
    else
      -- vim.notify("nice try buddy!!!!")
      vim.notify("nah")
    end

  elseif typ == "gdscript" then
    runGodot()
  elseif typ == "" then
    vim.notify("No filetype detected.")
  elseif not typ then
    vim.notify("Could not fetch filetype. Possibly 'vim.opt.filetype._value' is no longer supported.")
  else
    c.RunCode()
  end
  --]]
end

k.set("n", "<leader>r", run, {desc = "Run your code."})
-- k.set("n", "<leader>???", function() vim.notify"code: run docs soon. (see tj tutorial)" end)
-- ^ goals: support lua; py; live-server/js; p5.js; binaries for crablang + c-based-langs

k.set("n", "<leader>cr", c.CompilerOpen, { desc = "CompilerOpen" }) -- compiler run
k.set("n", "<leader>ct", c.CompilerToggleResults, { desc = "CompilerToggleResults"})

k.set("n", "<leader>lo", function() c("!love %:h") end, {desc="Run with Love2D; assuming that parent is project root folder."})
k.set("n", "<leader>p5",
"<cmd>!xdg-open ~/p/p5-reference/index.html || xdg-open https://p5js.org/reference/ || open https://p5js.org/reference/<CR><CR>",
{ silent = false }) -- "open" not tested yet on Windows / MacOS.

-- <leader>cx is in lazy.lua if it still exists

--- Open terminal shortcuts
k.set("n", "<leader>zt", "<cmd>bo sp | winc 9-<CR><cmd>te<CR>")
k.set("n", "<leader>t", "<cmd>tabe | te<CR>")
k.set("n", "<leader>lt", function() vim.notify("Launching terminal commands is only available in visual mode.") end)
-- k.set("n", "<leader><CR>", c.te)

--- Buffer shortcuts
local function bd()
  local buffers_in_tab = #vim.fn.tabpagebuflist()
  if buffers_in_tab > 1 then
    c.bd()
  else
    c.tabc()
  end
end

k.set("n", "<leader>qb", bd, {desc=":bd Better delete buffer"})

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
k.set("n", "<leader>w", c.up, {desc="Write current file if not saved already."})
k.set("n", "<leader>zw", c.wa, {desc="Write all files if not saved already."})
k.set("n", "<leader>sq", c.xa, {desc="Session quit."})
k.set("n", "<leader>ze", c.vne)
k.set("n", "<leader>e", c.tabe)
-- k.set({"n", "v", "x"}, ";", ":", {desc="better cmd mode"}) -- vimothy mentioned
-- k.set({"n", "v", "x"}, ":", ";", {desc="better cmd mode"})

--- Working directory
local function keymCd(key, dir)
  k.set("n", "<leader>" .. key, function()
    if not dir then
      dir = "$HOME"
    end
    vim.notify("cwd: " .. dir)
    c("cd " .. dir)
  end)
end
keymCd("`")
-- k.set("n", "<leader>`", function()
--   c.cd()
--   vim.notify("cwd: ~")
-- end, {desc="Move cwd to ~"}) -- In future: if cd == ~ .. otherwise go to current dir

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

vim.keymap.set("n", "yp", function()
  -- string.gsub("original", "orig", "ori")
  local home = vim.cmd.echo("$HOME")
  -- vim.notify(home)
  local path = vim.fn.expand("%:p"):gsub(home, "")
  vim.fn.setreg("+", path)
  vim.notify("file: " .. path)
end, {desc="Yank full file path"})

--[[ above todo:
- Doesn't delete empty buffer. Avoid :bd!
- IP: Use marks instead of paragraph jumps. Otherwise date will be inserted incorrectly. Or changelist?
- Because of above, new lines don't work.
- g`"
--]]

k.set("n", "<leader>pv", c.Ex, { desc = "Project view :Ex"})
k.set("n", "<leader>qt", c.TodoLocList, { desc = "Location (quickfix) list :TodoLocList"})
k.set("n", "<leader>pd", function() vim.notify("stub: no prject dir fn")
end, { desc = "Project directory"})

k.set("n", "<leader>go", c.Godot)

vim.api.nvim_create_user_command("Date", i_date, {})
k.set("n", "<leader>da", i_date, {desc="Insert date"}) -- note: doesn't work on all distros and platforms for some reason

local function qrCmd(isVisual)
  -- c("!qrencode -t UTF8 \"" .. getClipboard():gsub('"', '\\"') .. '\""')
  local txt
  if isVisual then
    txt = getVSel()
    if txt:sub(-1) == "\n" then
      txt = txt:sub(1, -2)
    end
    vim.notify("visuallll")
  else
    txt = tostring(getReg())
    vim.notify("no visuallll")
  end

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
-- vim.api.nvim_create_user_command("Qr", function() qrCmd() end, {desc = "Note: This is different than the keybind for testing purposes."})
vim.api.nvim_create_user_command("TSPlaygroundToggle", function()
  vim.notify("nvim-treesitter/playground is deprecated for these dotfiles. Use :InspectTree, :Inspect, and (v0.10+) :EditQuery")
  vim.cmd.InspectTree()
end, {})
k.set("n", "<leader>kk", "<cmd>Screenkey<CR>", { desc = "Toggle displaying screenkey visibility."})
k.set("n", "<leader>kc", ":", { desc = "Enter command mode (Reason: My : key used to not work.)"})
k.set("i", "<c-/>", ":", { desc = "Write : (Reason: my : key used to not work.)"})
k.set("n", "<leader>z?", function()
  c.Screenkey()
  c("Outline!")
  local a,b = pcall(function() -- WARNING: There are unhandled errors - Example: https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup#open-for-files-and-no-name-buffers
    require("nvim-tree.api").tree.toggle({focus=false})
  end)
  if not a then
    vim.notify("Could not start nvim-tree: " .. b)
  end
end, { desc = "As seen on... coming soon."})

k.set("v", "<leader>qr", function() qrCmd("v") end, {desc="Get QR code from system clipboard (+ register)"})
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
  local txtLs = getVSel()
  local txts = vim.split(txtLs, ' ', {trimempty=true})
  local id

  for i = #txts, 1, -1 do
    -- local txt = vim.trim(txts[i]:gsub("[\n()]", ""))
    local txt = txts[i]:gsub("[\n()]", "")
    local t = string.find(txt, "&t=")
    if t then
      vim.notify("timestamp " .. string.sub(txt, t + 1) .. " has been found.. trimming.")
      txt = string.sub(txt, 1, t - 1)
    end
    if string.len(txt) >= 11 then
      local mybId = txt:sub(-11)
      if mybId:match("^[A-Za-z0-9-_]*$") then
        id = mybId
        break
      else vim.notify('nice try: ' .. tostring(txt))
      end
    end
  end

  if id then
    return id
  end
  vim.notify("That doesn't appear to be a valid yid. yid=" .. vim.inspect(id))
end

local function y2(cmdR, cmdL, conf)
  local id = getYId()
  local conf = conf or {}
  local cmdL = cmdL or ""
  if id then
    vim.notify(id)
    if string.sub(id, 1, 1) == "-" then
      id = "-- " .. id
    end
    if conf.bg then
      cmdR = "(" .. cmdR
      cmdL = cmdL .. " &)"
      vim.notify("EXPERIMENTAL: bg=true")
    end
    if conf.exitCmd then
      cmdR = "trap 'exit' SIGINT;clear;" .. cmdR
      cmdL = cmdL .. ";sleep 0.1;exit"
      vim.notify("EXPERIMENTAL v2: conf.exitCmd=true; cmd: " .. cmdR .. tostring(id) .. cmdL)
    end
    if conf.mvL then
      -- Link: https://www.youtube.com/watch?v=nvz0CpUavW0
      local mvL = string.len(id) + string.len(cmdL) + 1
      if tonumber(conf.mvL) then -- append how much more left
        conf.mvL = mvL + conf.mvL
      else
        conf.mvL = mvL
      end
      local tcL = getTermCode("<Left>")
      for _ = 1,conf.mvL do
        cmdL = cmdL .. tcL
      end
      if conf.exitCmd then
        vim.notify("WARNING: Exiting occurs after pressing enter when moving cursor.")
      end
    elseif conf.exitCmd then
      local tcCR = getTermCode("<CR>")
      -- cmdL = cmdL .. tcCR .. "exit" .. tcCR
      -- vim.notify("EXPERIMENTAL: conf.exitCmd=true; cmd: " .. cmdR .. tostring(id) .. cmdL)
      cmdL = cmdL .. tcCR
      vim.notify("EXPERIMENTAL v2: conf.exitCmd=true; cmd: " .. cmdR .. tostring(id) .. cmdL)
    end
    termExec(cmdR .. tostring(id) .. cmdL, not conf.mvL)
  end
end

k.set("v", "<leader>y2", function()
  -- y2("trap 'exit' SIGINT;clear;y2 0 ", ";exit") -- same as below, but verbose
  y2("y2 0 ", nil, {exitCmd=true})
end, {desc="Grab the yid in visual mode, then run it like this: y2 0 <id>"})

k.set("v", "<leader>y3", function()
  y2("trap 'exit' SIGINT;clear;y2 -x ", ";exit") -- verbose, same as exitCmd=true
  y2("y2 -x ", nil, {exitCmd=true}) -- verbose, same as exitCmd=true
end, {desc="Grab the yid in visual mode, then run it like this: y2 -x <id>"})

k.set("v", "<leader>y4", function()
  y2("y2  ", nil, {mvL=true, exitCmd=true})
end, {desc="Grab the yid in visual mode, then type it like this (* = cursor pos): y2 * <id>"})

k.set("v", "<leader>y9", function() vim.notify("yid = " .. tostring(getYId())) end)
-- k.set("n", "<leader>md") -- markdown delete duplicates (better name / etc. l8r)

k.set("v", "<leader>yg", function()
  y2("y2 -g ", nil, {exitCmd=true, bg=true})
end, {desc="Grab the yid in visual mode, then run in the background: `y2 -g <id>`."})

k.set("v", "<leader>yG", function()
  -- this doesn't work as an audio file
  y2("y2 -g ", nil)
end, {desc="Grab the yid in visual mode, then run: `y2 -g <id>`."})

k.set("n", "<leader>dc", function()
  -- sync conflict files made automatically by syncthing
  vsall(vim.fn.expand('%:r') .. ".sync-conflict-*")
end, {desc="Diff conflict files (might do more in future)"})

local isVisible = false
k.set("n", "<leader>ht", function()
  isVisible = not isVisible -- HACK: this may need to be run twice on other buffers since it doesn't keep track of what buffer it's on
  if isVisible then
    c.hi("Normal", "guifg=#333333", "guibg=#000000")
  else
    c.hi("Normal", "guifg=xxx", "guibg=Clear")
  end
end, { desc = "Less visible text. tags: invisible, hidden"})

k.set("n", "<leader>hv", function()
  vim.opt.ve = (vim.opt.ve:get()[1] == "block") and "all" or "block"
end, { desc = "Toggle virtual edit (cursor)"})

k.set("n", "<leader>hw", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "Toggle wrap"})

k.set("n", "<leader>hh", "<cmd>nohl<CR>", { desc = "Hide highlight after searching. tags: invisible, hidden"})
k.set("n", "<leader>hn", "<cmd>set nu! rnu!<CR>", { desc = "Toggle number + relative number. tags: invisible, hidden"})
k.set("n", "<leader>hs", toggleTs, { desc = "Toggle tree[s]itter. tags: invisible, hidden"})
k.set("n", "<leader>hl", "<cmd>LspStop ++force<CR>", { desc = "Force stop LSP servers. tags: invisible, hidden"})

-- -- future problem
-- vim.api.nvim_create_autocmd("NerdTreeAutocd", {
-- })

-- Autorun on save. Useful but not in this case. Useful example: .md -> .html
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   group = vim.api.nvim_create_augroup("Codeee", { clear = true }),
--   pattern = "project.godot",
--   callback = function()
--     c("!godot project.godot")
--   end,
-- })

-- !pup text{} | sed '/^\s*$/d' # doesn't work smh cuz sed and vim recognizing it differently... make new shell script i guess
