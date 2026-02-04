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
    ./monitoring-config.nix
    ./ario-config.nix
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

  users.users.root.openssh.authorizedKeys.keys = vars.sshKeys;

  system.stateVersion = "24.05";
}
