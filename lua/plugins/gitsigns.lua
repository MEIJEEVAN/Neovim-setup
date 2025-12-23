-- Adds git related signs to the gutter, as well as utilities for managing changes
return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		signs_staged = {
			add = { text = "✓" },
			change = { text = "≈" },
			delete = { text = "✗" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", gs.next_hunk, "Next git hunk")
			map("n", "[h", gs.prev_hunk, "Previous git hunk")

			-- Actions (think Git verbs)
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("n", "<leader>hu", gs.undo_stage_hunk, "Unstage hunk")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

			-- File-level
			map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

			-- Blame & diff
			map("n", "<leader>hb", gs.blame_line, "Blame line")
			map("n", "<leader>hd", gs.diffthis, "Diff this")

			-- Visual mode (important)
			map("v", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("v", "<leader>hr", gs.reset_hunk, "Reset hunk")
		end,
	},
}
