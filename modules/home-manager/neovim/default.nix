# Home Manager: Neovim with declarative plugins and Lua config.
{ config, pkgs, lib, ... }:

let
  luaHelpers = import ./lua-helpers.nix { inherit lib; };
  customPlugins = import ./custom-plugins.nix { inherit pkgs; };
  nvimDir = ./nvim;
in
{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = import ./extra-packages.nix { inherit pkgs; };

    initLua = luaHelpers.concatLuaFiles [
      (nvimDir + "/options.lua")
      (nvimDir + "/lsp.lua")
    ];

    plugins = import ./plugins.nix {
      inherit pkgs customPlugins nvimDir;
      lua = luaHelpers;
    };
  };
}
