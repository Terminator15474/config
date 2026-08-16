------------------
--- MONITORS ---
------------------
local vars = require("config.variables")

hl.monitor({
	output = vars.left_monitor,
	mode = "3840x2160@60",
	position = "0x0",
	scale = "auto",
})

hl.monitor({
	output = vars.right_monitor,
	mode = "2560x1440@240",
	position = "2560x0",
	scale = "auto",
	bitdepth = 10,
	cm = "auto",
})
