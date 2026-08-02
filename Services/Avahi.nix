{ pkgs, ... }:

{
  services.avahi = {
    enable = true;

    # Habilita la resolución mDNS en el Name Service Switch
    nssmdns4 = true;
    nssmdns6 = true;

    # Abre automáticamente el puerto UDP 5353 en el firewall de NixOS
    openFirewall = true;

    # Anuncia el host y sus direcciones IP a otros equipos de la LAN
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
