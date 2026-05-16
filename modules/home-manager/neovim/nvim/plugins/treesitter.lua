-- Grammars are installed declaratively via nix (withPlugins).
local filetypes = {
  'bash',
  'c',
  'clojure',
  'cpp',
  'css',
  'dockerfile',
  'go',
  'html',
  'javascript',
  'javascriptreact',
  'json',
  'lua',
  'markdown',
  'nix',
  'python',
  'rust',
  'sh',
  'tsx',
  'typescript',
  'typescriptreact',
  'vim',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
