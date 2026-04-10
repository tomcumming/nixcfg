{ ... }:
{
  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
      env = {
        MANGOHUD = "1";
      };
    };
  };
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  services.xserver.enable = false; # Assuming no other Xserver needed
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "steam-gamescope";
      user = "steam";
    };
  };
}
