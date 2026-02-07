{ pkgs, ... }:
{

  home.username = "robot";
  home.homeDirectory = "/home/robot";
  home.stateVersion = "25.11";

  home.packages = [
    # Commands
    pkgs.file
    pkgs.git
    pkgs.wget
    pkgs.curl
    pkgs.jq
    pkgs.xz

    # Terminal Apps
    pkgs.htop
    pkgs.tmux
    pkgs.delta
    pkgs.hexyl
    pkgs.claude-code
    pkgs.opencode

    # Dictionary
    pkgs.aspell
    pkgs.aspellDicts.en
  ];

  programs.bash = {
    enable = true;
  };
}
