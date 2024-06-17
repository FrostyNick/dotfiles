function ColorMyPencils(color, isSpell) -- NOTE: duplicate fn in nv/lazy
    local a,b = pcall(function()
        if type(color) == "table" then
            color = color.name -- automatically passed from Lazy
        elseif not color then
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
