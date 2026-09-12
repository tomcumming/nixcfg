{ config, pkgs, ... }:

let
  steamSessionSelect = pkgs.writeShellScriptBin "steamos-session-select" ''
    exec ${config.programs.steam.package}/bin/steam -shutdown
  '';
in
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      env = {
        MANGOHUD = "1";
      };
      steamArgs = [
        "-gamepadui"
        "-steamos3"
        "-pipewire-dmabuf"
      ];
    };
  };
  environment.systemPackages = [ steamSessionSelect ];
  programs.gamescope = {
    enable = true;
    args = [
      "-W"
      "1920"
      "-H"
      "1080"
      "-r"
      "60"
    ];
  };
  services.seatd.enable = true;
}
