{ pkgs, ... }:
{
  home.username = "steam";
  home.stateVersion = "26.05";
  home.packages = [ pkgs.mangohud ];
}
