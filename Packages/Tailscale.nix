# https://wiki.nixos.org/wiki/Tailscale

{ config, ... }:

{
  # 1. Habilitar nftables y ajustar el Firewall
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Utiliza la interfaz declarada por el propio servicio de Tailscale ("tailscale0")
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Abre el puerto UDP dinámico que use Tailscale
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # 2. Habilitar Tailscale
  services.tailscale = {
    enable = true;
    # Si vas a usar esta máquina como Exit Node o Subnet Router en el futuro, descomenta:
    # useRoutingFeatures = "client"; # u "optionally: server / both"
  };

  # 3. Forzar el backend de nftables en tailscaled (Evita traducir a iptables-legacy)
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # 4. Optimizaciones de inicio (Evita que el sistema espere red si usas VPN al arrancar)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
