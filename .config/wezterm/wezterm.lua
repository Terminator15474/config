local wezterm = require('wezterm') --[[@as Wezterm]]
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"

config.automatically_reload_config = true

config.default_prog = { 'zsh' }
config.window_background_opacity = 0.8

config.hide_tab_bar_if_only_one_tab = true

config.keys = {
	{
		key = 'Space',
		mods = 'CTRL',
		action = wezterm.action.SendKey { key = 'Space', mods = 'CTRL' },
	}
}

-- OS specific configuration
if wezterm.target_triple:find('linux') then
	print("Running Linux config")
	require('linux').setup(config)
else
	print("Running Windows config")
	require('windows').setup(config)
end

return config
