-- stopped working with lazy. I don't really know enough about combining lua and vim together.
local builtin = require('telescope.builtin')
-- vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fv', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- pasted f nvim-telescope wiki https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#file-and-text-search-in-hidden-files-and-directories --
-- local telescope = require("telescope")
-- local telescopeConfig = require("telescope.config")
--
-- -- Clone the default Telescope configuration
-- local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

--[[
print("Length of vimgrep_arguments: " .. #vimgrep_arguments)
for k, v in pairs(vimgrep_arguments) do
    print(k .. ". " .. v)
end
]]
--[[
-- this feels like it should be inside { }
-- I want to search in hidden/dot files. Might not work.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
	defaults = {
		-- `hidden = true` is not supported in text grep commands.
		vimgrep_arguments = vimgrep_arguments,
	},
	pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		},
	},
})
]]
