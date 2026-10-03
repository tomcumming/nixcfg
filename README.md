## Nixos configuration

To refresh latest configuration: `sudo nixos-rebuild switch --flake .`
After next boot: `sudo nixos-rebuild boot --flake .`

### Agent Sandbox

Might need to `podman volume rm ...` after nixpkgs updates.
