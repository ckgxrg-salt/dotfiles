{
  description = "ckgxrg's NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/release-2.92.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ckgpkgs = {
      url = "github:ckgxrg-salt/ckgpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur.follows = "nur";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };
  outputs =
    {
      nixpkgs,
      lix-module,
      nur,
      ckgpkgs,
      disko,
      sops-nix,
      home-manager,
      lanzaboote,
      nixvim,
      stylix,
      aagl,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      ckgs = ckgpkgs.packages.${system};
    in
    {
      nixosConfigurations = {
        Daywatch = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/daywatch/os.nix
            ./os
            lix-module.nixosModules.default
            nur.modules.nixos.default
            lanzaboote.nixosModules.lanzaboote
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.users.ckgxrg.imports = [
                ./hosts/daywatch/home.nix
                ./home
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };

        Rhyslow = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/rhyslow/os.nix
            ./os
            lix-module.nixosModules.default
            nur.modules.nixos.default
            lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            stylix.nixosModules.stylix
            aagl.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.users.ckgxrg.imports = [
                ./hosts/rhyslow/home.nix
                ./home
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };

        Vistath = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/vistath/os.nix
            ./os
            lix-module.nixosModules.default
            nur.modules.nixos.default
            lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.users.ckgxrg.imports = [
                ./hosts/vistath/home.nix
                ./home
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };

        Asedia = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/asedia/os.nix
            ./os
            lix-module.nixosModules.default
            nur.modules.nixos.default
            nixos-hardware.nixosModules.microsoft-surface-common
            disko.nixosModules.disko
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
              home-manager.users.ckgxrg.imports = [
                ./hosts/asedia/home.nix
                ./home
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
          sops
        ];
      };

      # Support `nix fmt` command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
