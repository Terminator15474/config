local M = {}

---@param config Config
M.setup = function(config)
	config.unix_domains = {
		{
			name = "unix",
			-- socket_path = "/some/path",
			no_serve_automatically = false,
			connect_automatically = true,
		},
		{
			name = "wsl",
			serve_command = { "wsl", "wezterm-mux-server", "--daemonize" },
		}
	}
	config.default_gui_startup_args = { "connect", "unix" }
end

return M
