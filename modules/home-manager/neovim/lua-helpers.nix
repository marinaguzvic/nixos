# Helpers for plugins.neovim: lua heredocs and HM plugin attrs.
{ lib }:
rec {
  luaSnippet = snippet: snippet;

  luaFromFile =
    path:
    ''
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ','
      ${builtins.readFile path}
    '';

  # Explicit type silences HM warnings when home.stateVersion < 26.05
  luaPlugin =
    plugin: config:
    {
      inherit plugin config;
      type = "lua";
    };

  luaPluginFromFile = plugin: file: luaPlugin plugin (luaFromFile file);
  luaPluginFromSnippet = plugin: snippet: luaPlugin plugin (luaSnippet snippet);

  concatLuaFiles = files: lib.concatStringsSep "\n" (map builtins.readFile files);
}
