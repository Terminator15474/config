local wezterm = require('wezterm') --[[@as Wezterm]]
local config = wezterm.config_builder()

config.default_prog = { 'zsh' }

return config
