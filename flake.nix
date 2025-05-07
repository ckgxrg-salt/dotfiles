{
  description = "ckgxrg's NixOS Configuration";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use Lix
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

    # Private information
    ckgprv = {
      url = "git+ssh://git@github.com/ckgxrg-salt/private-dotfiles";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Secrix secret tool
    secrix = {
      url = "github:Platonic-Systems/secrix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Lanzaboote Secureboot
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    daywatch-astal = {
      url = "github:ckgxrg-salt/daywatch-astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vistath-astal = {
      url = "github:ckgxrg-salt/vistath-astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      lix-module,
      nur,
      ckgpkgs,
      daywatch-astal,
      vistath-astal,
      disko,
      ckgprv,
      secrix,
      home-manager,
      lanzaboote,
      nixvim,
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
        # Daywatch
        Daywatch = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./daywatch
            ./modules/nixos
            lix-module.nixosModules.default
            nur.modules.nixos.default
            ckgprv.nixosModules.default
            secrix.nixosModules.secrix
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ckgxrg.imports = [
                ./daywatch/home
                ./modules/home-manager
                nixvim.homeManagerModules.nixvim
                ckgprv.homeManagerModules.private
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs daywatch-astal;
              };
            }
          ];
        };

        # Rhyslow
        Rhyslow = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./rhyslow
            ./modules/nixos
            lix-module.nixosModules.default
            nur.modules.nixos.default
            ckgprv.nixosModules.default
            secrix.nixosModules.secrix
            lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ckgxrg.imports = [
                ./rhyslow/home
                ./modules/home-manager
                nixvim.homeManagerModules.nixvim
                ckgprv.homeManagerModules.private
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };

        # Vistath
        Vistath = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./vistath
            ./modules/nixos
            lix-module.nixosModules.default
            nur.modules.nixos.default
            ckgprv.nixosModules.default
            secrix.nixosModules.secrix
            lanzaboote.nixosModules.lanzaboote
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ckgxrg.imports = [
                ./vistath/home
                ./modules/home-manager
                nixvim.homeManagerModules.nixvim
                ckgprv.homeManagerModules.private
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs vistath-astal;
              };
            }
          ];
        };
      };

      apps.x86_64-linux.secrix = secrix.secrix self;

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
        ];
      };

      # Support `nix fmt` command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
