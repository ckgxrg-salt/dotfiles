{
  description = "ckgxrg's NixOS Configuration";
  inputs = {
    # Nixpkgs source
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use Lix
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/stable.tar.gz";
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
  };
  outputs =
    {
      self,
      nixpkgs,
      lix-module,
      ckgprv,
      ags,
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
    in
    {
      nixosConfigurations = {
        # Daywatch
        Daywatch = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            ckgs = self.packages.${system};
          };
          modules = [
            ./daywatch
            ./modules/nixos
            lix-module.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ckgxrg.imports = [
                ./daywatch/home
                ./modules/home-manager
                ags.homeManagerModules.default
                nixvim.homeManagerModules.nixvim
                ckgprv.homeManagerModules.private
              ];
              home-manager.extraSpecialArgs = {
                ckgs = self.packages.${system};
              };
            }
          ];
        };

        # Radilopa
        Radilopa = nixpkgs.lib.nixosSystem {
          specialArgs = {
            ckgs = self.packages.${system};
          };
          inherit system;
          modules = [
            ./radilopa
            ./modules/nixos
            lix-module.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ckgxrg.imports = [
                ./radilopa/home
                ./modules/home-manager
                nixvim.homeManagerModules.nixvim
              ];
              home-manager.extraSpecialArgs = {
                ckgs = self.packages.${system};
              };
            }
          ];
        };
      };

      # Inline ckgpkgs
      packages.${system} = with pkgs; {
        alacritty-themes = callPackage ./ckgpkgs/theming/alacritty-themes.nix { };
        googledot-cursor = callPackage ./ckgpkgs/theming/googledot-cursor.nix { };
        nu-scripts = callPackage ./ckgpkgs/theming/nu-scripts.nix { };
        otis-gtk = callPackage ./ckgpkgs/theming/otis-gtk.nix { };
        vivid-icons = callPackage ./ckgpkgs/theming/vivid-icons.nix { };
        wvkbd-desktop = callPackage ./ckgpkgs/wvkbd-desktop.nix { };
        fyrox-template = callPackage ./ckgpkgs/fyrox-template.nix { };
        rofi-themes = callPackage ./ckgpkgs/theming/rofi-themes.nix { };
        maple-ui = callPackage ./ckgpkgs/theming/maple-ui.nix { };
      };

      # A nix develop shell including formatter and linter to be used with Neovim
      devShells.${system}.default = pkgs.mkShellNoCC {
        name = "dotfiles";

        buildInputs = with pkgs; [
          nixfmt-rfc-style
          deadnix
        ];

        shellHook = ''
          exec nu
        '';
      };

      # Support `nix fmt` command
      formatter.${system} = pkgs.nixfmt-rfc-style;
    };
}
