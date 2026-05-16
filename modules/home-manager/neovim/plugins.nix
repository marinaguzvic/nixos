# Neovim plugin list (pkgs.vimPlugins + custom fetchers).
{
  pkgs,
  lua,
  customPlugins,
  nvimDir,
}:

let
  inherit (lua) luaPluginFromFile luaPluginFromSnippet;
  inherit (customPlugins) vimGithubLink vimQfedit kubernetesNvim;
  p = nvimDir + "/plugins";

  treesitterGrammars = ts: [
    ts.tree-sitter-nix
    ts.tree-sitter-vim
    ts.tree-sitter-bash
    ts.tree-sitter-lua
    ts.tree-sitter-python
    ts.tree-sitter-json
    ts.tree-sitter-c
    ts.tree-sitter-cpp
    ts.tree-sitter-go
    ts.tree-sitter-rust
    ts.tree-sitter-html
    ts.tree-sitter-css
    ts.tree-sitter-clojure
    ts.tree-sitter-dockerfile
    ts.tsx
    ts.markdown
  ];
in

with pkgs.vimPlugins; [
  nvim-comment
  (luaPluginFromSnippet todo-comments-nvim ''
    require('todo-comments').setup({ signs = false})
  '')
  indent-blankline-nvim
  vim-repeat
  vim-surround
  vim-sexp
  conjure
  (luaPluginFromFile nvim-lint (p + "/nvim-lint.lua"))
  (luaPluginFromFile conform-nvim (p + "/conform.lua"))

  vim-sexp-mappings-for-regular-people
  (luaPluginFromFile autoclose-nvim (p + "/autoclose.lua"))

  (luaPluginFromFile gitsigns-nvim (p + "/gitsigns.lua"))

  plenary-nvim
  telescope-fzf-native-nvim
  telescope-ui-select-nvim
  telescope-file-browser-nvim
  nvim-web-devicons
  (luaPluginFromFile telescope-nvim (p + "/telescope.lua"))

  fidget-nvim
  cmp-nvim-lsp
  nvim-lspconfig
  neodev-nvim

  luasnip
  cmp_luasnip
  cmp-path
  cmp-nvim-lsp-signature-help
  (luaPluginFromSnippet friendly-snippets ''
    require('luasnip.loaders.from_vscode').lazy_load()
  '')
  (luaPluginFromFile nvim-cmp (p + "/nvim-cmp.lua"))

  (luaPluginFromFile tokyonight-nvim (p + "/tokyonight.lua"))

  {
    plugin = nvim-treesitter.withPlugins treesitterGrammars;
    type = "lua";
    config = lua.luaFromFile (p + "/treesitter.lua");
  }

  nui-nvim
  (luaPluginFromFile neo-tree-nvim (p + "/neo-tree.lua"))
  nvim-window-picker
  (luaPluginFromFile which-key-nvim (p + "/which-key.lua"))
  (luaPluginFromFile lsp_signature-nvim (p + "/lsp-signature.lua"))
  (luaPluginFromFile vimGithubLink (p + "/gh-link.lua"))
  (luaPluginFromFile vim-fugitive (p + "/fugitive.lua"))
  (luaPluginFromFile vim-projectionist (p + "/projectionist.lua"))

  vimQfedit
  { plugin = kubernetesNvim; }
]
