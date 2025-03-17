return {
	"snacks.nvim",
	opts = {
		dashboard = {
			sections = {
				{
					section = "terminal",
					cmd = "cowsay -f tux $(fortune)",
					height = 17,
					padding = 1,
				},
				{
					pane = 2,
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
				{
					action = "<leader>ff",
					key = "f",
				},
			},
		},
	},
}
