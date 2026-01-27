{ vals, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;
    defaults = {
      group = "nginx";

      email = vals.domainEmail;
      dnsProvider = "cloudflare";
      dnsResolver = "1.1.1.1:53";
      dnsPropagationCheck = true;

      reloadServices = [ "nginx" ];
    };

    certs."${vals.environment.ARNS_ROOT_HOST}" = {
      domain = vals.environment.ARNS_ROOT_HOST;
      extraDomainNames = [ "*.${vals.environment.ARNS_ROOT_HOST}" ];
      credentialsFile = "/root/cf-token";
    };
  };

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts."${vals.environment.ARNS_ROOT_HOST}" = {
      useACMEHost = vals.environment.ARNS_ROOT_HOST;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };

      locations."/grafana/" = {
        proxyPass = "http://localhost:1024/grafana";
        proxyWebsockets = true;
        basicAuth = {
          admin = vals.environment.ADMIN_API_KEY;
        };
      };

      locations."/glances/" = {
        proxyPass = "http://localhost:61208";
        proxyWebsockets = true;
        basicAuth = {
          admin = vals.environment.ADMIN_API_KEY;
        };
      };
    };
  };
}
