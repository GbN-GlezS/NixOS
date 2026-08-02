{ ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # Fuerza a Avahi a esperar a que la red y la IP estén completamente listas
  systemd.services.avahi-daemon = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
