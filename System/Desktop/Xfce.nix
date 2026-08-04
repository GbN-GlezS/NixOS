# https://wiki.nixos.org/wiki/Xfce

{ pkgs, ... }:

{
  programs.xfconf.enable = true;

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager = {
      lightdm.enable = true;
    };
  };

  services.displayManager.defaultSession = "xfce";

  # Plugins adicionales para xfce4-panel y utilidades de entorno
  environment.systemPackages = with pkgs.xfce; [
    xfce4-whiskermenu-plugin # Menú de aplicaciones moderno
    xfce4-pulseaudio-plugin # Control e indicador de volumen PulseAudio/PipeWire
    xfce4-clipman-plugin # Gestor de portapapeles
    xfce4-screenshooter # Herramienta de capturas de pantalla
  ];
}
