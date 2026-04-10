{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./beelink/hardware-configuration.nix
    ../users/steam/service.nix
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

  # Graphics
  hardware.graphics.enable = true;

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

  environment.systemPackages = [ pkgs.bindfs ];

  system.stateVersion = "25.11";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.tommo = import ../users/tommo/system.nix;

  # Robot account
  users.users.robot = import ../users/robot/system.nix;
  fileSystems."/home/tommo/robot-home" = {
    device = "/home/robot";
    fsType = "fuse.bindfs";
    options = [ "map=robot/tommo" ];
  };

  # Steam
  users.users.steam = import ../users/steam/system.nix;
}
