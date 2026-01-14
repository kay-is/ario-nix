{ ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults = {
      group = "nginx";

      email = "fllstck@pm.me";
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      reloadServices = [ "nginx" ];
    };

    certs."permaframes.cc" = {
      domain = "permaframes.cc";
      extraDomainNames = [ "*.permaframes.cc" ];
      credentialsFile = "/root/cf-token";
    };
  };

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."permaframes.cc" = {
      useACMEHost = "permaframes.cc";
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };

      locations."/grafana/" = {
        proxyPass = "http://localhost:1024/grafana";
        proxyWebsockets = true;
        basicAuth = {
          admin = "permaframes123";
        };
      };

      locations."/glances/" = {
        proxyPass = "http://localhost:61208";
        proxyWebsockets = true;
        basicAuth = {
          admin = "permaframes123";
        };
      };
    };
  };
}
