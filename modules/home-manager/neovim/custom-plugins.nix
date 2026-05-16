# Vim plugins fetched outside nixpkgs vimPlugins (pinned SHAs).
{ pkgs }:
{
  vimGithubLink = pkgs.vimUtils.buildVimPlugin {
    name = "vim-github-link";
    src = pkgs.fetchFromGitHub {
      owner = "knsh14";
      repo = "vim-github-link";
      rev = "master";
      sha256 = "sha256-FGPtU+/sEULde5G2xwqVqf9kIWwUE426/Ot7uZoW8Pk=";
    };
  };

  vimQfedit = pkgs.vimUtils.buildVimPlugin {
    name = "vim-qfedit";
    src = pkgs.fetchFromGitHub {
      owner = "itchyny";
      repo = "vim-qfedit";
      rev = "master";
      sha256 = "sha256-dzxunlrCDelecXUI4kXRHjtwGpQUXVlcuCPuoZmQ39U";
    };
  };

  kubernetesNvim = pkgs.vimUtils.buildVimPlugin {
    name = "kubernetes-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "diogo464";
      repo = "kubernetes.nvim";
      rev = "main";
      sha256 = "sha256-zq8raDCY6uKf97esbQGNvPAMqi2LzIVt5lRlb53/5PU=";
    };
  };
}
