-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- Change the color scheme:
config.color_scheme = "Dracula"

-- Windows-only launch menu config
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	--
	-- Change default shell to PowerShell on Windows
	config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }

	-- FIXME:
	-- This section should be templated using chezmoi to differentiate between
	-- Traxpay work laptop and my private Windows machines

	-- Custom lauch_menu config
	config.launch_menu = {
		{
			label = "Claranet: support01",
			args = {
				"ssh.exe",
				"-A",
				"-J",
				"kzverev@traxproxy.internal.traxpay.com",
				"kzverev@support01-new.prod.dpp.traxpay.mgt.de.clara.net",
			},
		},
		{
			label = "Traxpay: traxalert",
			args = { "ssh.exe", "-A", "kzverev@traxalert.internal.traxpay.com" },
		},
		{
			label = "Traxpay: traxtest",
			args = { "ssh.exe", "-A", "kzverev@traxtest.internal.traxpay.com" },
		},
		{
			label = "Traxpay: traxproxy",
			args = { "ssh.exe", "-A", "kzverev@traxproxy.internal.traxpay.com" },
		},
		{ label = "Util: bottom", args = { "btm" } },
	}
end

-- config.font = wezterm.font('VictorMono Nerd Font', {
config.font = wezterm.font("FiraMono Nerd Font", {
	weight = "Regular",
	italic = false,
})
config.font_size = 12

config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.use_fancy_tab_bar = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = false

config.window_background_opacity = 0.95
config.macos_window_background_blur = 10

config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#202020",
}

config.audible_bell = "Disabled"

config.enable_scroll_bar = true

config.keys = {
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncherArgs { flags = ' LAUNCH_MENU_ITEMS | DOMAINS | WORKSPACES'} },
}

-- and finally, return the configuration to wezterm
return config
