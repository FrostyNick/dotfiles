local ts = require"telescope"
ts.setup({
    defaults = {
        -- layout_strategy = "vertical", -- better on vertical screens.
        layout_config = {
            width = 0.93
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
        }
    },
    media_files = {
        filetypes = {"png", "webp", "jpg", "jpeg"},
        -- find command (defaults to `fd`)
        find_cmd = "rg"
    }
    -- other configuration values here
})

ts.load_extension"file_browser"
ts.load_extension'media_files'
local tsb = require('telescope.builtin')
local k = vim.keymap
-- vim.g.mapleader = ' '

k.set('n', '<leader><leader>', tsb.spell_suggest, {})
k.set('n', '<leader>,', tsb.oldfiles, { desc="Telescope: old files" })
k.set('n', '<leader>b', tsb.buffers, { desc="Telescope: buffers" })
k.set('n', '<leader>?', tsb.keymaps, { desc="Telescope: keymaps" })
k.set('n', '<leader>f?', function() print"use <leader>fk instead" end)

k.set('n', '<leader>fk', tsb.help_tags,
{ desc="Telescope: help tags (documentation)" })

k.set('n', '<leader>f<BS>', tsb.resume,
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

k.set('n', '<leader>fb',
"<cmd>Telescope file_browser<CR>", {desc="Telescope: file browser"})

k.set('n', '<leader>fp',
"<cmd>Telescope media_files<CR>", { desc = "Telescope: pictures; media files"})

k.set('n', '<leader>f/', function()
    tsb.grep_string({ search = vim.fn.input("Grep > ") })
end, {desc="Telescope: Grep string"})

