function ColorMyPencils(color, isSpell, showBg) -- NOTE: duplicate fn in ../../lua/frostynick/lazy.lua 220
  -- Note: aliqyan-21/runTA.nvim transparency not affected. Use plugin config.
  local s = { bg = "none" }
  local a,b = pcall(function()
    if type(color) == "table" then
      color = color.name -- automatically passed from Lazy
    end
    if color then
      if color:lower():sub(1, 10) == "cyberdream" then -- fix for cyberdream when switching between light and dark theme
        vim.cmd.CyberdreamToggleMode()
        vim.cmd.CyberdreamToggleMode()
      end
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
