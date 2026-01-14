{
  description = "NixOS configuration for AR.IO gateways";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      deploy-rs,
    }:
    {
      nixosConfigurations.ario = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          disko.nixosModules.disko
          ./modules/configuration.nix
          ./modules/hardware-configuration.nix
        ];
      };

      deploy.nodes.contabo-test = {
        sshUser = "root";
        hostname = "contabo-test";
        remoteBuild = true;

        profiles.system = {
          user = "root";
          path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.ario;
        };
      };

      # This will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
