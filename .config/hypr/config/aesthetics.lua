local colors = require("config.colors")

hl.config({
	general = {
		col = {
			active_border = colors.bg,
			inactive_border = colors.accent,
		},
		allow_tearing = true,
		layout = "master",
	},

	-- look at this sometimes
	snap = {},

	decoration = {
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
		},
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
	render = {
		cm_auto_hdr = 0,
	},
})
