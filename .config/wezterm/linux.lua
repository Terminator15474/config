local wezterm = require('wezterm') --[[@as Wezterm]]

local M = {}

---@param config Config
M.setup = function(config)
	config.font = wezterm.font('GeistMono', { weight = 'Regular' })
end

return M
