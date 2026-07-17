{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  # 1. Aseguramos que las herramientas de configuración de KDE estén disponibles
  # (Útil si necesitas recargar dconf en segundo plano)
  programs.dconf.enable = true;

  # 2. Declaración de la apariencia de tu entorno (KDE Plasma / GTK)
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  # Configuración de punteros y temas visuales a nivel de usuario
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic"; # O el estilo exacto de Bibata que prefieras
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # 3. Paquetes estéticos exclusivos para tu sesión
  home.packages = with pkgs; [
    papirus-icon-theme
    bibata-cursors
  ];

  # 4. Archivos de configuración directa (.nix) para KDE Plasma
  # Home Manager puede escribir directamente en las configuraciones de KDE
  # para fijar los iconos y el estilo sin que tengas que abrir los Ajustes del Sistema.
  xdg.configFile."kdeglobals".text = ''
    [Icons]
    Theme=Papirus-Dark
  '';
}
