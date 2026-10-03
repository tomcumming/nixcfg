{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages."${system}";
      upkgs = nixpkgs-unstable.legacyPackages."${system}";
    in
    {
      packages."${system}" = rec {
        agent-image = pkgs.dockerTools.buildImage {
          name = "nixos-agent";
          includeNixDB = true;

          copyToRoot = pkgs.buildEnv {
            name = "image-root";
            paths = with pkgs; [
              # Basics
              bashInteractive
              bubblewrap
              cacert
              coreutils
              nix

              # Tools
              gawk
              curl
              diffutils
              findutils
              git
              gnugrep
              gzip
              jq
              patch
              ripgrep
              gnused
              gnutar
              unzip
              wget
              xz
              zip

              # AI
              upkgs.codex
              upkgs.opencode

              # Nix defaults
              (writeTextDir "etc/nix/nix.conf" ''
                experimental-features = nix-command flakes
                sandbox = false
              '')

            ];
            pathsToLink = [
              "/bin"
              "/etc"
            ];
          };

          extraCommands = ''
            # Needed for 'nix develop' inside sandbox
            mkdir -p nix/store nix/var/nix
            chmod 0755 nix nix/store nix/var nix/var/nix

            # Codex's Bubblewrap sandbox needs a writable temporary directory.
            mkdir -p tmp
            chmod 1777 tmp
          '';

          config = {
            Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
            Env = [
              "PATH=/bin"
              "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            ];
            WorkingDir = "/workspace";
          };
        };

        agent-sandbox = pkgs.writeShellApplication {
          name = "agent-sandbox";
          runtimeInputs = [
            pkgs.podman
            pkgs.coreutils
          ];
          text = ''
            export SANDBOX_IMAGE_ARCHIVE=${agent-image}
            export SANDBOX_IMAGE=localhost/${agent-image.imageName}:${agent-image.imageTag}
            ${builtins.readFile ./agent-sandbox.sh}
          '';
        };

        default = agent-sandbox;
      };

      apps."${system}" = rec {
        agent-sandbox = {
          type = "app";
          program = "${self.packages.${system}.agent-sandbox}/bin/agent-sandbox";
        };
        default = agent-sandbox;
      };

      formatter."${system}" = pkgs.nixpkgs-fmt;
    };
}
