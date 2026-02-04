{
  lib,
  vars,
  ...
}:

{
  imports = [
    ./ario-grafana-config.generated.nix
  ];

  # Ensure Grafana bind mounts are writable by uid/gid 472 inside the container
  systemd.tmpfiles.rules = [
    "d /opt/ario/data/grafana 0775 472 472 - -"
    "d /opt/ario/monitoring/grafana 0775 472 472 - -"
    "d /opt/ario/monitoring/grafana/dashboards 0775 472 472 - -"
    "d /opt/ario/monitoring/grafana/provisioning 0775 472 472 - -"
  ];

  # Override Grafana root URL to the external host so assets load behind the /grafana subpath
  virtualisation.oci-containers.containers."ario-grafana".environment = {
    GF_SERVER_ROOT_URL = lib.mkForce "https://${vars.environment.ARNS_ROOT_HOST}/grafana";
    GF_SERVER_SERVE_FROM_SUB_PATH = lib.mkForce "true";
  };
}
