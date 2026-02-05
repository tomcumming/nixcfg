{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./beelink/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "beelink"; # Define your hostname.

  networking.networkmanager.enable = true;

  # Network
  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  # Configure console keymap
  console.keyMap = "uk";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ ];

  system.stateVersion = "25.11";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.tommo = import ./users/tommo/system.nix;
  users.users.robot = import ./users/robot/system.nix;

  # # Steam junk
  # users.users.steam = {
  #   isNormalUser = true;
  #   description = "Steam";
  #   extraGroups = [ ];
  # };
  # programs.steam.enable = true;
  # programs.gamescope = {
  #   enable = true;
  #   capSysNice = true;
  # };
  # programs.steam.gamescopeSession.enable = true; # Integrates with programs.steam
  # services.xserver.enable = false; # Assuming no other Xserver needed
  # services.getty.autologinUser = "steam";
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.gamescope}/bin/gamescope -W 1920 -H 1080 -f -e --xwayland-count 2 --hdr-enabled --hdr-itm-enabled -- steam -pipewire-dmabuf -gamepadui > /dev/null 2>&1";
  #       user = "steam";
  #     };
  #   };
  # };

  # User stuff
}
