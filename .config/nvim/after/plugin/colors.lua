function ColorMyPencils(color, isSpell, showBg) -- NOTE: duplicate fn in ../../lua/frostynick/lazy.lua 220
    -- Note: aliqyan-21/runTA.nvim transparency not affected. Use plugin config.
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
    if not showBg then
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end
    if not isSpell then
        vim.cmd.hi("clear", "SpellBad") -- removes highlight since I set spell to true by default
        vim.cmd.hi("clear", "SpellCap")
    end
end

--[[
```vim
highlight Normal guifg=#002200 guibg=#000000
highlight @markup.quote guifg=#002200
```

<!-- TODO: modify midnight theme and make it greeen -->
--]]
