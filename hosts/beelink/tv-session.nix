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
      robot)
        exec ${pkgs.bashInteractive}/bin/bash --login
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
  security.pam.services.greetd.rules.auth.steamPasswordless = {
    order = config.security.pam.services.greetd.rules.auth.unix.order - 10;
    control = "sufficient";
    modulePath = "${config.security.pam.package}/lib/security/pam_succeed_if.so";
    args = [
      "quiet"
      "user"
      "="
      "steam"
    ];
  };
}
