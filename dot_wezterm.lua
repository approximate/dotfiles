-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

-- Custom lauch_menu config
config.launch_menu = {
  {
    label = "Git/Bash",
    args = { "bash", "-l" },
    cwd = "$HOME",
    set_environment_variables = { WEZTERM = "true" },
  },
  {
    label = "WSL (Ubuntu)",
    args = { "wsl.exe" },
    set_environment_variables = { WEZTERM = "true" },
  },
}

-- alternative way, Windows-only

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  -- Change default shell to WSL on windows
  config.default_prog = { 'wsl.exe' }

  table.insert(config.launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- This doesn't work due to spaces in directory names
  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(config.launch_menu, {
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

-- and finally, return the configuration to wezterm
return config
