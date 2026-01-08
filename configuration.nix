{
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

  virtualisation.docker.enable = true;
  services.openssh.enable = true;  
  services.nginx.enable = true;
  services.glances.enable = true;


  users.users.root.openssh.authorizedKeys.keys = []

  system.stateVersion = "24.05";
}
