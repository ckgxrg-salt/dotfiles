{
  description = "ckgxrg's Dotfiles";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom packages
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Private information
    ckgprv = {
      url = "git+ssh://git@github.com/ckgxrg-salt/private-dotfiles";
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

    # AGS
    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.astal.follows = "astal";
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
      lix-module,
      ckgpkgs,
      ckgprv,
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
      nixosConfigurations = {
        # Daywatch
        Daywatch = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            ckgs = ckgpkgs.packages.${system};
          };
          modules = [
            ./daywatch
            lix-module.nixosModules.default
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
                ckgprv.homeManagerModules.private
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs;
                ckgs = ckgpkgs.packages.${system};
              };
            }
          ];
        };

        # Radilopa
        Radilopa = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            ckgs = ckgpkgs.packages.${system};
          };
          inherit system;
          modules = [
            ./radilopa
            lix-module.nixosModules.default
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

        # Temporary
        Welkin = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./welkin
            lix-module.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            microvm.nixosModules.host
          ];
        };
      };

      # The home server...
      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
          };
        };

        Welkin = {
          deployment = {
            buildOnTarget = true;
            targetUser = "akacloud";
            tags = [ "welkin" ];
          };
          imports = [
            ./welkin
            lix-module.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            microvm.nixosModules.host
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShell {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
          colmena
        ];

        shellHook = ''
          exec nu
        '';
      };

      # Support nix fmt command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
