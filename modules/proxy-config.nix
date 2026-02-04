{ vars, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  security.acme = {
    acceptTerms = true;

    defaults = {
      email = vars.dns.email;
      dnsProvider = vars.dns.provider;
      environmentFile = vars.dns.credentialFile;
      dnsPropagationCheck = true;

      group = "nginx";
      reloadServices = [ "nginx" ];
    };

    certs."${vars.environment.ARNS_ROOT_HOST}" = {
      domain = "${vars.environment.ARNS_ROOT_HOST}";
      extraDomainNames = [ "*.${vars.environment.ARNS_ROOT_HOST}" ];
    };
  };

  services.nginx = {
    enable = true;

    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    #virtualHosts."${vars.environment.ARNS_ROOT_HOST}" = {
    virtualHosts."permaframes.cc" = {
      useACMEHost = vars.environment.ARNS_ROOT_HOST;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://localhost:3000";
        proxyWebsockets = true;
      };

      locations."/grafana/" = {
        proxyPass = "http://localhost:1024/grafana";
        proxyWebsockets = true;
        basicAuth = {
          admin = vars.environment.ADMIN_API_KEY;
        };
      };

      locations."/glances/" = {
        proxyPass = "http://localhost:61208";
        proxyWebsockets = true;
        basicAuth = {
          admin = vars.environment.ADMIN_API_KEY;
        };
        extraConfig = ''
          rewrite /glances/(.*) /$1 break;
          port_in_redirect off;
        '';
      };
    };
  };
}
