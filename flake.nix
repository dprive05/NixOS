{
  description = "Configuration NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = 
	{ 
	  self,
	  nixpkgs, 
	  zen-browser, 
          nixos-hardware,
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
          ];
          
          
          specialArgs = {
             inherit inputs;
             external = externalPackages { system = "x86_64-linux"; };
          };
        };
      };
    };
}
