-- This file can be loaded by calling `lua require('frostynick.plugins')` from your init.vim
-- keys for vim https://vimdoc.sourceforge.net/htmldoc/intro.html#key-notation
-- Migration: Lazy <--> Packer https://github.com/folke/lazy.nvim#packernvim
--[[ Open issues:
[Neovim config should be more backwards compatible](https://github.com/FrostyNick/dotfiles/issues/1)
Additionally, clean code. Remove extra comments.
--]]


-- Idea: vim windows integrate with i3
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

    -- If lazy becomes obsolete one day for some reason and separate files are needed, these checks might help.
    -- if not ts then
    --     print('require"telescope" failed. Telescope is probably not installed. Telescope config has been skipped.')
    --     return
    -- end

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
    k.del('n', '<leader>,')
    k.set('n', '<leader>,', tsb.oldfiles, { desc="Telescope: old files" })
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
    '<cmd>Telescope find_files hidden=true search_dirs=/home/nicholas/backup2022nov10/<CR>',
    {desc="Telescope: find backup files; keyword: joplin"})

    k.set('n', '<leader>fc',
    '<cmd>Telescope find_files hidden=true search_dirs=/home/nicholas/p/<CR>',
    {desc="Telescope: find code in projects directory"})

    k.set('n', '<leader>gj',
    '<cmd>Telescope live_grep search_dirs=/home/nicholas/backup2022nov10/<CR>',
    {desc="Telescope: live grep (find text) in backup files; replacement to joplin. Requires rg."})

    k.set('n', '<leader>fg', tsb.live_grep, {desc="Telescope: live grep"})
    k.set('n', '<leader>fv', tsb.git_files, {desc="Telescope: git files"})

    k.set('n', '<leader>fm', "<cmd>Telescope man_page<CR>", {})

    k.set('n', '<leader>f/', function()
        tsb.grep_string({ search = vim.fn.input("Grep > ") })
    end, {desc="Telescope: Grep string"})

    local success,msg = pcall(function()
        ts.load_extension"file_browser"
        k.set('n', '<leader>fb',
        "<cmd>Telescope file_browser<CR>", {desc="Telescope: file browser"})
    end)

    if not success then
        print("Error loading telescope file_browser: " .. msg)
    end

    success,msg = pcall(function()
        ts.load_extension"media_files"
        k.set('n', '<leader>fp',
        "<cmd>Telescope media_files<CR>", {desc = "Telescope: pictures; media files"})
    end)

    if not success then
        print("Error loading telescope media_files: " .. msg)
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
                ensure_installed = { "lua_ls", "rust_analyzer", "denols" },
            }
        end
    }, -- Optional
    { 'neovim/nvim-lspconfig', event = "VeryLazy" }, -- Required

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
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },

    -- uses ys; which stands for you surround; see `:h nvim-surround.usage` for more info
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
    -- visualize jump to character
    {
        'jinh0/eyeliner.nvim',
        event = "VeryLazy",
        config = function()
            require 'eyeliner'.setup {
                highlight_on_key = true,
                dim = false
            }
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        -- tag = '0.1.1',
        tag = '0.1.5',
        -- or                       , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        -- event = "UIEnter",
        event = "VeryLazy",
        config = telescopeConfig,
    },
    { -- might rm l8r; lualine also has grapple
        'cbochs/grapple.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'TarunDaCoder/sus.nvim',
        event = "VeryLazy",
        opts = {}
    },
    { -- guesses indents apparently
        'nmac427/guess-indent.nvim',
        event = "VeryLazy",
        opts = {},
    },
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
                "<leader>oo",
                ":<c-u>lua require('ollama').prompt()<cr>",
                desc = "ollama prompt",
                mode = { "n", "v" },
            },

            -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
            {
                "<leader>oG",
                ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
                desc = "ollama Generate Code",
                mode = { "n", "v" },
            },
        },

        ---@type Ollama.Config
        opts = {
            -- your configuration overrides
        }
    },
    {
        "chrishrb/gx.nvim",
        -- event = "VeryLazy",
        keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }} },
        cmd = { "Browse" },
        init = function ()
            vim.g.netrw_nogx = 1 -- disable netrw gx
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
        -- config = true, -- default settings

        -- you can specify also another config if you want
        config = function() require("gx").setup {
            -- open_browser_app = "os_specific", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
            -- open_browser_args = { "--background" }, -- specify any arguments, such as --background for macOS' "open".
            handlers = {
                plugin = true,
                github = true,
                brewfile = false, -- Homebrew
                package_json = true,
                search = true, -- search the web if nothing else is found
            },
            handler_options = {
                search_engine = "duckduckgo", -- select between google, bing, duckduckgo, and ecosia
                -- search_engine = "https://search.brave.com/search?q=", -- or custom search engine
            },
        } end,
    },
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
        "nvim-neorg/neorg",
        -- ft = "norg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
        config = function()
            require("neorg").setup {
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
            }
        end,
    },

    {'nacro90/numb.nvim', event = "VeryLazy", opts = {} }, -- non-intrusively preview while typing :432... 
    --- Colorschemes below
    {
        'rose-pine/neovim',      name = 'rose-pine',
        init = function()
            vim.cmd.colorscheme("rose-pine")

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

            vim.cmd.hi("clear", "SpellBad") -- removes highlight since I set spell to true by default
        end
    },
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     name = 'nordic',
    --     event = "VeryLazy",
    --     config = function()
    --         require("nordic").setup {
    --             telescope = {style = 'classic'}
    --         }
    --     end
    -- },
    -- { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
    {
        'nvim-lualine/lualine.nvim',
        -- event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
        opts = {},
        config = function()
            require("lualine").setup({
                sections = {
                    lualine_b = {
                        {
                            function()
                                return " " .. require("grapple").key()
                            end,
                            cond = require("grapple").exists,
                        }
                    },
        --             lualine_x = {
        --                 {
        --                     require("lazy.status").updates,
        --                     cond = require("lazy.status").has_updates,
        --                     color = { fg = "#ff9e64" },
        --                 },
        --             },
                },
            })
        end
    },

    {
        'barrett-ruth/live-server.nvim',
        event = "VeryLazy",
        -- cmd = "LiveServerStart",  -- Note: "LiveServerToggle" isn't in plugin.
        -- if switching from npm you can uninstall by (might need sudo):
        -- npm uninstall -g live-server
        -- yarn global add @compodoc/live-server # less security issues with this live-server command
        -- build = 'npm install -g live-server', -- If using npm
        build = 'yarn global add @compodoc/live-server', -- in theory this is needed after installing this plugin. Couldn't test it right now.
        config = function() -- should be in init some of this maybe. fix later. slows down start time slightly.
            local l = require('live-server')
            l.setup( --[[ args = {"--browser=librewolf"} ]])
            vim.g.liveservertoggle = true
            -- vim.keymap.set('n', '<leader>lf', function()
            --     vim.g.liveservertoggle = true
            --     l.start()
            -- end)
            -- vim.keymap.set('n', '<leader>lt', function()
            --     vim.g.liveservertoggle = false
            --     l.stop()
            -- end)

            vim.keymap.set('n', '<leader>ll', function()
                if vim.g.liveservertoggle then
                    l.start()
                else
                    l.stop()
                end
                vim.g.liveservertoggle = not vim.g.liveservertoggle
            end)
        end,
        -- config = function()
        -- end
    },
    -- How to install the required dependencies · Zeioth/compiler.nvim Wiki https://github.com/Zeioth/Compiler.nvim/wiki/how-to-install-the-required-dependencies
    {
      -- This plugin
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults" },
        -- event = "VeryLazy",
        dependencies = { "stevearc/overseer.nvim" },
        config = function(_, opts) require("compiler").setup(opts) end,
    },
    {
        "stevearc/overseer.nvim",
        commit = "3047ede61cc1308069ad1184c0d447ebee92d749", -- Recommended to to avoid breaking changes
        event = "VeryLazy",
        -- cmd = { "CompilerOpen", "CompilerToggleResults" },
        opts = {
            -- Tasks are disposed 5 minutes after running to free resources.
            -- If you need to close a task inmediatelly:
            -- press ENTER in the menu you see after compiling on the task you want to close.
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
                bindings = {
                    ["q"] = function() vim.cmd("OverseerClose") end,
                },
            },
        },
    },
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
        event = "VeryLazy",
        config = function()
            require("nvim-autopairs").setup {
                check_ts = true,
            }
        end
    },
    {'nvim-treesitter/playground', cmd = "TSPlaygroundToggle"},
    -- {
    --     'theprimeagen/harpoon',
    --     config = function()
    --         local mark = require("harpoon.mark")
    --         local ui = require("harpoon.ui")
    --         local k = vim.keymap
    --
    --         k.set("n", "<leader>a", mark.add_file)
    --         k.set("n", "<C-p>", ui.toggle_quick_menu) -- C-o overrides jumping in vim and C-e sucks in termux (scroll down action)
    --
    --         -- dvorak local keys = {"h", "t", "n", "s", "leader"}
    --         local keys = {"h", "j", "k", "l"}
    --         for i, key in ipairs(keys) do
    --             k.set("n", "<C-"..key..">", function() ui.nav_file(i) end)
    --         end
    --     end,
    -- },
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
                vim.cmd("ZenMode")
                vim.wo.wrap = false
                -- not working ColorMyPencils()
            end)
        end,
        config = function()
            require("zen-mode").setup {
                window = {
                    width = 90,
                    -- self-note: doesn't work, works on other PC for some reason.
                    options = {
                        number = true,
                        relativenumber = true,
                    }
                },
            }
        end,
        opts = {
            window = {
                backdrop = 0,
                height = 0.7,
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
    {'nvim-treesitter/nvim-treesitter-context', event = "VeryLazy" },

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
                            -- How about inside of dates descriptions, like for
                            -- a log or journal?
                        }
                    }
                }
            }
        end
    },
    -- no longer works on here. probably bc of another plugin.
    -- 'airblade/vim-rooter',                     -- 0.54 ms, 0.6 ms, 0.46 ms, 0.37 ms
    {
        "dhruvasagar/vim-table-mode",
        cmd = "TableModeToggle",
        -- ft = "markdown"
    },
    {"chrisbra/Colorizer", event = "VeryLazy"}, -- test if it still works
    -- {"ap/vim-css-color", ft = "css"},
    {"iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = "cd app && yarn install", -- If lazy asks to remove and install while going from npm to yarn, do that and it should be fixed.
        -- build = "cd app && npm install", -- If using npm
        config = function() vim.g.mkdp_filetypes = { "markdown" } end,
    },
    { 'nvim-telescope/telescope-media-files.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim' },
        event = "VeryLazy",
    },
    -- slower + doesn't work for me rn { 'notjedi/nvim-rooter.lua', --[[ 1.3 ms 0.44 ms 0.94 ms 0.47 ms 1.01 ms (not switching now 1ms 0.49 ms 0.61 ms ) ]] config = function() require'nvim-rooter'.setup() end },
    { 'numToStr/Comment.nvim', event = "VeryLazy", opts = {} },
    { -- Improved simrat39/symbols-outline
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = "Outline", -- { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>zo", "<cmd>Outline!<CR>", desc = "Code outline. Previously :SymbolsOutline. Can be used with :Outline" },
        },
        opts = {
            symbols = {
                filter = {
                    default = {"String", "Variable", exclude = true},
                    lua = {
                        'Function', 'Class'
                    }
                }
            }
            -- Your setup opts here
        },
    },
    -- :Speedtyper to start typing practice
    {
        'NStefan002/speedtyper.nvim',
        cmd = "Speedtyper",
        opts = {}
    },
    -- leetcode: https://github.com/kawre/leetcode.nvim . Requires v0.9.0. See requirements b4 installing.

    -- currently not working: https://github.com/glacambre/firenvim/blob/master/TROUBLESHOOTING.md
    -- Below is made for browser extension firenvim.
    {
        "glacambre/firenvim",
        event = "VeryLazy",
        -- lazy = not vim.g.started_by_firenvim,
        -- module = false,
        build = function()
            vim.fn["firenvim#install"](0)
        end,
    },
    {
        'tpope/vim-endwise', -- automatically add "end" to code-block. note: possible issues with autocomplete if that is enabled
        event = "InsertEnter",
        -- event = "UIEnter",
    },
    {
        'rcarriga/nvim-notify',
        event = "UIEnter",
        config = function()
            local notify = require("notify")
            notify.setup({ render = "compact", background_colour = "#000000" })
            vim.notify = notify

            -- Do this before: require("telescope").load_extension("notify")
            -- require('telescope').extensions.notify.notify(<opts>)
            -- OR
            -- :Telescope notify
            -- No telescope? :Notifications # lua: require("notify").history()
            -- compact
        end
    }
    -- { -- error: couldn't find github username
    --     'vimdev/lspsaga.nvim',
    --     -- event = "VeryLazy",
    -- },
    -- takes over S and s btw [backdround/improved-ft.nvim: Improve default f/t hop abilities](https://github.com/backdround/improved-ft.nvim)
    -- norcalli/nvim-terminal.lua

    -- { 'stevearc/oil.nvim', opts = {}, },
    -- rm homepage. I don't really want it.
    -- - Trying out below; might delete later - --
    -- I find it annoying about 20 seconds in. maybe i should look at config.
    -- { -- for better vim habits. if it's not super annoying I'll keep it.
    --     "m4xshen/hardtime.nvim",
    --     dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    --     opts = {}
    -- },
    -- new alt to which-key: Cassin01/wf.nvim
    -- new thing that depends on which-key: roobert/surround-ui.nvim -- for nvim-surround help
    -- {
    --     "folke/which-key.nvim",
    --     event = "VeryLazy",
    --     init = function()
    --         vim.o.timeout = true
    --         vim.o.timeoutlen = 1000
    --     end,
    --     opts = {
    --         plugins = {
    --             operators = false
    --         }
    --         -- your configuration comes here
    --         -- or leave it empty to use the default settings
    --         -- refer to the configuration section below
    --     }
    -- },
    -- Not working for me https://github.com/jghauser/follow-md-links.nvim/issues/15 'jghauser/follow-md-links.nvim',
    -- {'andweeb/presence.nvim', event="VeryLazy"}, -- Not working with BetterDiscord so far. Tried: `ln -svf $XDG_RUNTIME_DIR/{app/com.discord.Discord,}/discord-ipc-0` and `ln -svf $XDG_RUNTIME_DIR/{app/com.discordapp.Discord,}/discord-ipc-0`
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

-- troubleshooting --
for k,v in pairs(plugins) do
    print(k,v)
end
]]

local opts = {}

require("lazy").setup(plugins, opts)
-- move below to init l8r
-- require("oil").setup()
-- require("lspconfig").tsserver.setup()

-- -- cmp setup
-- local cmp = require'cmp'
-- 
-- cmp.setup({
--     snippet = {
--         -- REQUIRED - you must specify a snippet engine
--         expand = function(args)
--             -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--             -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--             -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--         end,
--     },
--     window = {
--         -- completion = cmp.config.window.bordered(),
--         -- documentation = cmp.config.window.bordered(),
--     },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.abort(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
--     }),
--     sources = cmp.config.sources({
--         { name = 'nvim_lsp' },
--         { name = 'luasnip' }, -- For luasnip users.
--         -- { name = 'vsnip' }, -- For vsnip users.
--         -- { name = 'ultisnips' }, -- For ultisnips users.
--         -- { name = 'snippy' }, -- For snippy users.
--     })
-- })
-- 
-- -- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- -- self-reminder: check termux device or checkout with lsp servers
-- 
--This is what needs to be changed to fix this commit
--not that hard; just done for today
local a,b = pcall(function()
    -- it can't find deno, which is fine require('lspconfig')['deno'].setup {
    --     capabilities = capabilities
    -- }
    -- How would this be worse than say LspZero other than it doesn't
    -- automatically have all the plugins that Mason has?
    local lspLs = { 'lua_ls', 'tsserver', 'bashls', 'pylsp', 'rust_analyzer',
    'denols', 'emmet_ls', 'lua_ls', 'tsserver', 'zk', }
    for _,v in ipairs(lspLs) do
        require('lspconfig')[v].setup {
            capabilities = capabilities
        }
    end
end)
if not a then
	print("failed to setup lspconfig: "..b)
end


-- -- end cmp setup

-- vim.print(plugins);
vim.g.neovide_scale_factor = 0.7
--vim.cmd('colorscheme kanagawa-dragon')
-- init.lua file to look at later https://github.com/wincent/wincent/blob/a54fb501a4e331a7c197088f9f744bfb9c6d2e1f/aspects/nvim/files/.config/nvim/init.lua#L213
--print("Lazy loaded")
