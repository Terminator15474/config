local wezterm = require('wezterm') --[[@as Wezterm]]
local config = wezterm.config_builder()

config.automatically_reload_config = true

config.default_prog = { 'zsh' }
config.window_background_opacity = 0.2



config.keys = {
	{
		key = 'Space',
		mods = 'CTRL',
		action = wezterm.action.SendKey { key = 'Space', mods = 'CTRL' },
	}
}

return config
