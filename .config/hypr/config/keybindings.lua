local vars = require("config.variables")

-- Define variables for modifiers and paths
local mainMod = "SUPER"

-- Example binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(vars.terminal), { description = "Open Terminal" })

hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close active window" })
hl.bind("META + F4", hl.dsp.window.close(), { description = "Close active window" })

-- hl.bind(mainMod .. " + M", hl.dsp.exit(), { description = "Logout of session" })
--
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.file_manager), { description = "Open File Manager" })
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating mode" })
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(vars.menu), { description = "Open run menu" })
-- hl.bind(mainMod .. " .. SHIFT + J", hl.dsp.togglesplit()) -- dwindle
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"), { description = "Run hyprlock" })

-- Switch workspaces with mainMod .. [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = "" .. i }), { description = "Switch to workspace " .. i })
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }), { description = "Switch to workspace 10" })

-- Move active window to a workspace with mainMod .. SHIFT + [0-9]
for i = 1, 9 do
	hl.bind(mainMod .. " + SHIFT + " .. i,
		hl.dsp.window.move({ workspace = "" .. i, follow = true }),
		{ description = "Move the active window to workspace" .. i })
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = true }),
	{ description = "Move the active window to workspace 10" })

-- Move Workspace to monitors
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.workspace.move({ monitor = vars.left_monitor }),
	{ description = "Move the current workspace to the left monitor" })
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.workspace.move({ monitor = vars.right_monitor }),
	{ description = "Move the current workspace to the right monitor" })

-- Move/resize windows with mainMod .. LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move the current window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize the current window" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%.."),
	{ repeating = true, locked = true, description = "Raise volume on laptop" }
)

hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ repeating = true, locked = true, description = "Raise volume on laptop" }
)

hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, description = "Mute audio on laptop" }
)

hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, description = "Mute microphone on laptop" }
)

hl.bind(
"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%.."),
	{ repeating = true, locked = true, description = "Increase brightness on laptop" }
)

hl.bind(
"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
	{ repeating = true, locked = true, description = "Decrease brightness on laptop" }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, description = "Play next media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Pause media" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true, description = "Play media" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, description = "Play previous media" })
