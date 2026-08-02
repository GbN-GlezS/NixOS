{ pkgs, ... }:

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

  # Asegura que el servicio de nombres (NSS) incluya mdns4 en /etc/nsswitch.conf
  system.nssModules = with pkgs; [ nssmdns ];
}
