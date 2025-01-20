-- Pull in the wezterm API
local wezterm = require("wezterm")
local wez_action = wezterm.action
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')
--
-- This table will hold the configuration.
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
local config = wezterm.config_builder()
--
-- You can put the rest of your Wezterm config here

config.keys = {
	-- Show the launcher in fuzzy selection mode and have it list all workspaces
	-- and allow activating one.
	{
		key = "w",
		mods = "ALT",
		action = wez_action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
	},
	--
	-- Same for tabs
	{
		key = "t",
		mods = "ALT",
		action = wez_action.ShowLauncherArgs({ flags = " FUZZY|TABS " }),
	},
	-- Same for Domains
	{
		key = "d",
		mods = "ALT",
		action = wez_action.ShowLauncherArgs({ flags = " FUZZY|DOMAINS " }),
	},
	-- Switch to the default workspace
	{
		key = "y",
		mods = "CTRL|SHIFT",
		action = wez_action.SwitchToWorkspace({
			name = "default",
		}),
	},
	-- Switch to a monitoring workspace, which will have `top` launched into it
	{
		key = "u",
		mods = "CTRL|SHIFT",
		action = wez_action.SwitchToWorkspace({
			name = "monitoring",
			spawn = {
				args = { "btm" },
			},
		}),
	},
	-- Create a new workspace with a random name and switch to it
	-- { key = "i", mods = "CTRL|SHIFT", action = wez_action.SwitchToWorkspace },
	-- Prompt for a name to use for a new workspace and switch to it.
	{
		key = "Q",
		mods = "CTRL|SHIFT",
		action = wez_action.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- Line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						wez_action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}

-- This is where you actually apply your config choices
--
-- This pre-defines UNIX domain, but doesn't make Wezterm connect to it
-- config.unix_domains = {
-- 	{
-- 		name = "wezterm",
-- 	},
-- }

config.ssh_domains = {
	{
		-- This name identifies the domain
		name = "Traxalert",
		-- The hostname or address to connect to. Will be used to match settings
		-- from your ssh config file
		remote_address = "traxalert",
		no_agent_auth = false,
		remote_wezterm_path = "/home/kzverev/wezterm/usr/bin/wezterm",
		ssh_option = {
			forwardagent = "true",
		},
	},
	{
		name = "Speed Slave",
		remote_address = "traxspeedslave",
		no_agent_auth = false,
		remote_wezterm_path = "/home/kzverev/wezterm/usr/bin/wezterm",
		ssh_option = {
			forwardagent = "true",
		},
	},
}
--
-- this option tells WezTerm GUI which domain to use when starting
-- pointing this to WSL allows
config.default_domain = "local"
-- config.default_mux_server_domain = "wezterm"

-- This is required to make use of local SSH agent to connect to remote hosts
-- Default SSH backend 'libssh-rs' doesn't seem to use existing agent correctly
config.ssh_backend = "Ssh2"
config.mux_enable_ssh_agent = false

-- ---------------------------------------------------
-- Change the color scheme:
config.color_scheme = "Dracula"

-- Windows-only launch menu config
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Change default shell to PowerShell on Windows
	config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe" }
end

-- config.font = wezterm.font('VictorMono Nerd Font', {
config.font = wezterm.font("FiraMono Nerd Font", {
	weight = "Regular",
	italic = false,
})
config.font_size = 12

config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = false
config.show_tab_index_in_tab_bar = true
config.enable_tab_bar = true
config.tab_bar_at_bottom = true
config.enable_scroll_bar = true

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
--
-- Returns a bool based on whether the host operating system's
-- appearance is light or dark.
local function is_dark()
	-- wezterm.gui is not always available, depending on what
	-- environment wezterm is operating in. Just return true
	-- if it's not defined.
	if wezterm.gui then
		-- Some systems report appearance like "Dark High Contrast"
		-- so let's just look for the string "Dark" and if we find
		-- it assume appearance is dark.
		return wezterm.gui.get_appearance():find("Dark")
	end
	return true
end

local function segments_for_right_status(window)
	return {
		window:active_workspace(),
		wezterm.strftime("%a %b %-d %H:%M"),
		wezterm.hostname(),
	}
end

wezterm.on("update-status", function(window, _)
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
	local segments = segments_for_right_status(window)

	local color_scheme = window:effective_config().resolved_palette
	-- Note the use of wezterm.color.parse here, this returns
	-- a Color object, which comes with functionality for lightening
	-- or darkening the color (amongst other things).
	local bg = wezterm.color.parse(color_scheme.background)
	local fg = color_scheme.foreground

	-- Each powerline segment is going to be colored progressively
	-- darker/lighter depending on whether we're on a dark/light color
	-- scheme. Let's establish the "from" and "to" bounds of our gradient.
	local gradient_to, gradient_from = bg
	if is_dark() then
		gradient_from = gradient_to:lighten(0.2)
	else
		gradient_from = gradient_to:darken(0.2)
	end

	-- Yes, WezTerm supports creating gradients, because why not?! Although
	-- they'd usually be used for setting high fidelity gradients on your terminal's
	-- background, we'll use them here to give us a sample of the powerline segment
	-- colors we need.
	local gradient = wezterm.color.gradient(
		{
			orientation = "Horizontal",
			colors = { gradient_from, gradient_to },
		},
		#segments -- only gives us as many colors as we have segments.
	)

	-- We'll build up the elements to send to wezterm.format in this table.
	local elements = {}

	for i, seg in ipairs(segments) do
		local is_first = i == 1

		if is_first then
			table.insert(elements, { Background = { Color = "none" } })
		end
		table.insert(elements, { Foreground = { Color = gradient[i] } })
		table.insert(elements, { Text = SOLID_LEFT_ARROW })

		table.insert(elements, { Foreground = { Color = fg } })
		table.insert(elements, { Background = { Color = gradient[i] } })
		table.insert(elements, { Text = " " .. seg .. " " })
	end

	window:set_right_status(wezterm.format(elements))
end)

smart_splits.apply_to_config(config, {
  -- the default config is here, if you'd like to use the default keys,
  -- you can omit this configuration table parameter and just use
  -- smart_splits.apply_to_config(config)

  -- directional keys to use in order of: left, down, up, right
  direction_keys = { 'h', 'j', 'k', 'l' },
  -- if you want to use separate direction keys for move vs. resize, you
  -- can also do this:
  -- direction_keys = {
  --   move = { 'h', 'j', 'k', 'l' },
  --   resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
  -- },
  -- modifier keys to combine with direction_keys
  modifiers = {
    move = 'CTRL', -- modifier to use for pane movement, e.g. CTRL+h to move left
    resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
  },
  -- log level to use: info, warn, error
  log_level = 'info',
})

-- and finally, return the configuration to wezterm
return config
