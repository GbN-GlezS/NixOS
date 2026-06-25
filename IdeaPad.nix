{ pkgs, lib, ... }:

{
  networking.hostName = "IdeaPad"; # Define your hostname.

# ### Inicio de Sesión Automático (SDDM + KDE Plasma) ###
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };

# ### A start job is running for /dev/tpm* ###
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
}
