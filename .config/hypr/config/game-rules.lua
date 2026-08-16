local selectors = {
	{
		name = "cs2",
		immediate = true,
	},
	{
		name = "steam_app.*",
	},
}

for _, value in ipairs(selectors) do
	hl.window_rule({
		match = { class = value.name },
		workspace = "5",
		immediate = value.immediate or false,
	})
end


hl.window_rule({
	match = { class = "net.lutris.Lutris" },
	workspace = "4",
})
