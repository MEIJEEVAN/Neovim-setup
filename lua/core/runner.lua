vim.keymap.set("n", "<A-x>", function()
	local ok, term = pcall(require, "toggleterm.terminal")
	if not ok then
		vim.notify("toggleterm.nvim not loaded", vim.log.levels.ERROR)
		return
	end

	local Terminal = term.Terminal

	if not _G.__runner then
		_G.__runner = Terminal:new({
			hidden = true,
			direction = "horizontal",
			close_on_exit = false, -- 🔥 REQUIRED
			start_in_insert = true,
		})
	end

	local ft = vim.bo.filetype
	local file = vim.fn.expand("%:p")
	local cmd

	if ft == "c" then
		cmd = string.format("gcc '%s' -o /tmp/a.out && /tmp/a.out; echo; read", file)
	elseif ft == "cpp" then
		cmd = string.format("g++ '%s' -o /tmp/a.out && /tmp/a.out; echo; read", file)
	elseif ft == "python" then
		cmd = "python '" .. file .. "'; echo; read"
	elseif ft == "go" then
		cmd = "go run '" .. file .. "'; echo; read"
	elseif ft == "rust" then
		cmd = "cargo run; echo; read"
	elseif ft == "lua" then
		cmd = "lua '" .. file .. "'; echo; read"
	else
		vim.notify("No runner for " .. ft, vim.log.levels.WARN)
		return
	end

	_G.__runner.cmd = cmd
	_G.__runner:open() -- 👈 NEVER toggle for runners
end, { desc = "Run current file (stable runner)" })
