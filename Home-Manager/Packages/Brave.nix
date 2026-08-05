# https://wiki.nixos.org/wiki/Chromium

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    (brave.override {
      enableWideVine = true;
      commandLineArgs = [ "--password-store=basic" ];
    }) # Privacy-oriented browser for Desktop and Laptop computers (https://wiki.nixos.org/wiki/Chromium).
  ];

  # Desktop Entries allow applications to be shown in your desktop environment's app launcher.
  xdg.desktopEntries = {
    "brave-chatgpt" = {
      name = "ChatGPT";
      genericName = "AI assistant";
      comment = "Open ChatGPT as an application";
      exec = "brave --start-maximized --app=https://chatgpt.com/";
      icon = "${../Icons/ChatGPT-Dark.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "brave-gemini" = {
      name = "Gemini";
      genericName = "AI assistant";
      comment = "Open Gemini as an application";
      exec = "brave --start-maximized --app=https://gemini.google.com/";
      icon = "${../Icons/Gemini.svg}";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
        "Utility"
      ];
    };

    "brave-whatsapp" = {
      name = "WhatsApp";
      genericName = "Messaging application";
      comment = "Open WhatsApp Web as an application";
      exec = "brave --start-maximized --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      type = "Application";
      categories = [
        "Network"
      ];
    };
  };
}
