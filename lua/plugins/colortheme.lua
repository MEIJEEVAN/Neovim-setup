return {
	-- =====================
	-- Nord Theme
	-- =====================
	{
		"shaunsingh/nord.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Nord default options
			vim.g.nord_contrast = true
			vim.g.nord_borders = false
			vim.g.nord_disable_background = true -- authentic blue/dark background
			vim.g.nord_italic = false
			vim.g.nord_uniform_diff_background = true
			vim.g.nord_bold = false

			-- =====================
			-- Theme Manager
			-- =====================
			local themes = { "nord", "tokyonight", "catppuccin" }
			local current = 1
			local bg_transparent = true -- start with default background

			local function apply_theme(name)
				if name == "nord" then
					-- Nord handles its main background
					vim.g.nord_disable_background = bg_transparent
					require("nord").set()

					-- Set floating windows / popups correctly
					if not bg_transparent then
						vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#2E3440" }) -- Nord dark background
					else
						vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
					end
				else
					-- Other themes
					vim.cmd("colorscheme " .. name)
					if bg_transparent then
						vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
						vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
					end
				end
			end

			-- Apply default theme
			apply_theme(themes[current])

			-- =====================
			-- Keymaps
			-- =====================
			vim.keymap.set("n", "<leader>ty", function()
				current = current % #themes + 1
				apply_theme(themes[current])
			end, { desc = "Next theme" })

			vim.keymap.set("n", "<leader>tr", function()
				current = (current - 2) % #themes + 1
				apply_theme(themes[current])
			end, { desc = "Previous theme" })

			vim.keymap.set("n", "<leader>bg", function()
				bg_transparent = not bg_transparent
				apply_theme(themes[current])
			end, { desc = "Toggle background" })
		end,
	},

	-- =====================
	-- Other Themes
	-- =====================
	{ "folke/tokyonight.nvim", lazy = false },
	{ "catppuccin/nvim", name = "catppuccin", lazy = false },
}
