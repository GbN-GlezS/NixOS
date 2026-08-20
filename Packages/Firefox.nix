# https://wiki.nixos.org/wiki/Firefox

{ pkgs, ... }:

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
        # --- Startup & Search ---
        "browser.startup.homepage" = "about:home";
        "browser.search.suggest.enabled" = false;
        "browser.urlbar.suggest.searches" = false;

        # --- Telemetry, Diagnostics & Privacy ---
        "telemetry.archive.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "browser.send_pings" = false;
        "browser.ping-centre.telemetry" = false;
        "breakpad.reportURL" = "";

        # --- Hardware Acceleration & Rendering (VA-API / WebRender) ---
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;

        # --- Memory & Resource Management ---
        "browser.tabs.unloadOnLowMemory" = true;
      };
    };

    policies = {
      DisableTelemetry = true;
      DisablePocket = true;
      DisableFirefoxAccounts = false;
      DisableFirefoxStudies = true;
      DisableFeedbackCommands = true;
    };
  };

  # FirefoxPWA
  programs.firefoxpwa = {
    enable = true;

    profiles = {
      "01M0E8HAF9MBZMZ8K3J0W3TK6Z" = {
        name = "PWAs";

        sites = {
          "01M0E8HBAGVCB7AMQMQG4PGAS3" = {
            name = "GitHub";
            url = "https://github.com/";
            manifestUrl = "https://github.com/manifest.json";
          };

          "01M0E8HBX8NF8CT74869PRNBCA" = {
            name = "MyNixOS";
            url = "https://mynixos.com/";
            manifestUrl = "https://mynixos.com/manifest.webmanifest";
          };

          "01M0E8HCFHCVZD04GYAHVR48AM" = {
            name = "YouTube";
            url = "https://www.youtube.com/";
            manifestUrl = "https://www.youtube.com/manifest.webmanifest";
          };
        };
      };
    };
  };

  # Set Firefox as the system-wide default handler
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
