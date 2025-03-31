-- local make_terminal = "terminal<cr><cmd>setlocal nonumber | setlocal norelativenumber | setlocal signcolumn=no<cr>i"

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<F12>",
			-- global = false,
			loop = true,
			desc = "Meta",
		},
	},
}

-- body = "<F12>",
-- -- hint = true,
-- -- config = {
-- -- 	color = "pink",
-- -- 	hint = "statusline",
-- -- },
-- heads = {
-- 	-- { "n", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>" },
-- 	-- { "p", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>" },
--
-- 	{
-- 		"o",
-- 		function()
-- 			Snacks.terminal.open()
-- 		end,
-- 	},
-- 	{ "-", "<cmd>split | " .. make_terminal },
-- 	{ "_", "<cmd>split | " .. make_terminal },
-- 	{ "\\", "<cmd>vsplit | " .. make_terminal },
-- 	{ "|", "<cmd>vsplit | " .. make_terminal },
-- 	-- window navigation
-- 	{ "h", "<C-w>h<F12>" },
-- 	{ "j", "<C-w>j<F12>" },
-- 	{ "k", "<C-w>k<F12>" },
-- 	{ "l", "<C-w>l<F12>" },
-- 	-- tab navigation
-- 	{ "0", "<cmd>tabfirst<cr><F12>" },
-- 	{ "w", "<cmd>tabnext<cr><F12>" },
-- 	{ "b", "<cmd>tabprevious<cr><F12>" },
-- 	{ "$", "<cmd>tablast<cr><F12>" },
-- 	-- resizing
-- 	{ "H", "<cmd>vertical resize +1<cr><F12>" },
-- 	{ "L", "<cmd>vertical resize -1<cr><F12>" },
-- 	{ "J", "<cmd>resize -1<cr><F12>" },
-- 	{ "K", "<cmd>resize +1<cr><F12>" },
-- 	--
-- 	{ "x", "<cmd>bdelete!<cr><F12>" },
-- 	{ "i", "<Esc>" },
