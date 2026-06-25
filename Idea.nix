{ pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "latam";
    variant = "";
  };
  
# ### Inicio de Sesión Automático (SDDM + KDE Plasma) ###
  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };

# ### A start job is running for /dev/tpm* ###
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;
}
