{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    # Creamos el perfil "NixOS" y lo marcamos como predeterminado
    profiles.NixOS = {
      id = 0;
      name = "NixOS";
      isDefault = true;

      # Configuraciones mínimas funcionales (telemetría desactivada y optimización básica)
      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;
        "telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
      };
    };

    # Políticas globales para instalar uBlock Origin y dar acceso a ventanas privadas
    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false; # Cambiar a true si no deseas usar la sincronización de Mozilla

      # Instalación declarativa de Extensiones usando las políticas de Firefox
      ExtensionSettings = {
        # ID oficial de uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          default_area = "navbar";
          # Permitir explícitamente su ejecución en ventanas privadas/incógnito
          private_browsing = "allowed";
        };
      };
    };
  };

  # Establecer Firefox como el navegador web (WB) predeterminado del sistema usando XDG
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
