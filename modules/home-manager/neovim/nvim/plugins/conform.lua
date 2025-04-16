require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'isort', 'black' },
    javascript = { { 'prettierd', 'prettier' } },
    -- clojure = { 'zprint' },
    clojure = { 'cljfmt' },
    nix = { 'nixfmt' },
  },
})
vim.g.mapleader = ' '
vim.g.maplocalleader = ','


vim.keymap.set({'n','v'}, '<leader>f', function()
          require('conform').format { async = true, lsp_fallback = true }
        end, {desc = '[F]ormat buffer' })

