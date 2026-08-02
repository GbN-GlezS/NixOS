{ pkgs, ... }:

{
  # 1. Módulo del sistema de Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

    # Habilita la integración con UWSM (recomendado para gestionar la sesión con systemd)
    withUWSM = true;
  };

  # 2. Display Manager (Pantalla de inicio de sesión gráfica)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # 3. Variables de entorno globales para Wayland
  environment.sessionVariables = {
    # Fuerza a aplicaciones Electron/Chromium (VSCode, Spotify, Brave, etc.) a usar Wayland nativo
    NIXOS_OZONE_WL = "1";
  };

  # 4. Portales XDG para la captura/compartición de pantalla
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # 5. Paquetes base del sistema
  environment.systemPackages = with pkgs; [
    kitty # Terminal requerida por defecto
    fuzzel # Lanzador de aplicaciones ligero
    waybar # Barra de estado superior
    dconf # Requerido para almacenar configuraciones GTK/System
  ];
}
