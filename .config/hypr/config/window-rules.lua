------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------
local vars = require("config.variables")

-- Smart gaps and workspace_rule workspace_rule rules
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })

hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1s[false]]" }, rounding = 0 })


-- Assign workspace_rules to specific monitors
hl.workspace_rule({ workspace = "1", monitor = vars.left_monitor, default = true })
hl.workspace_rule({ workspace = "2", monitor = vars.right_monitor, default = true })
hl.workspace_rule({ workspace = "3", monitor = vars.right_monitor })

hl.window_rule({
	match = { class = ".*firefox.*" },
	workspace = "1"
})


hl.window_rule({
	match = { class = ".*tty.*" },
	workspace = "2"
})


hl.window_rule({
	match = { class = ".*[Tt]erm.*" },
	workspace = "2"
})


hl.window_rule({
	match = { class = ".*vesktop.*" },
	workspace = "3"
})
