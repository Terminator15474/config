-------------------
---- AUTOSTART ----
-------------------
local vars = require("config.variables")


hl.on("hyprland.start", function()
	-- start awww-daemon
	hl.exec_cmd("awww-daemon --no-cache")

	hl.exec_cmd("systemctl --user enable --now " .. vars.notification_daemon)


	-- set wallpapers using awww
	hl.exec_cmd(vars.awww_wait .. 'awww img -o ' .. vars.left_monitor .. ' ' .. vars.left_wallpaper)
	hl.exec_cmd(vars.awww_wait .. 'awww img -o ' .. vars.right_monitor .. ' ' .. vars.right_wallpaper)


	hl.exec_cmd("quickshell")

	hl.exec_cmd(vars.auth_agent)

	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	hl.exec_cmd(vars.terminal)
	hl.exec_cmd(vars.browser)
	hl.exec_cmd("vesktop")

	-- Everything setup -> Lock the screen
	hl.exec_cmd(vars.screen_lock)

	-- hl.exec_cmd("nm-applet")
	-- hl.exec_cmd("waybar & hyprpaper & firefox")
end)
