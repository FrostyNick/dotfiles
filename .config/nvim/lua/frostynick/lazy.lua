-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- keys for vim https://vimdoc.sourceforge.net/htmldoc/intro.html#key-notation
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
    },

    -- {
    'VonHeikemen/lsp-zero.nvim', -- errors without it?
    --     branch = 'v2.x',
    --     dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    local a, b = pcall(vim.cmd, 'MasonUpdate') -- ignore the warning
                    if not a then
                        print("MasonUpdate: " .. b)
                    end
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            -- { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            -- { 'hrsh7th/nvim-cmp' },     -- Required
            -- { 'hrsh7th/cmp-path' },     -- Required
            -- { 'L3MON4D3/LuaSnip' },     -- Required Asks lsp to do extra tricks
            -- { 'folke/neodev.nvim' },    -- trying out.
            -- neodev Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
    --     }
    -- },
    -- -- autocomplete (not required)
    -- 'hrsh7th/cmp-buffer',
    -- 'hrsh7th/cmp-path',
    -- "L3MON4D3/LuaSnip",
    -- -- 'hrsh7th/cmp-cmdline',
    -- -- autocomplete (required)
    -- 'neovim/nvim-lspconfig',
    -- 'hrsh7th/nvim-cmp',
    -- 'hrsh7th/cmp-nvim-lsp',

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
    -- jump to character
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
        init = function() require('treepin').setup() end,
    },
    {
        'TarunDaCoder/sus.nvim',
        config = function()
            require('sus').setup()
        end,
    },
    {
      -- doesn't work + not supported in Termux.
        'Exafunction/codeium.vim',
        event = "VeryLazy",
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            local expT = { expr = true }
            local k = vim.keymap
            local function c(viM, codeM, n)
                k.set('i', '<c-' .. viM .. '>', function()
                    return vim.fn['codeium#' .. codeM](n)
                end, expT)
            end

            local function i(viM, codeM)
                k.set('i', '<c-' .. viM .. '>', function()
                    return vim.fn['codeium#' .. codeM]()
                end, expT)
            end

            i('g', 'Accept')
            i('x', 'Clear')
            c(';', 'CycleCompletions', 1)
            c(',', 'CycleCompletions', -1)
        end
    },
    {
        "nvim-neorg/neorg",
        ft = "norg",
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
                },
            }
        end,
    },

    -- Two colorschemes below
    { 'rose-pine/neovim',      name = 'rose-pine' },
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
                                                             -- The framework we use to run tasks
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
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },
    -- not working for some reason 'm4xshen/autoclose.nvim',
    'airblade/vim-gitgutter', -- not sure if this breaks sus.nvim
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'f-person/git-blame.nvim',                 -- shows git blame
    'folke/zen-mode.nvim',
    'nvim-treesitter/nvim-treesitter-context', -- shows functions from above
    'airblade/vim-rooter',                     -- 0.54 ms, 0.6 ms, 0.46 ms, 0.37 ms
    { 'nvim-telescope/telescope-media-files.nvim',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim' }
    },
    -- slower + doesn't work for me rn { 'notjedi/nvim-rooter.lua', --[[ 1.3 ms 0.44 ms 0.94 ms 0.47 ms 1.01 ms (not switching now 1ms 0.49 ms 0.61 ms ) ]] config = function() require'nvim-rooter'.setup() end },
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'stevearc/oil.nvim',
        opts = {},
    },
    -- - Trying out below; might delete later - --
    {
        'goolord/alpha-nvim',
        event = "VimEnter",
    --     opts = { require'alpha.themes.startify'.config }
    --     -- this breaks nvim rn. opts = { require'alpha.themes.dashboard'.config }
    },
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
-- markdown-preview
    ctrl + ^ should look at previous file in :Telescope oldfiles
    https://github.com/stevearc/oil.nvim
    kiran94/edit-markdown-table.nvim (it's a preview of the text when editing.. not exactly what I'm looking for with md tables)
    ray-x/web-tools.nvim
    Plug 'tpope/vim-commentary'
    ap/vim-css-color -- hex color
    erryma/vim-multiple-cursors
-- troubleshooting --
for k,v in pairs(plugins) do
    print(k,v)
end
]]

local opts = {}

require("lazy").setup(plugins, opts)
require("oil").setup()

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
-- --[[ This is what needs to be changed to fix this commit
-- --not that hard; just done for today
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--     capabilities = capabilities
-- }
-- ]]
-- -- end cmp setup

-- vim.print(plugins);
vim.g.codeium_disable_bindings = 1 -- disable codeium bindings
--vim.cmd('colorscheme kanagawa-dragon')

--print("Lazy loaded")
