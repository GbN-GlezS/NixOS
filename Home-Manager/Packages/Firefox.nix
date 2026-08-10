{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    profiles.NixOS = {
      id = 0;
      name = "NixOS";
      isDefault = true;

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sponsorblock
        darkreader
      ];

      settings = {
        "browser.startup.homepage" = "about:home";
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;

        "telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
      };
    };

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
    };
  };

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
