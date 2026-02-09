return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<A-h>]],
			direction = "horizontal",
			shade_terminals = true,
			start_in_insert = true,
			persist_size = true,
		})
	end,
}
