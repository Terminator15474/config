---------------------
---- MY PROGRAMS ----
---------------------

local vars = require("config.variables")


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd(vars.terminal)
	hl.exec_cmd(vars.browser)

	hl.exec_cmd("systemctl --user enable --now " .. vars.notification_daemon)
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("waybar")
	hl.exec_cmd("vesktop")

	hl.exec_cmd(vars.auth_agent)

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- hl.exec_cmd("nm-applet")
	-- hl.exec_cmd("waybar & hyprpaper & firefox")
end)
