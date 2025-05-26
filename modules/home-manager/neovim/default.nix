{ config, pkgs, ... }:
{
  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile =
        file:
        "lua << EOF\nvim.g.mapleader = ' '\nvim.g.maplocalleader = ','\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      catppuccin.enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      extraPackages = with pkgs; [
        lua-language-server
        nil
        luajitPackages.lua-lsp
        luajitPackages.jsregexp
        python312Packages.pynvim
        xclip
        wl-clipboard
        clojure-lsp
        # linsters
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
        nixfmt-rfc-style

      ];
      extraLuaConfig = ''
        ${builtins.readFile ./nvim/options.lua}
        ${builtins.readFile ./nvim/lsp.lua}
      '';

      plugins = with pkgs.vimPlugins; [
        # Editting and formatting
        nvim-comment
        {
          plugin = todo-comments-nvim;
          config = toLua "require('todo-comments').setup({ signs = false})";
        }
        {
          plugin = avante-nvim;
          config = toLuaFile ./nvim/plugins/avante.lua;
        }
        indent-blankline-nvim
        vim-repeat
        vim-surround
        vim-sexp
        conjure
        {
          plugin = nvim-lint;
          config = toLuaFile ./nvim/plugins/nvim-lint.lua;
        }
        {
          plugin = conform-nvim;
          config = toLuaFile ./nvim/plugins/conform.lua;
        }

        vim-sexp-mappings-for-regular-people
        {

          plugin = autoclose-nvim;
          config = toLuaFile ./nvim/plugins/autoclose.lua;
        }

        {
          plugin = gitsigns-nvim;
          config = toLuaFile ./nvim/plugins/gitsigns.lua;
        }
        # Search
        plenary-nvim
        telescope-fzf-native-nvim
        telescope-ui-select-nvim
        nvim-web-devicons
        {
          plugin = telescope-nvim;
          config = toLuaFile ./nvim/plugins/telescope.lua;
        }
        # LSP
        fidget-nvim
        cmp-nvim-lsp
        nvim-lspconfig
        neodev-nvim

        #Autocompletion
        luasnip
        cmp_luasnip
        cmp-path
        cmp-nvim-lsp-signature-help
        {
          plugin = friendly-snippets;
          config = toLua "require('luasnip.loaders.from_vscode').lazy_load()";
        }
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugins/nvim-cmp.lua;
        }
        # Making it pretty
        {
          plugin = tokyonight-nvim;
          config = toLuaFile ./nvim/plugins/tokyonight.lua;
        }
        todo-comments-nvim
        # Navigation
        {
          plugin = (
            nvim-treesitter.withPlugins (p: [
              p.tree-sitter-nix
              p.tree-sitter-vim
              p.tree-sitter-bash
              p.tree-sitter-lua
              p.tree-sitter-python
              p.tree-sitter-json
              p.tree-sitter-c
              p.tree-sitter-cpp
              p.tree-sitter-go
              p.tree-sitter-rust
              p.tree-sitter-html
              p.tree-sitter-css
              p.tree-sitter-clojure
              p.tree-sitter-dockerfile
              p.tsx
              p.markdown

            ])
          );
          config = toLuaFile ./nvim/plugins/treesitter.lua;
        }
        nui-nvim
        {
          plugin = neo-tree-nvim;
          config = toLuaFile ./nvim/plugins/neo-tree.lua;
        }
        nvim-window-picker
        {
          plugin = which-key-nvim;
          config = toLuaFile ./nvim/plugins/which-key.lua;
        }
        {
          plugin = lsp_signature-nvim;
          config = toLuaFile ./nvim/plugins/lsp-signature.lua;
        }
        {
          plugin = (
            pkgs.vimUtils.buildVimPlugin {
              name = "vim-github-link";
              src = pkgs.fetchFromGitHub {
                owner = "knsh14";
                repo = "vim-github-link";
                rev = "master";
                sha256 = "sha256-FGPtU+/sEULde5G2xwqVqf9kIWwUE426/Ot7uZoW8Pk=";
              };
            }
          );
          config = toLuaFile ./nvim/plugins/gh-link.lua;
        }
        (pkgs.vimUtils.buildVimPlugin {
          name = "vim-qfedit";
          src = pkgs.fetchFromGitHub {
            owner = "itchyny";
            repo = "vim-qfedit";
            rev = "master";
            sha256 = "sha256-4ifqqrx293+jPCnxA+nqOj7Whr2FkM+iuQ8ycxs55X0=";
          };
        })

      ];

    };
}
