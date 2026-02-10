local M = {}

-- =====================
-- Theme registry
-- =====================
M.themes = {
	nord = function(opts)
		vim.g.nord_disable_background = opts.transparent
		require("nord").set()
	end,

	tokyonight = function(opts)
		vim.cmd("colorscheme tokyonight")
	end,

	catppuccin = function(opts)
		require("catppuccin").setup({
			transparent_background = opts.transparent,
		})
		vim.cmd("colorscheme catppuccin")
	end,

	gruvbox = function(opts)
		vim.g.gruvbox_transparent_bg = opts.transparent and "1" or "0"
		vim.cmd("colorscheme gruvbox")
	end,

	onedark = function(opts)
		require("onedark").setup({
			transparent = opts.transparent,
		})
		require("onedark").load()
	end,

	["rose-pine"] = function(opts)
		require("rose-pine").setup({
			disable_background = opts.transparent,
		})
		vim.cmd("colorscheme rose-pine")
	end,

	-- Monokai Night (via Monokai Pro)
	["monokai-night"] = function(opts)
		require("monokai-pro").setup({
			transparent_background = opts.transparent,
			filter = "classic", -- [machine,ristretto,pro,classic,octagon,spectrun] filters
		})
		vim.cmd("colorscheme monokai-pro")
	end,
}

-- =====================
-- Explicit theme order
-- =====================
M.order = {
	"nord",
	"tokyonight",
	"catppuccin",
	"gruvbox",
	"onedark",
	"rose-pine",
	"monokai-night",
}

-- =====================
-- State
-- =====================
M.current = 1
M.transparent = true

-- =====================
-- Apply theme
-- =====================
function M.apply()
	local name = M.order[M.current]

	M.themes[name]({ transparent = M.transparent })

	if M.transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
	end
end

-- =====================
-- Controls
-- =====================
function M.next()
	M.current = M.current % #M.order + 1
	M.apply()
end

function M.prev()
	M.current = (M.current - 2) % #M.order + 1
	M.apply()
end

function M.toggle_bg()
	M.transparent = not M.transparent
	M.apply()
end

-- =====================
-- Keymaps
-- =====================
vim.keymap.set("n", "<leader>ty", M.next, { desc = "Next theme" })
vim.keymap.set("n", "<leader>tr", M.prev, { desc = "Previous theme" })
vim.keymap.set("n", "<leader>bg", M.toggle_bg, { desc = "Toggle background" })

-- =====================
-- Startup (SAFE)
-- =====================
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = M.apply,
})

return M
