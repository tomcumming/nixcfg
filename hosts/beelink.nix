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

  services.fwupd.enable = true;

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
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ ];

  services.openssh.enable = true;

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.tommo = {
    isNormalUser = true;
    description = "Tommo";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [
      # Commands
      pkgs.git
      pkgs.wget
      pkgs.curl
      pkgs.jq
      pkgs.xz

      # Terminal Apps
      pkgs.ncdu
      pkgs.htop
      pkgs.tmux
      pkgs.helix
      pkgs.gitui
      pkgs.delta
      pkgs.hexyl

      # Dictionary
      pkgs.aspell
      pkgs.aspellDicts.en
    ];
  };

  programs.bash = {
    interactiveShellInit = ''
      if [ "$SHLVL" -le 2 ]; then
        export PS1='\[\e[94m\]\W \[\e[0m\]$ '
      else
        export PS1='\[\e[91m\]\W \[\e[0m\]$ '
      fi

      export EDITOR=hx
    '';
    promptInit = ""; # Don't override my prompt!
  };

  system.activationScripts.copyConfig = ''
    mkdir -p /home/tommo/.config/git
    cp ${./beelink/config/git-config.txt} /home/tommo/.config/git/config
    
    mkdir -p /home/tommo/.config/helix
    cp ${./beelink/config/helix/config.toml} /home/tommo/.config/helix/config.toml
    cp ${./beelink/config/helix/languages.toml} /home/tommo/.config/helix/languages.toml

    mkdir -p /home/tommo/.config/tmux
    cp ${./beelink/config/tmux.conf} /home/tommo/.config/tmux/tmux.conf

    mkdir -p /home/tommo/.config/ncdu
    cp ${./beelink/config/ncdu.txt} /home/tommo/.config/ncdu/config
  '';
}
