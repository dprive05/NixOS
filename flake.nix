{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      ...
    }@inputs:

    {
      nixosConfigurations.raph-framework = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
	  nixos-hardware.nixosModules.framework-16-7040-amd
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
}
