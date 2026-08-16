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
	awww_wait =
	'while ! awww query &>/dev/null; do sleep 0.1; echo "wait" > ~/tmp.log; done; ',
	left_wallpaper = "~/Pictures/wallpapers/Anime/dragons_fighting.png.png",
	right_wallpaper = "~/Pictures/wallpapers/Anime/anime_girl_assault_rifle.png",

	-- monitors
	right_monitor = "DP-1",
	left_monitor = "DP-3",
	screen_lock = "~/.local/share/quickshell-lockscreen/lock.sh"
}


return R
