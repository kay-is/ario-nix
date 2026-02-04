{
  vars,
  modulesPath,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./ario-config.nix
    ./ario-grafana-config.nix
    ./proxy-config.nix
  ];

  boot.loader.grub = {
    # disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
  ];

  services.openssh.enable = true;

  services.glances = {
    enable = true;
    extraArgs = [ "--webserver" ];
  };

  virtualisation.oci-containers.containers."ario-core" = {
    environment = lib.mapAttrs (_: lib.mkForce) vars.environment;
  };

  users.users.root.openssh.authorizedKeys.keys = vars.sshKeys;

  system.stateVersion = "24.05";
}
