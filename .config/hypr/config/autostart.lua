-------------------
---- AUTOSTART ----
-------------------
local vars = require("config.variables")


hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user enable --now " .. vars.notification_daemon)

	hl.exec_cmd("quickshell")

	hl.exec_cmd(vars.auth_agent)

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	hl.exec_cmd(vars.terminal)
	hl.exec_cmd(vars.browser)
	hl.exec_cmd("vesktop")

	-- Everything setup -> Lock the screen
	hl.exec_cmd(vars.screen_lock)

	-- hl.exec_cmd("nm-applet")  Hopefully not need this, quickshell network menu should handle this
end)
