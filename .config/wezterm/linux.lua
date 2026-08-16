local wezterm = require('wezterm') --[[@as Wezterm]]

local M = {}

---@param config Config
M.setup = function(config)
	config.font = wezterm.font_with_fallback({
		{ family = 'GeistMono Nerd Font', weight = 'Regular' },
		{ family = 'DejaVu Sans' },
	})
end

return M
