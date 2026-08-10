{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
    };

    # Instalación de extensiones y políticas globales del navegador
    policies = {
      ExtensionSettings = {
        # Configuración para instalar uBlock Origin desde Mozilla Add-ons
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
