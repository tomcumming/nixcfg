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
    pkgs.curl
    pkgs.file
    pkgs.git
    pkgs.jq
    pkgs.wget
    pkgs.xz

    # Terminal Apps
    pkgs.gh
    pkgs.opencode
    upkgs.claude-code

    # Dictionary
    pkgs.aspell
    pkgs.aspellDicts.en
  ];

  programs.bash = {
    enable = true;
  };
}
