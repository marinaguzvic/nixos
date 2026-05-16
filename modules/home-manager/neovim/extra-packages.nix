# LSP / formatters / linters used by Neovim (not vimPlugins).
{ pkgs }:
with pkgs; [
  lua-language-server
  nil
  luajitPackages.lua-lsp
  luajitPackages.jsregexp
  python312Packages.pynvim
  xclip
  clojure-lsp
  gopls
  clj-kondo
  vale
  hadolint
  stylua
  black
  isort
  prettierd
  zprint
  ripgrep
  cljfmt
  nixfmt
]
