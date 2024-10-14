-- This file can be loaded by calling `lua require('frostynick.plugins')` from your init.vimlaz
-- keys for vim https://vimdoc.sourceforge.net/htmldoc/intro.html#key-notation
-- Migration: Lazy <--> Packer https://github.com/folke/lazy.nvim#packernvim


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then -- "vim.loop" will be deprecated in nvim 1.0 as of 2024-9-1
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
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
            filetypes = {"png", "webp", "jpg", "jpeg"},
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
    k.set('n', '<leader>fo', function() print("use <leader>. instead") end)
    -- local a,b = pcall(function()
    --     -- k.set('n', '<leader>,', ts.extensions.frecency.frecency, { desc="Telescope: frecency" })
    --     k.del('n', '<leader>.')
    --     k.set('n', '<leader>.', "<cmd>Telescope frecency<CR>", { desc="Telescope: frecency" })
    -- end)
    -- if not a then
    --     vim.notify("Failed to load frecency keymap:\n"..tostring(b))
    -- end
    k.set('n', '<leader>b', tsb.buffers, { desc="Telescope: buffers" })
    k.set('n', '<leader>?', tsb.keymaps, { desc="Telescope: keymaps" })
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
    '<cmd>Telescope find_files hidden=true search_dirs=/home/nicholas/backup2022nov*/<CR>',
    {desc="Telescope: find backup files; keyword: joplin"})

    k.set('n', '<leader>fc',
    '<cmd>Telescope find_files hidden=true search_dirs=/home/nicholas/p/<CR>',
    {desc="Telescope: find code in projects directory"})

    k.set('n', '<leader>gj',
    '<cmd>Telescope live_grep search_dirs=/home/nicholas/backup2022nov*/<CR>',
    {desc="Telescope: live grep (find text) in backup files; replacement to joplin. Requires rg."})

    k.set('n', '<leader>fm', "<cmd>Telescope man_page<CR>", {})

    k.set('n', '<leader>fv', tsb.git_files, {desc="Telescope: git files"})
    k.set('n', '<leader>fg', tsb.live_grep, {desc="Telescope: live grep"})
    k.set('n', '<leader>ft', "<cmd>TodoTelescope<CR>", {desc="Telescope: see tags from todo-comments.nvim"})

    k.set('n', '<leader>f/', function()
        tsb.grep_string({ search = vim.fn.input("Grep > ") })
    end, {desc="Telescope: Grep string"})

    local function loadExtension(name, fn)
        local success,msg = pcall(function()
            ts.load_extension(name)
            if fn then
                fn()
            end
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

    -- nvim-telescope/telescope-ui-select.nvim
    loadExtension("ui-select")
    loadExtension("possession")

    -- loadExtension("frecency")
end

local function lspConfig()
    local a,b = pcall(function()
        local path_mono_download = "/home/nicholas/Apps/omnisharp-lsp-1.38.2/"
        local lspc = require('lspconfig')
        local lspLs = {
            {
                'lua_ls',
                {
                    -- there are no vim warnings everywhere with below code
                    -- src for below: https://github.com/neovim/neovim/discussions/24119
                    on_init = function(client)
                        local path = client.workspace_folders[1].name
                        if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                            return
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            -- runtime = {
                            --     -- Tell the language server which version of Lua you're using
                            --     -- (most likely LuaJIT in the case of Neovim)
                            --     version = 'LuaJIT'
                            -- },
                            -- Make the server aware of Neovim runtime files
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME
                                    -- Depending on the usage, you might want to add additional paths here.
                                    -- "${3rd}/luv/library"
                                    -- "${3rd}/busted/library",
                                }
                                -- or pull in all of 'runtimepath'. note: this is a lot slower
                                -- library = vim.api.nvim_get_runtime_file("", true)
                            },
                            telemetry = { enable = false },
                        })
                    end,
                    settings = {
                        Lua = {}
                    }
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
                    on_attach = on_attach,
                    use_mono = true,
                }
            },
            'bashls', 'denols', --[[denols might be deno]] 'emmet_ls', 'pylsp',
            'rust_analyzer', 'ts_ls', 'zk',
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
local function invisiBkgd(color, isSpell) -- NOTE: ColorMyPencils() is a duplicate of this function but global. ../../after/plugin/colors.lua
    local a,b = pcall(function()
        if type(color) == "table" then
            color = color.name -- automatically passed from Lazy
        end
        if not color then
            color = "midnight"
        end
        vim.cmd.colorscheme(color)
    end)
    if not a then
        vim.notify("Could not apply colorscheme: "..tostring(b))
    end

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

    if not isSpell then
        vim.cmd.hi("clear", "SpellBad") -- removes highlight since I set spell to true by default
        vim.cmd.hi("clear", "SpellCap")
    end
end

local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()

            require'nvim-treesitter.configs'.setup {
                -- A list of parser names,
                -- or "all" (five required parsers should always be installed)
                ensure_installed = { "rust", "javascript", "python", "c", "lua", "vim",
                "query", "vimdoc" },
                -- "vimdoc" might be "help" in some cases. When I tested v0.8.3 nvim on
                -- another device it seems to still use vimdoc instead of help.

                -- end
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
        -- commit that (in theory) supports nvim 0.8.0 - <0.9.1
        -- commit = "2aa9e9b0e655462890c6d2d8632a0d569be66482",
    },

    -- LSP Support
    { 'williamboman/mason.nvim', event = "VeryLazy"},-- Optional
    { 'williamboman/mason-lspconfig.nvim',
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
                --     completion = cmp.config.window.bordered(),
                --     documentation = cmp.config.window.bordered(),
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
            --     group = vim.api.nvim_create_augroup("CmpSourceCodeium", { clear = true }),
            --     pattern = "*.lua",
            --     callback = function()
            --         cmp.setup.buffer({ sources = { { name = "codeium" } } })
            --     end,
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
    -- visualize jump to character
    {
        'jinh0/eyeliner.nvim',
        event = "VeryLazy",
        opts = {
            highlight_on_key = true,
            dim = false
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4', -- tested to not break in Termux (0.1.5 breaks Termux)
        -- tag = '0.1.6', -- newest as of 2024 Apr 27. 
        -- or                       , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        event = "VeryLazy",
        config = telescopeConfig,
    },
    { 'nvim-telescope/telescope-media-files.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim' },
        event = "VeryLazy",
    },
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
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },

        -- All the user commands added by the plugin
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
        -- event = "VeryLazy",
        -- it conflicts once in a while but usually saves time
        keys = { { "gz", "<cmd>Browse<cr>", mode = { "n", "x" }} },
        cmd = { "Browse" },
        init = function ()
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
    -- { -- testing nvim plugin ... Very useful, but it needs an easier way to toggle on and off. An online AI tool should not see every file by default. Maybe just python and rust files and should be opt-in.
    --     -- If below is not commented out, also uncomment this in cmp. FIX: codeium should only be enabled when it's supposed to be enabled imo
    --     "Exafunction/codeium.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     event = "VeryLazy",
    --     config = true,
    --     -- config = function()
    --     --     require("codeium").setup({
    --     --     })
    --     -- end
    -- },
    -- { --[[ commented out codeium for now because
    --  * Termux: Doesn't work + errors + planned to not be supported.
    --  * It gets a bit in the way when trying to do projects. Opt-in would be
    --  better (honestly not that hard to add).
    --  * Not mindful of built-in vim features when useful vim keybinds are
    --  overrided on default config on Github such as <c-x>.
    --  * Will I really miss this? Is there really much benefit?
    --  ]]
    --     'Exafunction/codeium.vim',
    --     event = "VeryLazy",
    --     config = function()
    --         vim.g.codeium_disable_bindings = 1 -- disable codeium bindings
    --         -- Change '<C-g>' here to any keycode you like.
    --         local expT = { expr = true, desc = "Codeium keybinds. Located in lazy.lua" }
    --         local k = vim.keymap
    --         local function c(viM, codeM, n)
    --             k.set('i', '<c-' .. viM .. '>', function()
    --                 return vim.fn['codeium#' .. codeM](n)
    --             end, expT)
    --         end
    --
    --         local function i(viM, codeM)
    --             k.set('i', '<c-' .. viM .. '>', function()
    --                 return vim.fn['codeium#' .. codeM]()
    --             end, expT)
    --         end
    --
    --         i('g', 'Accept')
    --         -- using :CodiumToggle instead of Clear.
    --         c(';', 'CycleCompletions', 1)
    --         c(',', 'CycleCompletions', -1)
    --
    --         -- Toggle instead of Disable would be better. I rarely turn it back on though so not big enough concern for me do to anything about it.
    --         k.set('n', '<leader>cx', vim.cmd.CodeiumDisable, { desc = "Codeium: Calls `:DisableCodeium`" })
    --
    --     end
    -- },
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
    { -- NOTE: remove neorg in future?
        "nvim-neorg/neorg",
        ft = "norg",
        -- build = ":Neorg sync-parsers", -- if in doubt, :Lazy build neorg 
        dependencies = { "nvim-lua/plenary.nvim" },
        -- event = "VeryLazy",
        version = "v7.0.0", -- v8.0.0 might not work in Termux because luarocks has issues there. Plus, it requires (at least for now) more setup and this config should be easy to start on any device.
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                -- https://github.com/nvim-neorg/neorg/wiki/Concealer
                ["core.concealer"] = {
                    config = { --[[ folds = false, ]]
                    icon_preset = "diamond"
                }
            },                  -- Adds pretty icons to your documents
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = { notes = "~/backup2022nov10/notes" },
                },
            },
            -- ["core.keybinds"] = {
            --     config = {
            --         default_keybinds = false
            --     }
            -- },
            ["core.export"] = {},
            ["core.export.markdown"] = {
                config = { extensions = "all", },
            },
        },
        },
    },
    {"iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install", -- NOTE: If lazy asks to remove and install while going from npm to yarn, do that and it should be fixed.
        -- build = "cd app && npm install", -- If using npm
        config = function() vim.g.mkdp_filetypes = { "markdown" } end,
    },
    { -- headlines.nvim but way better
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown", -- :RenderMarkdown
    },
    { "dhruvasagar/vim-table-mode", cmd = "TableModeToggle",
        -- ft = "markdown"
    },
    -- PERF, HACK, TODO, NOTE, FIX, WARNING
    { "folke/todo-comments.nvim", config = true, event = "VeryLazy", },
    -- -- in theory, works with .puml files and probably other UML files:
    -- 'https://gitlab.com/itaranto/preview.nvim', version = '*', config = true

    {'nacro90/numb.nvim', event = "VeryLazy", config = true }, -- non-intrusively preview while typing :432... 
    --- Colorschemes below
    {'dasupradyumna/midnight.nvim', name = "midnight", lazy = false, priority = 998, init = invisiBkgd },
    -- { 'rose-pine/neovim', name = 'rose-pine', init = ColorMyPencils, event = "VeryLazy" },
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     name = 'nordic',
    --     event = "VeryLazy",
    --     opts = {
    --         telescope = {style = 'classic'}
    --     }
    -- },
    -- { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
    { -- WARNING: Might remove later if there's a quicker alternative that has the same basic functionality.
        'nvim-lualine/lualine.nvim',
        -- event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        config = true
    },
    { -- NOTE: See below instructions for live server to work.
        'barrett-ruth/live-server.nvim',
        event = "VeryLazy",
        -- cmd = "LiveServerStart",  -- Note: "LiveServerToggle" isn't in plugin.
        --[[ if switching from npm you can uninstall by (might need sudo):
        npm uninstall -g live-server
        yarn global add @compodoc/live-server # less security issues with this live-server command
        -- If it doesn't work after everything above has been done, try reinstalling this plugin. Then it should work.
        --]]
        -- build = 'npm install -g live-server', -- If using npm
        build = 'yarn global add @compodoc/live-server', -- in theory this is needed after installing this plugin. Couldn't test it right now.
        config = function() -- should be in init some of this maybe. fix later. slows down start time slightly.
            local l = require('live-server')
            l.setup( --[[ args = {"--browser=librewolf"} ]])
            vim.g.liveservertoggle = true
            vim.keymap.set('n', '<leader>ll', function()
                if vim.g.liveservertoggle then
                    l.start()
                else
                    l.stop()
                end
                vim.g.liveservertoggle = not vim.g.liveservertoggle
            end)
        end,
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
    { -- useful keybinds: https://github.com/nvim-telescope/telescope-file-browser.nvim#mappings
        "nvim-telescope/telescope-file-browser.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
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
    {'airblade/vim-gitgutter', event = "VeryLazy" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local p = require("nvim-autopairs")
            p.setup { check_ts = true }
            p.remove_rule('`')
        end
    },
    {'nvim-treesitter/playground', cmd = "TSPlaygroundToggle"},
    {
        -- auto-session alternative with more lua and telescope integration
        'jedrzejboczar/possession.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
        config = true,
        event = "VeryLazy",
        keys = {
            { "<leader>stl", "<cmd>PossessionLoad temp<CR>", mode = "n", desc="possession load temp session"},
            { "<leader>sts", "<cmd>PossessionSave temp<CR>", mode = "n", desc="possession save temp session"},
            { "<leader>ss", ":PossessionSave ", mode = "n", desc="possession save a file"}, -- write
            { "<leader>sl", ":PossessionLoad ", mode = "n", desc="possession load a file"}, -- read
            { "<leader>fs", "<cmd>Telescope possession list<CR>", mode = "n"},
        },
    },
    {
        'mbbill/undotree',
        cmd = "UndotreeToggle",
        init = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)-- "<cmd>UndotreeToggle<CR>")
        end,
    },
    {
        'tpope/vim-fugitive',
        event = "VeryLazy",
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git);
        end,
    },
    { 'f-person/git-blame.nvim', event = "VeryLazy" }, -- shows git blame
    {
        'folke/zen-mode.nvim',
        cmd = "ZenMode", -- avoid these if on startup
        -- event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "<leader>zz", function()
                vim.cmd.ZenMode()
                vim.wo.wrap = false
                -- not working ColorMyPencils()
            end)
        end,
        -- config = function()
        --     require("zen-mode").setup {
        --         -- same as opts below
        --     }
        -- end,
        opts = {
            window = {
                backdrop = 0,
                height = 0.7,
                -- width = 90,
                width = 0.9,
                options = {
                    number = false,
                    relativenumber = false,
                },
            },
            plugins = {
                kitty = {
                    enabled = true,
                    font = "+4",
                },
                -- wezterm = { -- will probably use wezterm in the future
                --     enabled = true,
                --     font = "+4",
                -- },
            },
        }
    },
    -- piersolenski/telescope-import.nvim Autofill imports. Supports JS; lua; py; c++.

    -- pins function names/definitons outside visible view
    -- {'nvim-treesitter/nvim-treesitter-context', event = "VeryLazy" }, -- This is erroring a lot so I disabled it for now. Due to [Crash on empty first line when number line is on (markdown) · Issue #442 · nvim-treesitter/nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context/issues/442)
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
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["ib"] = "@block.inner",
                            ["ab"] = "@block.outer",
                             -- I replaced default s with a, since I do use "sentence" in vim
                            ["ia"] = "@scope.inner",
                            ["aa"] = "@scope.outer",
                            -- ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" }
                            -- How about inside of dates descriptions, like for
                            -- a log or journal?
                        }
                    }
                }
            }
        end
    },
    { 'nvim-telescope/telescope-ui-select.nvim', lazy = true },
    {
        "ziontee113/icon-picker.nvim", -- Useful for emoji's too. See github for more info (use gz with my config to open up the link :) )
        -- One thing that could improve this is a freqently used list or previous emojis or filter to sometimes use exclusively emojis or icons.
        opts = { disable_legacy_commands = true },
        keys = {
            { "<c-e>", vim.cmd.IconPickerInsert, desc = "Pick icons and emojis", mode = "i" }
        },
        -- event = "VeryLazy"
    },

    -- no longer works on here. probably bc of another plugin.
    -- 'airblade/vim-rooter',                     -- 0.54 ms, 0.6 ms, 0.46 ms, 0.37 ms
    -- slower + doesn't work for me rn { 'notjedi/nvim-rooter.lua', --[[ 1.3 ms 0.44 ms 0.94 ms 0.47 ms 1.01 ms (not switching now 1ms 0.49 ms 0.61 ms ) ]] config = function() require'nvim-rooter'.setup() end },
    -- { "norcalli/nvim-colorizer.lua", event = "VeryLazy", config = true}, -- requires nvim 0.4+
    { "NvChad/nvim-colorizer.lua", event = "VeryLazy", config = true }, -- requires nvim 0.7+; active fork that always works + fastt
    { 'numToStr/Comment.nvim', event = "VeryLazy", config = true },
    { -- Improved simrat39/symbols-outline
        "hedyhli/outline.nvim",
        -- url = "https://git.sr.ht/~hedy/outline.nvim" -- can replace above
        lazy = true,
        -- cmd = "Outline",
        event = "VeryLazy",
        keys = {
            { "<leader>zo", "<cmd>Outline!<CR>", desc = "Code outline. Previously :SymbolsOutline. Can be used with :Outline" },
        },
        config = function()
            require("outline").setup({
                symbols = {
                    filter = {
                        default = {"String", "Variable", exclude = true},
                        lua = {
                            'Function', 'Class'
                        }
                    },
                    icon_fetcher = function() return "" end, -- remove all icons
                },
                symbol_folding = {
                    autofold_depth = false, -- unfold everything by default
                },
                outline_items = {
                    show_symbol_lineno = true, -- Line number of file. Super useful.
                },
            })
            vim.cmd("Outline!") -- launch this by default
        end,
    },
    --- 2 games below
    -- :Speedtyper to start typing practice
    { 'NStefan002/speedtyper.nvim', cmd = "Speedtyper", config = true },
    { 'alec-gibson/nvim-tetris', cmd = "Tetris" },
    -- leetcode: https://github.com/kawre/leetcode.nvim . Requires v0.9.0. See requirements b4 installing.
    -- currently not working: https://github.com/glacambre/firenvim/blob/master/TROUBLESHOOTING.md
    -- Below is made for browser extension firenvim.
    -- {
    --     "glacambre/firenvim",
    --     event = "VeryLazy",
    --     -- lazy = not vim.g.started_by_firenvim,
    --     -- module = false,
    --     build = function()
    --         vim.fn["firenvim#install"](0)
    --     end,
    -- },

    -- automatically add "end" to code-block. note: possible issues with autocomplete if that is enabled
    { 'tpope/vim-endwise', event = "InsertEnter" },
    {
        'rcarriga/nvim-notify',
        -- event = "UIEnter",
        priority = 997, -- error messages even before startup are less disruptive
        init = function()
            local n = require("notify")
            n.setup({ render = "compact", background_colour = "#000000" })
            vim.notify = n

            -- Do this before: require("telescope").load_extension("notify")
            -- require('telescope').extensions.notify.notify(<opts>)
            -- OR
            -- :Telescope notify
            -- No telescope? :Notifications # lua: require("notify").history()
            -- compact
        end
    },
    -- see how regex works with :Hypersonic
    { "tomiis4/hypersonic.nvim", cmd = "Hypersonic" },
    --[[ Below does the same as vim-sudo but:
    - rewritten in lua
    - no noticable improvement performace-wise.
    - zero stars
    --]] -- { "airglow923/suda.nvim", config = true,
    -- commit = "e5684c7395fede814bddb85dc39d14175a8f19c8" },
    -- { -- basically adds "sudo write"
    --     "lambdalisue/vim-suda",
    --     -- BUG: Seems to not work? At least not reliably. I write the command, there's no errors, and it just doesn't save the changes. That's a deal breaker for me even if it might technically work sometimes.
    --
    --     cmd = {"SudaRead", "SudaWrite"},
    --     -- WARNING: Might need to update in the future.
    --     commit = "b97fab52f9cdeabe2bbb5eb98d82356899f30829",
    --
    --     config = true
    -- },
    -- below: nvim terminal opens nvim without nested nvim (so much better!)
    -- No mention of alacritty or foot in readme, but it
    -- works out of the box there too.
    { -- WARNING: can't open nvim with just "nvim" and no arguments
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
            priority = 999,
        },
        --- ...
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
        --     local k = require('kulala')
        --     k.setup({debug = true, additional_curl_options = {"-v"}})
        --     vim.keymap.set('n', '<leader>zr', k.run)
        -- end
    },
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
    --     'vimdev/lspsaga.nvim', },
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
