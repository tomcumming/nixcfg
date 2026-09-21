{ config, pkgs, ... }:

let
  tvSession = pkgs.writeShellScript "tv-session" ''
    case "$(${pkgs.coreutils}/bin/id -un)" in
      steam)
        exec steam-gamescope
        ;;
      tommo)
        exec ${pkgs.niri}/bin/niri-session
        ;;
      *)
        exit 1
        ;;
    esac
  '';
in
{
  services.xserver.enable = false; # Assuming no other Xserver needed
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --user-menu --asterisks --user-menu-max-uid 1999 --cmd ${tvSession}";
      user = "greeter";
    };
  };
}
