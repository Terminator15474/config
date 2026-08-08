local R = {
	-- User programs
	terminal = "wezterm",
	file_manager = "dolphin",
	browser = "firefox",

	-- system programs
	menu = "rofi -show drun",
	notification_daemon = "swaync",
	auth_agent = "hyprpolkitagent.service",

	-- wallpapers
	left_wallpaper = os.getenv("HOME") .. "/Pictures/wallpapers/static/chessboard.png.png",
	right_wallpaper = os.getenv("HOME") .. "/Pictures/wallpapers/static/sunrise-above-mountains.png.png",

	-- monitors
	right_monitor = "DP-1",
	left_monitor = "DP-3",
}


return R
