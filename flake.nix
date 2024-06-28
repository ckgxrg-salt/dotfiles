{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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

    # Hyprland and plugins
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland.url = "github:hyprwm/Hyprland";
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprfocus = {
      url = "github:VortexCoyote/hyprfocus";
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
  outputs = inputs@{ nixpkgs, flatpaks, ags, home-manager, lanzaboote, ... }: {
    # Twirisa
    nixosConfigurations.Twirisa = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./twirisa
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg.imports =
            [ flatpaks.homeManagerModules.nix-flatpak ./twirisa/home ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    # Cshelipix
    nixosConfigurations.Cshelipix = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./cshelipix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg.imports = [
            flatpaks.homeManagerModules.nix-flatpak
            ags.homeManagerModules.default
            ./cshelipix/home
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
        ./radilopa
        lanzaboote.nixosModules.lanzaboote
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.ckgxrg.imports =
            [ flatpaks.homeManagerModules.nix-flatpak ./radilopa/home ];
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}

