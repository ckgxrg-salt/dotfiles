{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Lanzaboote Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Flatpak
    flatpaks.url = "github:gmodena/nix-flatpak";

    # Nix-Alien
    nix-alien.url = "github:thiagokokada/nix-alien";

    # Hyprland and plugins
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ nixpkgs, flatpaks, home-manager, lanzaboote, ... }:
  {
    # Twirisa
    nixosConfigurations.Twirisa = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/twirisa
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg.imports = [
            flatpaks.homeManagerModules.nix-flatpak
            ./home/ckgxrg/phosphorium.nix
          ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    #Radilopa
    nixosConfigurations.Radilopa = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/radilopa
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg.imports = [
            flatpaks.homeManagerModules.nix-flatpak
            ./home/ckgxrg/halosviga.nix
          ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}

