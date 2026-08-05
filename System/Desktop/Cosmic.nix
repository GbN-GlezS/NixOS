# https://wiki.nixos.org/wiki/COSMIC

{ config, pkgs, ... }:

{
  # 1. Habilitar el gestor de sesiones y el entorno de escritorio COSMIC
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  # 2. Optimizaciones recomendadas por System76 (Opcional pero recomendado)
  services.system76-scheduler.enable = true;

  # 3. Ajustes de Portapapeles (Opcional: descomenta si usas gestores de portapapeles)
  # environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

  # 4. Integración con Firefox (Desactiva el tema libadwaita para que coincida con COSMIC)
  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };

  # 5. Exclusión de paquetes por defecto (Ejemplo: si deseas omitir cosmic-edit)
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  # ];
}
