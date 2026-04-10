{ pkgs, ... }:
{
  home.username = "steam";
  home.stateVersion = "25.11";
  home.packages = [ pkgs.mangohud ];
}
