local M = {}

---@param config Config
M.setup = function(config)

---@diagnostic disable-next-line
config.font = wezterm.font('GeistMono Nerd Font', { weight = 'Regular' })
end

return M
