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

-- Change the color scheme:
config.color_scheme = 'AdventureTime'

-- Windows-only launch menu config
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  -- Change default shell to PowerShell on Windows
  config.default_prog = { 'C:/Program Files/PowerShell/7/pwsh.exe' }

  -- FIXME: 
  -- This section should be templated using chezmoi to differentiate between
  -- Traxpay work laptop and my private Windows machines

  -- Custom lauch_menu config
  config.launch_menu = {
    {
      label = "Claranet support01",
      args = { "ssh.exe", "-A", "-J", "kzverev@traxbuild.internal.traxpay.com", "kzverev@support01.prod.dpp.traxpay.mgt.de.clara.net" },
    }
  }
end

-- and finally, return the configuration to wezterm
return config
