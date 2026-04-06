{ pkgs, unixpkgs, ... }:
let
  upkgs = import unixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
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
    upkgs.claude-code
    pkgs.opencode
    pkgs.gh

    # Dictionary
    pkgs.aspell
    pkgs.aspellDicts.en
  ];

  programs.bash = {
    enable = true;
  };
}
