{
  description = "ckgxrg's NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ckgpkgs = {
      url = "git+https://codeberg.org/ckgxrg/ckgpkgs";
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

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nur.follows = "nur";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      nur,
      ckgpkgs,
      disko,
      sops-nix,
      home-manager,
      lanzaboote,
      stylix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      ckgs = ckgpkgs.packages.${system};
    in
    {
      nixosConfigurations = {
        Rhyslow = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/rhyslow/os.nix
            ./os
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
                ./hosts/rhyslow/home.nix
                ./home
              ];
              home-manager.extraSpecialArgs = {
                inherit ckgs;
              };
            }
          ];
        };

        Daywatch = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit ckgs;
          };
          modules = [
            ./hosts/daywatch/os.nix
            ./os
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
                ./hosts/daywatch/home.nix
                ./home
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
          stylua
          sops
        ];
      };

      # Support `nix fmt` command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
