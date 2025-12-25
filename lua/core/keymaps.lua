-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- save file
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)

-- save file without auto-formatting
vim.keymap.set("n", "<leader>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<C-q>", "<cmd> q <CR>", opts)

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Vertical scroll and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- Find and center
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

-- Resize with arrows
vim.keymap.set("n", "<k>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<j>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<h>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<l>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bdelete!<CR>", opts) -- close buffer
vim.keymap.set("n", "<leader>b", "<cmd> enew <CR>", opts) -- new buffer

-- Window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>h", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window

-- Navigate between splits
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", opts)

-- Tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts) --  go to next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set("n", "<leader>lw", "<cmd>set wrap!<CR>", opts)

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic message" })

vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

--My changes
local map = vim.keymap.set

-- General compile & run shortcut
map("n", "<A-x>", function()
	local filetype = vim.bo.filetype
	local filename = vim.fn.expand("%")
	local command = ""

	if filetype == "c" then
		command = "gcc " .. filename .. " -o " .. filename .. ".out && ./" .. filename .. ".out"
	elseif filetype == "cpp" then
		command = "g++ " .. filename .. " -o " .. filename .. ".out && ./" .. filename .. ".out"
	elseif filetype == "python" then
		command = "python " .. filename
	elseif filetype == "go" then
		command = "go run " .. filename
	elseif filetype == "rust" then
		command = "cargo run"
	elseif filetype == "java" then
		command = "javac " .. filename .. " && java " .. filename:gsub("%.java$", "")
	elseif filetype == "javascript" or filetype == "typescript" then
		command = "node " .. filename
	elseif filetype == "html" then
		command = "live-server " .. vim.fn.expand("%:p:h")
	elseif filetype == "lua" then
		command = "lua " .. filename
	elseif filetype == "asm" or filetype == "nasm" then
		command = "nasm -f elf64 "
			.. filename
			.. " && ld "
			.. filename:gsub("%.asm$", ".o")
			.. " -o "
			.. filename:gsub("%.asm$", "")
			.. " && ./"
			.. filename:gsub("%.asm$", "")
	else
		vim.notify("No runner for " .. filetype)
		return
	end

	vim.cmd("split | terminal " .. command)
end, { desc = "Compile/Run current file" })

--My changes
vim.keymap.set("n", "<A-h>", function()
	vim.cmd("botright split | resize 15 | terminal fish") --terminal in horizontal split
end, { noremap = true, silent = true, desc = "Open fish terminal bottom split" })

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	local ls = require("luasnip")
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	local ls = require("luasnip")
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("n", "<A-c>", ":bdelete!<CR>", opts) -- close output split buffer
