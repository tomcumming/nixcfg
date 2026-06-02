{ pkgs, ... }:
{
  home.username = "tommo";
  home.homeDirectory = "/home/tommo";
  home.stateVersion = "26.05";

  home.packages = [
    # Commands
    pkgs.bat
    pkgs.bubblewrap
    pkgs.curl
    pkgs.file
    pkgs.git
    pkgs.jq
    pkgs.tokei
    pkgs.wget
    pkgs.xz

    # Terminal Apps
    pkgs.delta
    pkgs.gitui
    pkgs.helix
    pkgs.hexyl
    pkgs.htop
    pkgs.ncdu
    pkgs.nix-tree
    pkgs.tmux

    # Dictionary
    pkgs.aspell
    pkgs.aspellDicts.en
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      __set_prompt() {
        if [ -n "$IN_NIX_SHELL" ]; then
          PS1='\[\e[91m\]\W \[\e[0m\]$ '
        else
          PS1='\[\e[94m\]\W \[\e[0m\]$ '
        fi
      }
      PROMPT_COMMAND=__set_prompt
    '';
    sessionVariables = {
      EDITOR = "hx";
      NIX_SHELL_PRESERVE_PROMPT = 1;
    };
    shellAliases = {
      hh = "history -a && $EDITOR ~/.bash_history";
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
