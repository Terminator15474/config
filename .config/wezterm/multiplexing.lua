local M = {}

---@param config Config
M.setup = function(config)
	config.unix_domains = {
		---@diagnostic disable-next-line
		{
			name = "unix",
			no_serve_automatically = false,
			connect_automatically = true,
		},
	}
	config.default_gui_startup_args = { "connect", "unix" }
end

return M
