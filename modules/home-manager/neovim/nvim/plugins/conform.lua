require("conform").setup({
	-- format_on_save = {
	-- 	-- These options will be passed to conform.format()
	-- 	timeout_ms = 500,
	-- 	lsp_format = "fallback",
	-- },
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		javascript = {  "prettierd" , stop_after_first = true },
		clojure = { "zprint" },
		-- clojure = { 'cljfmt' },
    terraform = { "terraform_fmt"},
		nix = { "nixfmt" },
    yaml = { "prettierd" },
	},
})
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "[F]ormat buffer" })
