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

        -- Idea: "Live server active"
        -- Idea: Open github link from vim
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

    -- I wanna improve lsp
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
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
            { 'hrsh7th/nvim-cmp' },   -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },   -- Required
        }
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
        'Exafunction/codeium.vim',
        config = function()
            -- Change '<C-g>' here to any keycode you like.
            local expT = { expr = true }
            local k = vim.keymap
            local function c(viM, codeM, n)
                k.set('i', '<c-'..viM..'>', function()
                    return vim.fn['codeium#'..codeM](n)
                end, expT)
            end

            local function i(viM, codeM)
                k.set('i', '<c-'..viM..'>', function()
                    return vim.fn['codeium#'..codeM]()
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
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = "VeryLazy",
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
                    }, -- Adds pretty icons to your documents
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
    { 'rebelot/kanagawa.nvim', name = 'kanagawa' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
        'barrett-ruth/live-server.nvim',
        build = 'npm install -g live-server',
    },
    'rebelot/kanagawa.nvim',
    'nvim-treesitter/playground',
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    'f-person/git-blame.nvim', -- shows git blame
    'airblade/vim-rooter',     -- changes directory to project root when opening from CLI
    'folke/zen-mode.nvim',
    'nvim-treesitter/nvim-treesitter-context', -- shows functions from above
-- - Trying out below; might delete later - --
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    -- Not working for me https://github.com/jghauser/follow-md-links.nvim/issues/15 'jghauser/follow-md-links.nvim',
    'andweeb/presence.nvim', -- Not working with BetterDiscord so far. Tried: `ln -svf $XDG_RUNTIME_DIR/{app/com.discord.Discord,}/discord-ipc-0` and `ln -svf $XDG_RUNTIME_DIR/{app/com.discordapp.Discord,}/discord-ipc-0` 
}
--[[ 
-- alternative plugins maybe
    https://github.com/stevearc/oil.nvim
    kiran94/edit-markdown-table.nvim (it's a preview of the text when editing.. not exactly what I'm looking for with md tables)
    ray-x/web-tools.nvim
    Plug 'tpope/vim-commentary'
    ap/vim-css-color -- hex color
    restore-view
    erryma/vim-multiple-cursors
-- troubleshooting --
for k,v in pairs(plugins) do
    print(k,v)
end
]]

local opts = {}

require("lazy").setup(plugins, opts)

-- vim.print(plugins);
vim.g.codeium_disable_bindings = 1 -- disable codeium bindings
--vim.cmd('colorscheme kanagawa-dragon')

--print("Lazy loaded")
