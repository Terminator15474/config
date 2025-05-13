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
print(wezterm.target_triple)
if wezterm.target_triple:find('linux') then
	require('linux').setup(config)
else
	require('windows').setup(config)
end

return config
