{ lib, vars, ... }:

{
  imports = [
    ./ario-config.generated.nix
  ];

  virtualisation.oci-containers.containers."ario-core" = {
    environment = lib.mapAttrs (_: lib.mkForce) vars.environment;
  };
}
