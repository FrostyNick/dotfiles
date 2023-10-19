-- This file can be loaded by calling `lua require('frostynick.plugins')` from your init.vim
-- keys for vim https://vimdoc.sourceforge.net/htmldoc/intro.html#key-notation
-- Lazy <--> Packer https://github.com/folke/lazy.nvim#packernvim
--[[
use()
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    -- different dependencies so ill keep this here just in case
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

]]

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

local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        -- commit that (in theory) supports nvim 0.8.0 - <0.9.1
        -- commit = "2aa9e9b0e655462890c6d2d8632a0d569be66482",
    },

    -- LSP Support
    { 'williamboman/mason.nvim', },-- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional
    { 'neovim/nvim-lspconfig' }, -- Required

    -- Autocompletion
    -- { 'hrsh7th/cmp-nvim-lsp' }, -- Required
    -- { 'hrsh7th/nvim-cmp' },     -- Required
    -- { 'hrsh7th/cmp-path' },     -- Required
    -- { 'L3MON4D3/LuaSnip' },     -- Required Asks lsp to do extra tricks
    -- { 'folke/neodev.nvim' },    -- trying out.
    -- neodev Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    -- -- autocomplete (not required)
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-path',
    "L3MON4D3/LuaSnip",
    -- -- 'hrsh7th/cmp-cmdline',
    -- -- autocomplete (required)
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',

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
        config = function()
            require 'eyeliner'.setup {
                highlight_on_key = true,
                dim = false
            }
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                       , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'KaitlynEthylia/TreePin',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        opts = {} -- Might break. See commit on 2023-9-18 to rollback
    },
    { 'TarunDaCoder/sus.nvim', opts = {} },
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
        -- event = "VeryLazy",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    -- https://github.com/nvim-neorg/neorg/wiki/Concealer
                    ["core.concealer"] = {
                        config = {
                            -- folds = false,
                            icon_preset = "diamond"
                        }
                    },                  -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = { notes = "~/backup2022nov10/notes" },
                        },
                    },
                    ["core.export"] = {},
                    ["core.export.markdown"] = {
                        config = {
                            extensions = "all",
                        },
                    },
                },
            }
        end,
    },

    {'nacro90/numb.nvim', opts = {} }, -- non-intrusively preview while typing :432... 
    -- Two colorschemes below
    { 'rose-pine/neovim',      name = 'rose-pine' },
    { 'AlexvZyl/nordic.nvim',  name = 'nordic', config = {telescope = {style = 'classic'}} },
    -- { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
        'barrett-ruth/live-server.nvim',
        event = "VeryLazy",
        -- cmd = "LiveServerStart", -- lazyload on command --> not working?
        build = 'npm install -g live-server',
    },
    -- How to install the required dependencies · Zeioth/compiler.nvim Wiki https://github.com/Zeioth/Compiler.nvim/wiki/how-to-install-the-required-dependencies
    {
      -- This plugin
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults" },
        dependencies = { "stevearc/overseer.nvim" },
        config = function(_, opts) require("compiler").setup(opts) end,
    },
    {
        "stevearc/overseer.nvim",
        commit = "3047ede61cc1308069ad1184c0d447ebee92d749", -- Recommended to to avoid breaking changes
        cmd = { "CompilerOpen", "CompilerToggleResults" },
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
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    {
        "davisdude/vim-love-docs",
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
    'airblade/vim-gitgutter',
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'f-person/git-blame.nvim',                 -- shows git blame
    {
        'folke/zen-mode.nvim',
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
    'nvim-treesitter/nvim-treesitter-context', -- shows functions from above
    {'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
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
                        }
                    }
                }
            }
        end
    },
    -- no longer works on here. probably bc of another plugin.
    -- 'airblade/vim-rooter',                     -- 0.54 ms, 0.6 ms, 0.46 ms, 0.37 ms
    {"dhruvasagar/vim-table-mode", ft = "markdown"},
    {"chrisbra/Colorizer", event = "VeryLazy"}, -- test if it still works
    -- {"ap/vim-css-color", ft = "css"},
    {"iamcco/markdown-preview.nvim",
        ft = "markdown",
        -- \/ once I yeet out of Joplin
        -- build = "cd app && yarn install",
        build = "cd app && npm install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    },
    { 'nvim-telescope/telescope-media-files.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim' }
    },
    -- slower + doesn't work for me rn { 'notjedi/nvim-rooter.lua', --[[ 1.3 ms 0.44 ms 0.94 ms 0.47 ms 1.01 ms (not switching now 1ms 0.49 ms 0.61 ms ) ]] config = function() require'nvim-rooter'.setup() end },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'simrat39/symbols-outline.nvim', -- I use as function outline. no whitelist so there's a long list instead.
        opts = { show_symbol_details = true,
            symbol_blacklist = {'File',
            'Module',
            'Namespace',
            'Package',
            'Class',
            'Method',
            'Property',
            'Field',
            'Constructor',
            'Enum',
            'Interface',
            -- 'Function',
            'Variable',
            'Constant',
            'String',
            'Number',
            'Boolean',
            'Array',
            'Object',
            'Key',
            'Null',
            'EnumMember',
            'Struct',
            'Event',
            'Operator',
            'TypeParameter',
            'Component',
            'Fragment'}
        }
    },
    -- :Speedtyper to start typing practice
    {'NStefan002/speedtyper.nvim', opts = {}},
    -- leetcode: https://github.com/kawre/leetcode.nvim . Requires v0.9.0. See requirements b4 installing.
    --
    'tpope/vim-endwise', -- automatically add "end" to code-block. note: possible issues with autocomplete if that is enabled
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
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "denols" },
}
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
vim.g.codeium_disable_bindings = 1 -- disable codeium bindings
--vim.cmd('colorscheme kanagawa-dragon')
-- init.lua file to look at later https://github.com/wincent/wincent/blob/a54fb501a4e331a7c197088f9f744bfb9c6d2e1f/aspects/nvim/files/.config/nvim/init.lua#L213
--print("Lazy loaded")
