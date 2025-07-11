-- This file can be loaded by calling `lua require('frostynick.plugins')` from your init.vimlaz
-- keys for vim https://vimdoc.sourceforge.net/htmldoc/intro.html#key-notation
-- Migration: Lazy <--> Packer https://github.com/folke/lazy.nvim#packernvim


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop -- `vim.loop` planned to be removed in nvim 1.0 as of 2024-11-1
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

local function telescopeConfig()
  local ts = require"telescope"

  ts.setup({
    defaults = {
      -- layout_strategy = "vertical", -- better on vertical screens.
      layout_config = { width = 0.93 }
    },
    extensions = {
      file_browser = { hijack_netrw = true, }
    },
    media_files = {
      -- -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "pdf", "webm"},
      -- works with: foot, alacritty, rio
      -- doesn't work with: ghostty, (probably kitty since it works similarly?)
      -- find command (defaults to `fd`)
      find_cmd = "rg"
    }
    -- other configuration values here
  })

  local tsb = require('telescope.builtin')
  local k = vim.keymap
  -- vim.g.mapleader = ' '

  --- file browser shortcuts: https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
  k.set("n", "<leader>dl", tsb.diagnostics, {desc="LSP: Telescope diagnostics"})
  -- For some reason there is A being called after the below is run. Additionally
  -- adding over one Esc keys aren't recognized. Might report as bug.
  k.set("n", "<leader>vpv", "<cmd>Telescope keymaps<CR>ispacevp<Esc>");

  k.set('n', '<leader><leader>', tsb.spell_suggest, {})
  k.set('n', '<leader>,', tsb.oldfiles, { desc="Telescope: old files" })
  -- local a,b = pcall(function()
  --   -- k.set('n', '<leader>,', ts.extensions.frecency.frecency, { desc="Telescope: frecency" })
  --   k.del('n', '<leader>.')
  --   k.set('n', '<leader>.', "<cmd>Telescope frecency<CR>", { desc="Telescope: frecency" })
  -- end)
  -- if not a then
  --   vim.notify("Failed to load frecency keymap:\n"..tostring(b))
  -- end
  k.set('n', '<leader>b', tsb.buffers, { desc="Telescope: buffers" })
  k.set('n', '<leader>?', tsb.keymaps, { desc="Telescope: keymaps" })
  k.set('n', '<leader>f"', tsb.registers, { desc="Telescope: registers" })
  k.set('n', '<leader>f?', function() print"use <leader>fk instead" end)


  k.set('n', '<leader>fk', tsb.help_tags,
  { desc="Telescope: help tags (documentation)" })

  k.set('n', '<leader><BS>', tsb.resume,
  {desc="Telescope: use prev picker"})

  -- error: k.set('n', '<leader>f/', builtin.grep_files, {})
  -- k.set('n', '<leader>ff', builtin.find_files, {})
  k.set('n', '<leader>ff', "<cmd>Telescope find_files hidden=true<CR>",
  {desc="Telescope: find files"})

  k.set('n', '<leader>fj',
  -- '<cmd>Telescope find_files hidden=true search_dirs=$HOME/backup2022nov/*<CR>',
  '<cmd>Telescope find_files hidden=true search_dirs=$HOME/backup2022nov/<CR>',
  {desc="Telescope: find backup files; keyword: joplin"})

  k.set('n', '<leader>fc',
  '<cmd>Telescope find_files hidden=true search_dirs=$HOME/p/learnxinyminutes-docs<CR>',
  {desc="Telescope: offline code reference if learnxinyminutes-docs is git cloned in ~/p"})

  k.set('n', '<leader>gz', function() vim.notify("Use `2gx`.") end)

  k.set('n', '<leader>gj',
  '<cmd>Telescope live_grep search_dirs=$HOME/backup2022nov*/<CR>',
  {desc="Telescope: live grep (find text) in backup files; replacement to joplin. Requires rg."})

  k.set('n', '<leader>fm', "<cmd>Telescope man_pages<CR>", {})

  k.set('n', '<leader>fv', tsb.git_files, {desc="Telescope: git files"})
  k.set('n', '<leader>fg', tsb.live_grep, {desc="Telescope: live grep"})
  k.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", {desc="Telescope: see tags from todo-comments.nvim"})

  k.set('n', '<leader>f/', function()
    tsb.grep_string({ search = vim.fn.input("Grep > ") })
  end, {desc="Telescope: Grep string"})

  local function loadExtension(name, fn)
    local success,msg = pcall(function()
      ts.load_extension(name)
      if fn then fn() end
    end)
    if not success then
      vim.notify("Error loading telescope " .. name .. ": " .. msg)
    end
  end

  loadExtension("file_browser", function()
    k.set('n', '<leader>fb',
    "<cmd>Telescope file_browser<CR>", {desc="Telescope: file browser"})
  end)

  loadExtension("media_files", function()
    k.set('n', '<leader>fp',
    "<cmd>Telescope media_files<CR>", {desc = "Telescope: pictures; media files"})
  end)

  loadExtension("lazy", function()
    k.set('n', '<leader>fl',
    "<cmd>Telescope lazy<CR>", {desc = "Telescope: lazy plugin info"})
  end)

  -- require("telescope").load_extension("git_worktree")
  loadExtension("git_worktree", function()
    local gw = ts.extensions.git_worktree
    k.set('n', '<leader>gwn', function()
      gw.create_git_worktree()
    end, {desc = "Telescope: git worktree: new"})
    k.set('n', '<leader>gwv', function()
      gw.git_worktrees()
    end, {desc = "Telescope: git worktree: view"})
    -- <Enter> - switches to that worktree
    -- <c-d> - deletes that worktree
    -- <c-f> - toggles forcing of the next deletion
    -- Of course, also visible in <Esc>?
  end)

  loadExtension("ui-select")
  -- loadExtension("frecency")
end

local function lspConfig()
  local a,b = pcall(function()
    local path_mono_download = "$HOME/Apps/omnisharp-lsp-1.38.2/" -- not tested. may need to use /user/$HOME instead
    local lspc = require('lspconfig')
    require('lspconfig/configs')
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- For easy starting point see `:help lspconfig-all` or https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    local lspLs = {
      {
        'lua_ls',
        {
          -- There are no vim warnings everywhere with below code
          -- This is one solution to vim warnings if below code doesn't work for you:
          -- https://github.com/neovim/neovim/discussions/24119
          -- This option performs better if you are able to set it up with this:
          -- workspace.library is the bottle neck. I notice the speed improvement too. More info: https://luals.github.io/wiki/performance/
          on_init = function(client)
            local path = client.workspace_folders[1].name
            if uv.fs_stat(path..'/.luarc.json') or uv.fs_stat(path..'/.luarc.jsonc') then
              return
            end

            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME, -- nvim lua info shows up with this enabled
                  -- Depending on the usage, you might want to add additional paths here.
                  -- "${3rd}/luv/library"
                  -- "${3rd}/busted/library",
                }
              },
              telemetry = { enable = false },
              diagnostics = { globals = { 'Snacks' } }, -- remove global warnings for these variables
              runtime = { version = "LuaJIT" }
            })
          end,
          settings = { Lua = {} }
        },
      },
      {
        -- omnisharp is 1.38.2 and many guides seems to fallback to that version. My guess: I think it doesn't work on the version of Unity I have to use.
        -- https://dzfrias.dev/blog/neovim-unity-setup/
        -- FIX: (possibly fixed as of 2024-9-12 check again)
        -- So far doesn't work. Errors in unity. Will do more research
        -- if I have time to prioritize this...
        'omnisharp',
        {
          cmd = {
            'mono',
            '--assembly-loader=strict',
            path_mono_download .. '/omnisharp/OmniSharp.exe',
          },
          -- Assuming you have an on_attach function. Delete this line if you don't.
          -- on_attach = on_attach,
          use_mono = true,
        }
      },
      { -- https://github.com/aca/emmet-ls#configuration
        'emmet_ls', -- Installed from Mason
        {
          -- on_attach = on_attach,
          capabilities = capabilities,
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ["bem.enabled"] = true,
              },
            },
          }
        }
      },
      'bashls', 'denols', --[[denols might be deno]] 'pylsp',
      'rust_analyzer', 'ts_ls', 'zk', 'golangci-lint-langserver', 'gopls',
    }
    for _,v in ipairs(lspLs) do
      if type(v) ~= "table" then
        lspc[v].setup { capabilities = capabilities }
      else
        -- vim.notify(vim.inspect(v))
        lspc[v[1]].setup(v[2])
      end
    end
  end)
  if not a then
    print("failed to setup lspconfig: "..b)
  end
end
-- Example: invisiBkgd("ron")
-- Example #2: invisiBkgd(nil, true)
-- Example #3: invisiBkgd("vim", true)
-- ^^ colorscheme=vim with typos underlined + invisible background.

local function invisiBkgd(color, isSpell, showBg) -- NOTE: ColorMyPencils() is a duplicate of this function but global. ../../after/plugin/colors.lua
  local s = { bg = "none" }
  local a,b = pcall(function()
    if type(color) == "table" then
      color = color.name -- automatically passed from Lazy
    end
    if color then
      vim.cmd.colorscheme(color)
    end
  end)

  if not a then
    vim.notify("Could not apply colorscheme: "..tostring(b))
  end
  if not isSpell or type(isSpell) == "table" then -- empty table exists from Lazy
    vim.cmd.hi("clear", "SpellBad") -- removes highlight since I set spell to true by default
    vim.cmd.hi("clear", "SpellCap")
  end
  if not showBg then
    vim.api.nvim_set_hl(0, "Normal", s)
    vim.api.nvim_set_hl(0, "NormalFloat", s)
    vim.api.nvim_set_hl(0, "TelescopeNormal", s)
    vim.api.nvim_set_hl(0, "NormalNC", s)

    if tostring(color) ~= "hyper" and a then
      return
    end
    vim.notify("colorscheme switching is *not* supported after using hyper colorscheme. colorschemes may be broken.")
    -- below 2 lines add extra white text, but makes background invisible in outline.nvim window
    vim.api.nvim_set_hl(0, 'SpecialKey', s)
    vim.api.nvim_set_hl(0, 'NonText', s)

    vim.api.nvim_set_hl(0, 'EndOfBuffer', s)

    vim.api.nvim_set_hl(0, 'TabLineFill', s)
    vim.api.nvim_set_hl(0, 'TabLine', s)
    vim.api.nvim_set_hl(0, 'TabLineSel', s)

    vim.api.nvim_set_hl(0, 'LineNr', s)
    vim.api.nvim_set_hl(0, 'SignColumn', s)
  end
end

-- local function toggleZen(win) -- not working
--   local isZen = not not win:is_floating() -- not vim.wo.nu
local function toggleNotZen(isNotZen)
  vim.wo.wrap = isNotZen
  vim.wo.nu = isNotZen
  vim.wo.rnu = isNotZen
  vim.wo.colorcolumn = isNotZen and "80" or "0"
  local a,b = pcall(function()
    -- vim.cmd.GitGutterToggle()
    if isNotZen then
      vim.cmd.Gitsigns("attach")
    else
      vim.cmd.Gitsigns("detach")
    end
  end)
  if not a then
    vim.notify("Failed to toggle gitsigns.nvim: " .. tostring(b))
  end
end

local rainbow_delimiters
local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()

      require'nvim-treesitter.configs'.setup {
        -- A list of parser names,
        -- or "all" (five required parsers should always be installed)
        ensure_installed = "all",
        -- ensure_installed = { "rust", "javascript", "python", "c", "lua", "vim", "query", "vimdoc" },
        -- "vimdoc" might be "help" in <0.9.0 nvim.

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = {"lua"},
        },
      }
    end,
    --[[ commit that (in theory) supports nvim 0.8.0 - <0.9.1
    commit = "2aa9e9b0e655462890c6d2d8632a0d569be66482",
    -- [\#7272](https://github.com/nvim-treesitter/nvim-treesitter/pull/7272) raises minimum Neovim version >= v0.10.0. Need to stay on Nvim 0.9.2? Lock nvim-treesitter to v0.9.3.
    --]]
  },

  -- LSP Support
  { 'williamboman/mason.nvim', event = "VeryLazy"},-- Optional
  { 'williamboman/mason-lspconfig.nvim', -- b950110 fix: update required nvim version to >= 0.9.0 (#478) (2024-10-22)

    dependencies = { 'williamboman/mason.nvim' },
    event = "VeryLazy",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "rust_analyzer", --[[ "denols" ]] },
      }
    end
  }, -- Optional
  { 'neovim/nvim-lspconfig', event = "VeryLazy", config = lspConfig }, -- Required

  -- Autocompletion (taken with minimal changes from https://github.com/cpow/neovim-for-newbs/blob/7cee93b394359c2fee4f134d27903af65742247d/lua/plugins/completions.lua )
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        -- window = {
        --   completion = cmp.config.window.bordered(),
        --   documentation = cmp.config.window.bordered(),
        -- },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<C-e>"] = cmp.mapping.abort(), -- Not recommended in Termux
          ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Seems like new update automatically changed this to <CR>. Uncommenting and recommenting above fixed that for me, but any change will probably fix new update default.
        }),
        sources = cmp.config.sources({
          -- { name = "crates" }, -- rust crates.nvim -- the autocmd below does lazyloading which this line doesn't do.
          -- { name = "codeium" }, -- AI cmp. Should be easier to toggle for what file exists.
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "nvim_lua" },
        }, {
          { name = "buffer" },
        }),
      })

      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          cmp.setup.buffer({ sources = { { name = "crates" } } }) -- alternative cmp lazyloading way according to https://github.com/Saecki/crates.nvim/wiki/Documentation-v0.4.0
        end,
      })

      -- vim.api.nvim_create_autocmd("BufRead", {
      --   group = vim.api.nvim_create_augroup("CmpSourceCodeium", { clear = true }),
      --   pattern = "*.lua",
      --   callback = function()
      --     cmp.setup.buffer({ sources = { { name = "codeium" } } })
      --   end,
      -- })

    end,
  },

  -- uses ys; which stands for you surround; very powerful and must have if
  -- you know how to use it; see `:h nvim-surround.usage` for more info
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.4', -- tested to not break in Termux (0.1.5 breaks Termux)
    -- tag = '0.1.6', -- newest as of 2024 Apr 27. 
    tag = '0.1.8', -- newest as of 2024 Dec 22 
    -- or             , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = "VeryLazy",
    config = telescopeConfig,
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    dependencies = { 'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim' },
    event = "VeryLazy",
  },
  { 'nvim-telescope/telescope-ui-select.nvim', event = "VeryLazy", },
  { -- useful keybinds: https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
    "nvim-telescope/telescope-file-browser.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  { 'tsakirist/telescope-lazy.nvim', event = "VeryLazy" },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    -- lazy = false,
    keys = {
      {
        "<leader>ls",
        "<cmd>NvimTreeToggle<CR>",
        desc = "Toggle nvim tree",
        mode = "n",
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = true,
  },
  { 'TarunDaCoder/sus.nvim', event = "VeryLazy", config = true },
  { 'nmac427/guess-indent.nvim', event = "VeryLazy", config = true },
  {
    "nomnivore/ollama.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },

    keys = {
      -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>aio",
        ":<c-u>lua require('ollama').prompt()<cr>",
        desc = "ollama: prompt",
        mode = { "n", "v" },
      },

      -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
      {
        "<leader>aiG",
        ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
        desc = "ollama: Generate Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ai",
        ":Telescope keymaps<CR>>ai",
        desc = "Show AI keymaps",
        mode = { "n", "v" }
      }
    },
    config = true
  },
  {
    "pwntester/octo.nvim", -- tags: github gh
    cmd = "Octo",
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- or ibhagwan/fzf-lua
      'nvim-tree/nvim-web-devicons'
    },
    config = true
  },
  { -- this takes a couple MB ... might not be best idea if you're low on space
    "chrishrb/gx.nvim",
    -- it conflicts once in a while but usually saves time
    keys = { { "2gx", "<cmd>Browse<cr>", mode = { "n", "x" }} },
    cmd = { "Browse" },
    init = function()
      -- vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    -- config = true, -- default settings

    -- you can specify also another config if you want
    opts = {
      -- open_browser_app = "os_specific",
      -- -- below is an example if you want to use handlr instead of xdg-open
      -- open_browser_app = "handlr", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
      -- open_browser_args = { "open" }, -- specify any arguments, such as --background for macOS' "open".
      handlers = {
        plugin = true,
        github = true,
        brewfile = false, -- Homebrew
        package_json = true,
        search = false, -- search the web if nothing else is found
      },
      handler_options = {
        search_engine = "duckduckgo", -- select between google, bing, duckduckgo, and ecosia
        -- search_engine = "https://search.brave.com/search?q=", -- or custom search engine
      },
    },
  },
  { -- WARNING: minimum version 0.10.0 according to GitHub (based on my testing, 0.9.0 - 0.9.5 seem to work perfectly fine.)
    "NStefan002/screenkey.nvim",
    -- lazy = false,
    cmd = "Screenkey",
    version = "*", -- or branch = "dev", to use the latest commit
  },
  { 'saecki/crates.nvim', ft = "toml", tag = 'stable', config = true },
  -- visualize jump to character
  {
    'jinh0/eyeliner.nvim',
    event = "VeryLazy",
    opts = {
      highlight_on_key = true,
      -- dim = false
    }
  },
  { -- :DataView
    'vidocqh/data-viewer.nvim',
    -- opts = { autoDisplayWhenOpenFile = true, view = { float = false } },
    opts = { autoDisplayWhenOpenFile = true },
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "kkharji/sqlite.lua", -- Optional, sqlite support
    },
    -- ft = {"csv", "tsv", "sqlite"} -- This breaks autodisplay config
  },
  {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon'
    },
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim'
    }
  },
  { -- this does take 7MB space btw..
    "HiPhish/rainbow-delimiters.nvim",
    -- event = "VeryLazy",
    keys = {
      { "<leader>hr",
        function()
          if rainbow_delimiters then
            rainbow_delimiters.toggle() -- this should've been in README/docs.
            return
          end
          rainbow_delimiters = require'rainbow-delimiters'
          vim.g.rainbow_delimiters = {
            strategy = {
              [''] = rainbow_delimiters.strategy['global'],
              vim = rainbow_delimiters.strategy['local'],
            },
            query = { [''] = 'rainbow-delimiters', lua = 'rainbow-blocks', },
            priority = { [''] = 110, lua = 210, },
            highlight = {
              'RainbowDelimiterRed',
              'RainbowDelimiterYellow',
              'RainbowDelimiterBlue',
              'RainbowDelimiterOrange',
              'RainbowDelimiterGreen',
              'RainbowDelimiterViolet',
              'RainbowDelimiterCyan',
            },
          }
          rainbow_delimiters.enable()
        end, mode = "n",
        desc = 'Toggle rainbow delimiters. This may be sluggish in big files, when using animations, or changing the "strategy" config.'
      },
    },
  },
  -- markdown alternative to below: github.com/2kabhishek/tdo.nvim (may use this)
  {"iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install", -- NOTE: If lazy asks to remove and install while going from npm to yarn, do that and it should be fixed.
    -- build = "cd app && npm install", -- If using npm
    config = function() vim.g.mkdp_filetypes = { "markdown" } end,
  },
  { -- headlines.nvim but way better
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown", -- :RenderMarkdown
    config = function()
      require("render-markdown").setup({
        link = {
          custom = {
            youtube2 = { pattern = 'youtu%.be', icon = '󰗃 ' },
            twitter = { pattern = 'xcancel%.com', icon = ' '},
            twitter2 = { pattern = 'twitter%.com', icon = ' '},
            -- twitter3 = { pattern = 'x%.com', icon = '𝕏 '}, -- WARNING: this will match any domain that ends with "x.com" for example "roblox.com" or "xbox.com"
            arch = { pattern = 'archlinux%.org', icon = ' '},
            wikipedia = { pattern = 'wikipedia%.org', icon = '󰖬 '},
            google = { pattern = 'google%.com', icon = ' '},
            mozilla = { pattern = 'mozilla%.org', icon = '󰈹 '},
            trello = { pattern = 'trello%.com', icon = '󰔲 '},
            discord = { pattern = 'discord%.gg', icon = '󰙯 '},
            godot = { pattern = 'godotengine%.org', icon = ' '},

            itch = { pattern = 'itch%.io', icon = '󰺷 '},
            github2 = { pattern = 'githubusercontent%.com', icon = '󰊤 '},
          }
        }
      })
    end
  },
  { "dhruvasagar/vim-table-mode", cmd = "TableModeToggle",
    -- ft = "markdown"
  },
  -- PERF, HACK, TODO, NOTE, FIX, WARNING
  { "folke/todo-comments.nvim", config = true, event = "VeryLazy", },
  -- -- in theory, works with .puml files and probably other UML files:
  -- 'https://gitlab.com/itaranto/preview.nvim', version = '*', config = true

  { 'nacro90/numb.nvim', event = "VeryLazy", config = true }, -- non-intrusively preview while typing :432... 
  --- Colorschemes below. if you just uncomment and comment a plugin below, it will be the default. Personally, I don't want to load all the themes.
  { 'dasupradyumna/midnight.nvim', name = "midnight",
  lazy = true },
  { 'paulo-granthon/hyper.nvim', name = "hyper",
  lazy = true },
  { 'rose-pine/neovim', name = 'rose-pine',
  lazy = true },
  { 'rebelot/kanagawa.nvim', name = 'kanagawa',
  lazy = true },
  { 'AlexvZyl/nordic.nvim', name = 'nordic',
  lazy = true }, -- swap this line with "config = ..." to set as default theme
  { 'scottmckendry/cyberdream.nvim', name = 'cyberdream',
  config = invisiBkgd, }, -- init = invisiBkgd },

  { -- WARNING: Might remove later if there's a quicker alternative that has the same basic functionality.
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
    config = true
  },
  { -- Makes tabs more configurable + friendly.
    -- `:help tabby.txt` `:Tabby`
    'nanozuki/tabby.nvim',
    event = "VeryLazy",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = true,
    keys = {
      { "<leader>gtr", ":Tabby rename_tab ", mode = "n", desc = "Rename tab"},
    },
  },
  { -- WARNING: See below instructions for live server to work.
    'barrett-ruth/live-server.nvim',
    event = "VeryLazy",
    --[[ if switching from npm you can uninstall by (might need sudo):
    npm uninstall -g live-server
    yarn global add @compodoc/live-server # less security issues with this live-server command
    -- If it doesn't work after everything above has been done, try reinstalling this plugin. Then it should work.
    --]]
    -- alternative which probably isn't compatible: five-server
    -- build = 'npm install -g live-server', -- If using npm
    build = 'yarn global add @compodoc/live-server', -- in theory this is needed after installing this plugin. Couldn't test it right now.
    cmd = "LiveServerToggle", -- This is now built-in :)
    keys = {
      {
        "<leader>ll",
        -- vim.cmd.LiveServerToggle, -- not found
        ":LiveServerToggle<CR>",
        desc = "Toggle live server",
        mode = "n",
      },
    },
    config = true,
  },
  { -- Con: Appears to not usually work when multiple file are involved. Pro: Doesn't error like that other plugin..
    "aliqyan-21/runTA.nvim",
    cmd = "RunCode",
    config = function()
      require("runTA.commands").setup(
        {output_window_configs={transparent=true}})
    end,
  },
  --[[ Below has some more advanced features and supports different
  languages. It errors on neovim startup sometimes leading to a broken
  plugin, and is not as minimal, so I use above instead.
  github.com/Zeioth/compiler.nvim
  --]]
  {
    "davisdude/vim-love-docs",
    event = "VeryLazy",
    pin = true, -- there are errors on update, so this will stop updates.
    -- This plugin doesn't work out of the box.
    --[[ Extra steps to make this work:
    1. Get the dependencies.
    I wonder if the built-in luaJIT from Neovim works:
    - ~/.local/share/nvim/lazy/vim-love-docs/src/env.txt 
    `lua="lua"` to `lua="nvim -l"`

    2. Download file from instructions:
    https://github.com/davisdude/vim-love-docs/tree/master

    Place it in:
    ~/.local/share/nvim/lazy/vim-love-docs/src
    
    3. Run the file. There should be no errors.
    ]]
    -- 
  },
  -- not working for some reason 'm4xshen/autoclose.nvim',
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local p = require("nvim-autopairs")
      p.setup { check_ts = true }
      p.remove_rule('`')
    end
  },
  {
    -- auto-session alternative with more lua and telescope integration
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = true,
    cmd = { "PossessionLoad", "PossessionDelete", "PossessionSave" },
    keys = {
      { "<leader>stl", "<cmd>PossessionLoad temp<CR>", mode = "n", desc="possession: load temp session"},
      { "<leader>sts", "<cmd>PossessionSave temp<CR>", mode = "n", desc="possession: save temp session"},
      { "<leader>std", "<cmd>PossessionDelete temp<CR>", mode = "n", desc="possession: delete temp session"},
      { "<leader>ss", ":PossessionSave ", mode = "n", desc="possession: save a file"},
      { "<leader>sl", ":PossessionLoad ", mode = "n", desc="possession: load a file"},
      { "<leader>sd", ":PossessionDelete ", mode = "n", desc="possession: delete a file"},
      { "<leader>fs", "<cmd>Telescope possession list<CR>", mode = "n"},
    },
  },
  {
    'mbbill/undotree',
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, mode = "n" }
    }
  },
  {
    "NeogitOrg/neogit", -- new plugin here. Possible addition/alternative to vim-fugitive. Seems promising (neogit is keyboard shortcut based vs vim fugitive improving git command line)
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",           -- optional
      -- "echasnovski/mini.pick",      -- optional
    },
    keys = {
      { "<leader>2gs", function() vim.cmd("Neogit kind=vsplit") end, mode = "n", desc = "Open Neogit"},
      { "<leader>gl", function() vim.cmd("NeogitLogCurrent .") end, mode = "n", desc = "Open Neogit"},
    },
  },
  {
    'tpope/vim-fugitive',
    -- event = "VeryLazy",
    cmd = "Git",
    keys = {
      { "<leader>gs", vim.cmd.Git, mode = "n", desc = "Open Git Fugitive"},
    },
  },
  {'lewis6991/gitsigns.nvim', event = 'VeryLazy', -- requires v0.10+ unless you pin commit below
    -- commit = "3c76f7f", -- ci!: target Nvim 0.11, drop testing for 0.9.5 (2025 Mar 30)
    -- config = true, -- use default config
    opts = { -- :help gitsigns-usage
      signs = { add = { text = '+' }, },
      signs_staged = { add = { text = '+' }, },
      numhl     = true, -- `:Gitsigns toggle_numhl`
      word_diff = true, -- `:Gitsigns toggle_word_diff`
      current_line_blame = true, -- `:Gitsigns toggle_word_diff`
      current_line_blame_opts = {
        delay = 200, -- default: 1000
        virt_text_pos = 'right_align' -- default: next to text
      }
    },
    keys = {
      { "<leader>ghv", ":Gits preview_hunk<CR>",   mode = {"n", "v"}, desc = "Git Hunk: View"},
      { "<leader>ghs", ":Gits stage_hunk<CR>",     mode = {"n", "v"}, desc = "Git Hunk: Stage"},
      { "<leader>ghu", ":Gits undo_stage_hunk<CR>",mode = {"n", "v"}, desc = "Git Hunk: Reset"},
      { "<leader>ghr", ":Gits reset_hunk<CR>",     mode = {"n", "v"}, desc = "Git Hunk: Stage"},
      { "<leader>ghe", ":Gits select_hunk<CR>",    mode = {"n", "v"}, desc = "Git Hunk: Edit (select hunk with visual mode)"},
      { "<leader>ghn", ":Gits next_hunk<CR>",      mode = {"n", "v"}, desc = "Git Hunk: Jump next"},
      { "<leader>ghp", ":Gits prev_hunk<CR>",      mode = {"n", "v"}, desc = "Git Hunk: Jump prev"},
      { "<leader>gd", ":Gits diffthis<CR>", mode = {"n", "v"}, desc = "Git Diff" },
    }
    -- commit = "76927d14d3fbd4ba06ccb5246e79d93b5442c188", -- v0.8 support
  },
  {
    "2kabhishek/co-author.nvim",
    commit = "e6458cb9d42266336a92e750c9452ac12ee03079",
    cmd = "CoAuthor",
    keys = { -- this is the whole plugin btw just the below feature
      { "<leader>gC", vim.cmd.CoAuthor, desc = "Quickly add co-authors to git commits", mode = "n" }
    },
  },
  -- piersolenski/telescope-import.nvim Autofill imports. Supports JS; lua; py; c++.
  {
    "ThePrimeagen/git-worktree.nvim",
    event = "VeryLazy",
    -- config = function()
    --   require("telescope").load_extension("git_worktree")
    -- end
  },

  {'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = "VeryLazy",
    config = function()
      -- extremely basic setup is useful; has a ton of potential.
      -- see https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-move
      require'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer", ["if"] = "@function.inner",
              ["ac"] = "@class.outer",    ["ic"] = "@class.inner",
              ["ib"] = "@block.inner",    ["ab"] = "@block.outer",
               -- I replaced default s with a, since I do use "sentence" in vim
              ["ia"] = "@scope.inner",    ["aa"] = "@scope.outer",
              -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }
              -- How about inside of dates descriptions, like for
              -- a log or journal?
            }
          }
        }
      }
    end
  },
  {
    -- alternative that relies on telescope instead of vim.ui.select: https://github.com/nvim-telescope/telescope-symbols.nvim
    "ziontee113/icon-picker.nvim", -- Useful for emoji's too. See github for more info (use gz with my config to open up the link :) )
    -- One thing that could improve this is a freqently used list or previous emojis or filter to sometimes use exclusively emojis or icons.
    opts = { disable_legacy_commands = true },
    keys = {
      { "<c-e>", vim.cmd.IconPickerInsert, desc = "Pick icons and emojis", mode = "i" }
    },
    -- event = "VeryLazy"
  },

  -- no longer works on here. probably bc of another plugin.
  -- 'airblade/vim-rooter',               -- 0.54 ms, 0.6 ms, 0.46 ms, 0.37 ms
  -- slower + doesn't work for me rn { 'notjedi/nvim-rooter.lua', --[[ 1.3 ms 0.44 ms 0.94 ms 0.47 ms 1.01 ms (not switching now 1ms 0.49 ms 0.61 ms ) ]] config = function() require'nvim-rooter'.setup() end },
  -- { "norcalli/nvim-colorizer.lua", event = "VeryLazy", config = true}, -- requires nvim 0.4+
  { "NvChad/nvim-colorizer.lua", event = "VeryLazy", config = true }, -- requires nvim 0.7+; active fork that always works + fastt
  { 'numToStr/Comment.nvim', event = "VeryLazy", config = true },
  { -- Improved simrat39/symbols-outline
    "hedyhli/outline.nvim",
    -- url = "https://git.sr.ht/~hedy/outline.nvim" -- can replace above
    lazy = true,
    cmd = "Outline",
    -- event = "VeryLazy",
    keys = {
      { "<leader>zo", "<cmd>Outline!<CR>",
      desc = "Code outline. Previously :SymbolsOutline. Can be used with :Outline" },
    },
    opts = {
      symbols = {
        filter = {
          default = {"String", "Variable", exclude = true},
          lua = {"Function", "Class"}
        },
        icon_fetcher = function() return "" end, -- remove all icons
      },
      -- symbol_folding = { autofold_depth = false, }, -- unfold everything by default
      outline_items = { show_symbol_lineno = true, }, -- Line number of file. Super useful.
    }
  },
  --- 2 games below
  -- :Speedtyper to start typing practice
  { 'NStefan002/speedtyper.nvim', cmd = "Speedtyper", config = true },
  { 'alec-gibson/nvim-tetris', cmd = "Tetris" },
  -- leetcode: https://github.com/kawre/leetcode.nvim . Requires v0.9.0. See requirements b4 installing.
  -- currently not working: https://github.com/glacambre/firenvim/blob/master/TROUBLESHOOTING.md
  -- Below is made for browser extension firenvim.
  -- {
  --   "glacambre/firenvim",
  --   event = "VeryLazy",
  --   -- lazy = not vim.g.started_by_firenvim,
  --   -- module = false,
  --   build = function()
  --     vim.fn["firenvim#install"](0)
  --   end,
  -- },

  -- automatically add "end" to code-block. note: possible issues with autocomplete if that is enabled
  { 'tpope/vim-endwise', event = "InsertEnter" },
  -- see how regex works with :Hypersonic
  { "tomiis4/hypersonic.nvim", cmd = "Hypersonic" },
  --[[ Below does the same as vim-sudo but:
  - rewritten in lua
  - no noticable improvement performace-wise.
  - zero stars
  --]] -- { "airglow923/suda.nvim", config = true,
  -- commit = "e5684c7395fede814bddb85dc39d14175a8f19c8" },
  -- { -- basically adds "sudo write"
  --   "lambdalisue/vim-suda",
  --   -- BUG: Seems to not work? At least not reliably. I write the command, there's no errors, and it just doesn't save the changes. That's a deal breaker for me even if it might technically work sometimes.
  --
  --   cmd = {"SudaRead", "SudaWrite"},
  --   -- WARNING: Might need to update in the future.
  --   commit = "b97fab52f9cdeabe2bbb5eb98d82356899f30829",
  --
  --   config = true
  -- },
  -- below: nvim terminal opens nvim without nested nvim (so much better!)
  -- No mention of alacritty or foot in readme, but it
  -- works out of the box there too.
  {
    "willothy/flatten.nvim",
    -- config = true,
    -- or pass configuration with:
    opts = { -- :help flatten.nvim-configuration
      -- window = { open = "vsplit" }
      window = { open = "alternative" }
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    commit = "cc3d8f7", -- drop nvim 0.9 support without this commit
    priority = 999,
  },

  --[[ HTTP REST-Client Interface
  Requirements: nvim 0.10+ (according to docs not tested below)
  Run `:TSInstall http`
  For optional dependencies:
  [Requirements | Kulala.nvim](https://kulala.mwco.app/docs/requirements)
  Quick way to test this works: create file `test.http` with contents:
  `GET https://meowfacts.herokuapp.com/ HTTP/1.1`
  and run the code.. should return random cat fact if website still works. ]]
  { "mistweaverco/kulala.nvim", ft = "http", config = true,
    -- config = function()
    --   local k = require('kulala')
    --   k.setup({debug = true, additional_curl_options = {"-v"}})
    --   vim.keymap.set('n', '<leader>zr', k.run)
    -- end
  },
  { -- Better default terminal. (auto enter insert mode; auto-close process when done; etc.)
    '2kabhishek/termim.nvim',
    event = "VeryLazy", -- weirdly enough, below no longer works so lazyloading it is!
    cmd = { 'Fterm', 'FTerm', 'Sterm', 'STerm', 'Vterm', 'VTerm' },
    -- commit = "5834416", -- WARNING: not updated to prevent breaking workflow
  },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
  {
    "stevearc/oil.nvim",
    cmd = { "Oil", "Ex", "Hex", "Lex", "Vex", "Tex", "Sex"},
    config = function()
      require("oil").setup({
        -- default_file_explorer = true -- :Ex works
        -- columns = {
        --   "icon", "permissions", "size", "mtime"
        -- },
        view_options = { show_hidden = true }
      })
      -- vim.api.nvim_create_user_command("Ex", ":Oil", {})
      for _,v in ipairs({"Ex", "Hex", "Lex", "Vex", "Tex", "Sex"}) do
        vim.api.nvim_create_user_command(v, ":Oil", {})
      end
    end
  },
  { -- requires: yazi 0.4.0 or later; nvim 0.10.2+ to be useful
    "mikavilpas/yazi.nvim",
    cmd = "Yazi",
    -- commit = "98db026",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>zv",
        mode = { "n", "v" },
        vim.cmd.Yazi,
        desc = "(nvim 0.10.2+) Open yazi at the current file ya[z]i [v]iew",
      },
      {
        -- Open in the current working directory
        "<leader>z.",
        "<cmd>Yazi cwd<cr>",
        desc = "(nvim 0.10.2+) Open yazi file manager in nvim's working directory",
      },
      {
        "<leader>z<BS>",
        "<cmd>Yazi toggle<cr>",
        desc = "(nvim 0.10.2+) Resume the last yazi session",
      },
    },
    opts = {
      open_for_directories = false, -- if false, leave alone netrw
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  { -- requires nvim 0.9.4 according to readme
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = { -- See: https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
      bigfile = { enabled = true },
      -- dashboard = { enabled = true }, -- homescreen for nvim
      -- indent = { enabled = true }, -- visualize current line. might be useful for you! i just don't like it with transparent theme that much .. and rnumber is visible enough
      -- input = { enabled = true }, -- alternative to 'nvim-telescope/telescope-ui-select.nvim'. Not usable with icon-picker: has over 10000 results with ui-select that I can't skip/search.
      notifier = { enabled = true, timeout = 5000 --[[in ms]] }, -- timeout default=3000ms; better alternative to 'rcarriga/nvim-notify'
      quickfile = { enabled = true }, -- render file before plugins
      -- scroll = { -- smooth scroll. too slow with a specific plugin I use. I guess this can be good for testing performance.
      --   animate = {
      --     duration = { step = 10, total = 100 }, -- 0.1 second delay
      --     easing = "linear",
      --   },
      -- },
      zen = {
        on_open = function() toggleNotZen(false) end,
        on_close = function() toggleNotZen(true) end,
      }
    },
    keys = {
      { "<leader>zs", function() Snacks.zen() end, desc = "Toggle Zen Mode" }, -- s = skim-read mode as i call it
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>vn", function() Snacks.notifier.show_history() end, desc = "View All Notifications" },
      { "<leader>fr", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>2gr",function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" }, -- doesn't replace 'f-person/git-blame.nvim'
      { "<leader>hn", function() Snacks.notifier.hide() end, desc = "Hide All Notifications" },
  --     { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
  --     { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
  --     { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
  --     { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
  --     { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
  --     { "<leader>3gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    },
  },
  -- {
  --   "jake-stewart/multicursor.nvim",
  --   event = "VeryLazy",
  -- },
}
--[[
-- alternative plugins maybe
  kkoomen/vim-doge -- if I ever need to add documentation to code, this makes it faster. keymaps can be changed: https://github.com/kkoomen/vim-doge#gdoge_enable_mappings
  ray-x/web-tools.nvim
  ap/vim-css-color -- hex color
  erryma/vim-multiple-cursors
  -- best for notetaking:
    set linebreak
    set spell [spelllang=en_us]
    https://youtu.be/NmIatTT0MLc?t=388 " spell check usage w/ shortcuts
  vim-hexokinaste - css colors
  sudoedit
  vim-closetag
  https://twitter.com/learnvim - future problem
  -- { -- error: couldn't find github username
  --   'vimdev/lspsaga.nvim', },
  -- takes over S and s btw [backdround/improved-ft.nvim: Improve default f/t hop abilities](https://github.com/backdround/improved-ft.nvim)
  -- norcalli/nvim-terminal.lua
  -- { 'stevearc/oil.nvim', config = true },
  -- rm homepage. I don't really want it.
  -- new alt to which-key: Cassin01/wf.nvim
  -- new thing that depends on which-key: roobert/surround-ui.nvim -- for nvim-surround help
  -- { "folke/which-key.nvim", },
  -- {'andweeb/presence.nvim', event="VeryLazy"}, -- Not working with BetterDiscord so far. Tried: `ln -svf $XDG_RUNTIME_DIR/{app/com.discord.Discord,}/discord-ipc-0` and `ln -svf $XDG_RUNTIME_DIR/{app/com.discordapp.Discord,}/discord-ipc-0`
-- troubleshooting --
nvim 0.9+
vim.print(plugins)

nvim 0.8.x
vim.pretty_print(plugins)

nvim - any version with lua support
for k,v in pairs(plugins) do
  print(k,v)
end
]]

require("lazy").setup(plugins, {})


-- vim.print(plugins);
vim.g.neovide_scale_factor = 0.7

-- Run this also to make it work: `:TSInstall http`
-- Adds treesitter (for highlighting so far) to HTTP files.
vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})
