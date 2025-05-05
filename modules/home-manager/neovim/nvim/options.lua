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
