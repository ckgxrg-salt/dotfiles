{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix-Flatpak
    flatpaks.url = "github:gmodena/nix-flatpak";

    # Hyprland and plugins
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, flatpaks, ... }:
  {
    # Twirisa
    nixosConfigurations.Twirisa = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/twirisa
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg = import ./home/ckgxrg/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
        flatpaks.nixosModules.nix-flatpak
      ];
    };
  };
}

