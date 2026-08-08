-- Define variables for wallpapers and monitors
local vars = require("config.variables")



hl.on("hyprland.start", function()
	hl.dispatch(
		hl.dsp.exec_raw('awww img --resize "fit" --outputs ' .. vars.left_monitor .. ' ' .. vars.left_wallpaper)
	)

	hl.dispatch(
		hl.dsp.exec_raw('awww img --resize "fit" --outputs ' .. vars.right_monitor .. ' ' .. vars.right_wallpaper)
	)
end)
