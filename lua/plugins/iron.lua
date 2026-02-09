return {
	"Vigemus/iron.nvim",
	cmd = { "IronRepl", "IronSend", "IronFocus", "IronHide" },
	config = function()
		local iron = require("iron.core")

		iron.setup({
			config = {
				repl_definition = {
					python = {
						command = { "python3" },
					},
				},
				repl_open_cmd = "vsplit",
			},
			keymaps = {
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_file = "<space>sf",
				send_line = "<space>sl",
				send_mark = "<space>sm",
				mark_motion = "<space>mc",
				mark_visual = "<space>mc",
				remove_mark = "<space>md",
				cr = "<space>s<cr>",
				interrupt = "<space>s<space>",
				exit = "<space>sq",
				clear = "<space>cl",
			},
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true,
		})
	end,
}
