# https://wiki.nixos.org/wiki/Chromium

{ pkgs, ... }:

let
  webAppEngine = pkgs.brave-origin.override {
    commandLineArgs = [
      # --- Storage & Session ---
      "--password-store=basic"

      # --- Hardware Acceleration ---
      "--enable-features=AcceleratedVideoEncoder,VaapiVideoDecoder"
      "--ignore-gpu-blocklist"
      "--enable-zero-copy"

      # --- Resource Management ---
      "--enable-low-end-device-mode"
      "--aggressive-tab-discard"

      # --- Privacy & Telemetry ---
      "--disable-background-networking"
      "--disable-breakpad"
      "--disable-component-update"
      "--no-pings"
    ];
  };
in
{
  # home.packages is omitted so Brave is never installed as a standalone launcher or binary in $PATH

  xdg.desktopEntries = {
    "app-chatgpt" = {
      name = "ChatGPT";
      genericName = "AI assistant";
      comment = "Open ChatGPT as an application";
      exec = "${webAppEngine}/bin/brave-origin --start-maximized --app=https://chatgpt.com/";
      icon = "${./Icons/ChatGPT-Dark.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "app-gemini" = {
      name = "Gemini";
      genericName = "AI assistant";
      comment = "Open Gemini as an application";
      exec = "${webAppEngine}/bin/brave-origin --start-maximized --app=https://gemini.google.com/";
      icon = "${./Icons/Gemini.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "app-whatsapp" = {
      name = "WhatsApp";
      genericName = "Messaging application";
      comment = "Open WhatsApp Web as an application";
      exec = "${webAppEngine}/bin/brave-origin --start-maximized --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
      ];
    };
  };
}
