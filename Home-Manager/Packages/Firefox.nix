{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Perfil obligatorio llamado "NixOS" configurado como predeterminado
    profiles.NixOS = {
      id = 0;
      name = "NixOS";
      isDefault = true;

      # Ajustes mínimos recomendados para optimización básica y privacidad
      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
      };
    };

    # Políticas del navegador para extensiones y comportamiento global
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false; # Cambiar a true si no usas Sync de Mozilla

      # Instalación declarativa de uBlock Origin con sus permisos
      ExtensionSettings = {
        # ID oficial de uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "navbar";

          # Permitir ejecución en Ventanas Privadas (Run in Private Windows - Allow)
          private_browsing = "allowed";

          # Permitir actualizaciones automáticas (Allow automatic updates - On)
          updates_enabled = true;
        };
      };
    };
  };

  # Configurar Firefox como el navegador web por defecto (Web Browser - WB) en el sistema
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };
}
