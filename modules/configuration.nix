{
  self,
  modulesPath,
  lib,
  pkgs,
  ...
}@args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./ario-config.nix
    ./proxy-config.nix
    ../vals.nix
  ];

  boot.loader.grub = {
    # disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
  ];

  services.openssh.enable = true;
  services.glances.enable = true;

  virtualisation.oci-containers.containers."ario-core" = {
    environment = self.vals.environment;
  };

  users.users.root.openssh.authorizedKeys.keys = self.vals.sshKeys;

  system.stateVersion = "24.05";
}
