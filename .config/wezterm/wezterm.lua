-- Get started with config:
-- https://wezfurlong.org/wezterm/config/appearance.html

-- As a result of having Windows on my laptop (kitty doesn't support) and
-- dev is meh in kitty, wezterm!

--[[ Other perks (compared to kitty):

- Lua config file: Lua is powerful, made to embed, not that hard to learn, and takes about 100KB
- Way more welcoming dev compared to kitty dev
- Made in Rust, which is less prone to unexpected errors than Python.
- More user friendly defaults.
- Many things work out of the box like tabs, spaces, etc.

--]]

-- Pull in the wezterm API
local wezterm = require'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Theme
config.font = wezterm.font'Mononoki Nerd Font Mono'
-- to see fonts that wezterm detects:wezterm ls-fonts

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

config.colors = {
    -- Could be better; good enough for now
    -- https://wezfurlong.org/wezterm/config/appearance.html#retro-tab-bar-appearance
    tab_bar = {
        background = "#000",
    }
}

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
  format = 'https://www.github.com/$1/$3',
})

-- On Linux with X11, I use picom compositor to get this working.
-- On Linux with Wayland, Windows, and MacOS it works out of the box according to docs.
config.window_background_opacity = 0.8

-- config.color_scheme = 'Batman'

local launch_menu = {}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
end

config.launch_menu = launch_menu

return config
