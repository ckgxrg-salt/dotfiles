{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Custom packages
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Lanzaboote Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix-Alien
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland and plugins
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };
    hyprgrass = {
      url = "github:horriblename/hyprgrass";
      inputs.hyprland.follows = "hyprland";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # microvm.nix
    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      nixpkgs,
      ckgpkgs,
      ags,
      home-manager,
      lanzaboote,
      nixvim,
      microvm,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # Daywatchman
      nixosConfigurations.Daywatch = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          ckgs = ckgpkgs.packages.${system};
        };
        modules = [
          ./daywatch
          lanzaboote.nixosModules.lanzaboote
          ckgpkgs.nixosModules.ckgsys
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ckgxrg.imports = [
              ./daywatch/home
              ags.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
              ckgpkgs.homeManagerModules.ckgmods
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              ckgs = ckgpkgs.packages.${system};
            };
          }
        ];
      };

      #Radilopa
      nixosConfigurations.Radilopa = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          ckgs = ckgpkgs.packages.${system};
        };
        inherit system;
        modules = [
          ./radilopa
          lanzaboote.nixosModules.lanzaboote
          ckgpkgs.nixosModules.ckgsys
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ckgxrg.imports = [
              ./radilopa/home
              nixvim.homeManagerModules.nixvim
              ckgpkgs.homeManagerModules.ckgmods
            ];
            home-manager.extraSpecialArgs = {
              inherit inputs;
              ckgs = ckgpkgs.packages.${system};
            };
          }
        ];
      };

      # The home server...
      nixosConfigurations.Welkin = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        inherit system;
        modules = [
          ./welkin
          lanzaboote.nixosModules.lanzaboote
          microvm.nixosModules.host
        ];
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShell {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
        ];

        shellHook = ''
          exec nu
        '';
      };

      # Support nix fmt command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
