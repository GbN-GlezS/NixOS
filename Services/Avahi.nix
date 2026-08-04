{ ... }:

{
  services.openssh.enable = true; # Whether to enable the OpenSSH secure shell daemon, which allows secure remote logins.

  services.avahi = {
    enable = true; # Whether to run the Avahi daemon, which allows Avahi clients to use Avahi's service discovery facilities and also allows the local machine to advertise its presence and services (through the mDNS responder implemented by avahi-daemon).
    nssmdns4 = true; # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv4.
    nssmdns6 = true; # Whether to enable the mDNS NSS (Name Service Switch) plug-in for IPv6.
    openFirewall = true; # Whether to open the firewall for UDP port 5353.

    publish = {
      enable = true; # Whether to allow publishing in general.
      addresses = true; # Whether to register mDNS address records for all local IP addresses.
      workstation = true; # Whether to register a service of type "_workstation._tcp" on the local LAN.
    };
  };

  systemd.services.avahi-daemon = {
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
  };
}
