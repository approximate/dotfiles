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
    config.default_prog = {'C:/Program Files/PowerShell/7/pwsh.exe'}

    -- FIXME:
    -- This section should be templated using chezmoi to differentiate between
    -- Traxpay work laptop and my private Windows machines

    -- Custom lauch_menu config
    config.launch_menu = {{
        label = "Claranet support01",
        args = {"ssh.exe", "-A", "-J", "kzverev@traxbuild.internal.traxpay.com",
                "kzverev@support01.prod.dpp.traxpay.mgt.de.clara.net"}
    }, {
        label = "Traxpay: traxbuild",
        args = {"ssh.exe", "-A", "kzverev@traxbuild.internal.traxpay.com"}
    }, {
        label = "Traxpay: traxtest",
        args = {"ssh.exe", "-A", "kzverev@traxtest.internal.traxpay.com"}
    }, {
        label = "Traxpay: traxproxy",
        args = {"ssh.exe", "-A", "kzverev@traxproxy.internal.traxpay.com"}
    }}
end

-- config.font = wezterm.font('VictorMono Nerd Font', {
config.font = wezterm.font('FiraMono Nerd Font', {
    weight = 'Regular',
    italic = false
})

config.visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 150,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 150
}
config.colors = {
    visual_bell = '#202020'
}

config.audible_bell = "Disabled"

config.keys = {
  { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}

-- and finally, return the configuration to wezterm
return config
