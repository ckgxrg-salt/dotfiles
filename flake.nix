{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Lix is a fork of Nix
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #custom packages
    ckgpkgs = {
      url = "path:/home/ckgxrg/.config/nixos/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # The Rust overlay
    rust-overlay.url = "github:oxalica/rust-overlay";
    # Lanzaboote Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Flatpak
    flatpaks.url = "github:gmodena/nix-flatpak";
    # Nix-Alien
    nix-alien.url = "github:thiagokokada/nix-alien";
    # NixVim
    nixvim.url = "github:nix-community/nixvim";
    # Howdy pkgs
    howdy.url = "github:fufexan/nixpkgs/howdy";

    # Hyprland and plugins
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    ags.url = "github:Aylur/ags";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      ckgpkgs,
      flatpaks,
      ags,
      home-manager,
      lanzaboote,
      nixvim,
      lix,
      ...
    }:
    {
      # Daywarden
      nixosConfigurations.Daywatchman = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          ckgs = ckgpkgs.packages.${system};
        };
        modules = [
          ./daywatchman
          lanzaboote.nixosModules.lanzaboote
          lix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ckgxrg.imports = [
              flatpaks.homeManagerModules.nix-flatpak
              ags.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
              ckgpkgs.homeManagerModules.ckgmods
              ./daywatchman/home
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              ckgs = ckgpkgs.packages.${system};
            };
          }
        ];
      };

      #Radilopa
      nixosConfigurations.Radilopa = nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inherit inputs;
          ckgs = ckgpkgs.packages.${system};
        };
        system = "x86_64-linux";
        modules = [
          ./radilopa
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager
          lix.nixosModules.default
          ckgpkgs.nixosModules.ckgsys
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ckgxrg.imports = [
              flatpaks.homeManagerModules.nix-flatpak
              nixvim.homeManagerModules.nixvim
              ckgpkgs.homeManagerModules.ckgmods
              ./radilopa/home
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              ckgs = ckgpkgs.packages.${system};
            };
          }
        ];
      };
    };
}
