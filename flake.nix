{
  description = "Configuration NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = 
	{ 
	  self,
	  nixpkgs, 
	  zen-browser, 
          nixos-hardware,
	  home-manager,
	   ... 
	}@inputs:
    let
 
      externalPackages = { system }: {
        # mon-logiciel = inputs.mon-logiciel.packages.${system}.default;
        zen-browser = zen-browser.packages.${system}.default;
        
       
      };

    in
    {
      nixosConfigurations = {

        "nixos" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          
          modules = [
            ./configuration.nix

	    # Module Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              
              # Ton fichier utilisateur sera 'home.nix'
              home-manager.users.raph = import ./home.nix;

              # On passe les arguments pour que tes autres fichiers fonctionnent
              home-manager.extraSpecialArgs = { 
                inherit inputs;
                external = externalPackages { system = "x86_64-linux"; };
              };
            }
          ];
          
          
          specialArgs = {
             inherit inputs;
             external = externalPackages { system = "x86_64-linux"; };
          };
        };
      };
    };
}
