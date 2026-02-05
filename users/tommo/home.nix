{ pkgs, ... }:
{
  home.username = "tommo";
  home.homeDirectory = "/home/tommo";
  home.stateVersion = "25.11";

  home.packages = [
    # Commands
    pkgs.file
    pkgs.git
    pkgs.wget
    pkgs.curl
    pkgs.jq
    pkgs.xz
    pkgs.tokei
    pkgs.bubblewrap

    # Terminal Apps
    pkgs.ncdu
    pkgs.htop
    pkgs.tmux
    pkgs.helix
    pkgs.gitui
    pkgs.delta
    pkgs.hexyl
    pkgs.nix-tree

    # Dictionary
    pkgs.aspell
    pkgs.aspellDicts.en
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ "$SHLVL" -le 2 ]; then
        export PS1='\[\e[94m\]\W \[\e[0m\]$ '
      else
        export PS1='\[\e[91m\]\W \[\e[0m\]$ '
      fi
    '';
    sessionVariables = {
      EDITOR = "hx";
    };
  };

  xdg.configFile = {
    "git/config".source = ./config/git-config.txt;
    "helix/config.toml".source = ./config/helix/config.toml;
    "helix/languages.toml".source = ./config/helix/languages.toml;
    "tmux/tmux.conf".source = ./config/tmux.conf;
    "ncdu/config".source = ./config/ncdu.txt;
  };
}
