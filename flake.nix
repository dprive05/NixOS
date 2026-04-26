{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:

    {
      nixosConfigurations.raph-framework = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
        ];
        specialArgs = {
          inherit inputs;
          zen-browser = inputs.zen-browser.packages."x86_64-linux".default;
        };
      };
    };
}
