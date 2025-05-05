-- Leader and local leader. Local leader is for a specific file types
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ','
-- Not including this here, since those are necessary for the other plugins

-- Make line numbers default
vim.opt.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Make TAB 2 whitespaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

-- Select text visually and replace it
vim.keymap.set("v", "<leader>r", function()
	-- Save current register and mode
	local old_reg = vim.fn.getreg('"')
	local old_regtype = vim.fn.getregtype('"')

	-- Yank visual selection into the default register
	vim.cmd('normal! ""y')

	-- Get the selected text
	local selection = vim.fn.getreg('"')
	local escaped_selection = selection:gsub("\n", "\\n")
	escaped_selection = vim.fn.escape(escaped_selection, [[\/.*$^~[]])

	-- Show prompt with the unescaped selection for user clarity
	local replacement = vim.fn.input(string.format("Replace '%s' with: ", selection))

	-- Perform the substitution
	vim.cmd(string.format("%%s/%s/%s/gc", escaped_selection, replacement))

	-- Restore original register
	vim.fn.setreg('"', old_reg, old_regtype)
end, { desc = "Search and replace visual selection" })

-- Add a shorcut to copy to clipboard the test name for Clojure files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "clojure",
	callback = function()
		vim.keymap.set("n", "<localleader>ct", function()
			local ns = nil
			local test_name = nil

			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local cursor_row = vim.api.nvim_win_get_cursor(0)[1]

			-- Extract the namespace form
			local ns_lines = {}
			local found_ns = false
			local paren_depth = 0

			for _, line in ipairs(lines) do
				if not found_ns then
					if line:match("^%s*%(%s*ns%s") then
						found_ns = true
					end
				end

				if found_ns then
					table.insert(ns_lines, line)

					-- crude paren tracking
					for c in line:gmatch(".") do
						if c == "(" then
							paren_depth = paren_depth + 1
						elseif c == ")" then
							paren_depth = paren_depth - 1
						end
					end

					if paren_depth <= 0 then
						break
					end
				end
			end

			if #ns_lines > 0 then
				local joined = table.concat(ns_lines, " ")
				ns = joined:match("%(ns%s+([%w%._%-]+)")
			end

			-- First look down (including cursor line)
			for i = cursor_row, math.min(cursor_row + 10, #lines) do
				local line = lines[i]
				local match = line:match("%(deftest%s+[^%s%(%)]+%s+([%w%-_%?!]+)")
					or line:match("%(deftest%s+([%w%-_%?!]+)")
				if match then
					test_name = match
					break
				end
			end

			-- If not found, look upwards
			if not test_name then
				for i = cursor_row - 1, math.max(cursor_row - 15, 1), -1 do
					local line = lines[i]
					local match = line:match("%(deftest%s+[^%s%(%)]+%s+([%w%-_%?!]+)")
						or line:match("%(deftest%s+([%w%-_%?!]+)")
					if match then
						test_name = match
						break
					end
				end
			end
			if ns and test_name then
				local full_name = ns .. "/" .. test_name
				vim.fn.setreg("+", full_name)
				vim.notify("Copied: " .. full_name, vim.log.levels.INFO)
			else
				vim.notify(
					"Namespace or test name not found.\nns: " .. tostring(ns) .. "\ntest: " .. tostring(test_name),
					vim.log.levels.ERROR
				)
			end
		end, { buffer = true, desc = "Copy Clojure test name", noremap = true, silent = true })
	end,
})
