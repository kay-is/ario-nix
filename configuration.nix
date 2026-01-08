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
  services.glances.enable = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults = {
      group = "nginx";

      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      email = "fllstck@pm.me";
    };

    certs."permaframes.cc" = {
      extraDomainNames = [ "*.permaframes.cc" ];
    };
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."permaframes.cc" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };
    };
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUgE09xB2WSFpuow24yGsgPoLaEVMFfYC+/S5p+mS69 k@k-lg-gram"
  ];

  system.stateVersion = "24.05";
}
