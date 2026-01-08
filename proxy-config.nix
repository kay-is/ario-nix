{ config, pkgs, ... }:
{
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

      locations."/grafana/" = {
        proxyPass = "http://localhost:1024/grafana";
        proxyWebsockets = true;
        basicAuth = {
          users = {
            "admin" = "permaframes123";
          };
        };
      };

      locations."/glances/" = {
        proxyPass = "http://localhost:61208";
        proxyWebsockets = true;
        basicAuth = {
          users = {
            "admin" = "permaframes123";
          };
        };
      };
    };
  };
}
