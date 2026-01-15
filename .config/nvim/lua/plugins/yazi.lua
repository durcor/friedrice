return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>-",
			function()
				require("yazi").yazi()
			end,
			desc = "Open yazi at the current file",
		},
	},
}
