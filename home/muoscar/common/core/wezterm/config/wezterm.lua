local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.enable_wayland = false

-- Default shell
-- config.default_prog = { 'zsh' }

-- For example, changing the color scheme:
config.color_scheme = "Gruber (base16)"

-- Hide tab bar if only one
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
	left = "2px",
	right = "2px",
	top = "0px",
	bottom = "0px",
}

config.keys = {
	-- Turn off the default CMD-m Hide action, allowing CMD-m to
	-- be potentially recognized and handled by the tab
	{
		key = "w",
		mods = "SUPER",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

-- and finally, return the configuration to wezterm
return config
