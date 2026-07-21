{ pkgs, ... }:

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors # Material Based Cursor Theme.
    inter # Typeface specially designed for user interfaces.
    jetbrains-mono # Typeface made for developers.
    papirus-folders # Tool to change papirus icon theme color.
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze";
      package = pkgs.kdePackages.breeze-gtk;
    };
    font = {
      name = "Inter";
      size = 10;
      package = pkgs.inter;
    };
  };

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Application Style (Fusion)
    configFile."kdeglobals"."KDE"."widgetStyle" = "Fusion";

    # Window Decorations (Plastik)
    configFile."kwinrc"."org.kde.kdecoration2"."theme" = "Plastik";

    # Plasma Style (Breeze Dark)
    configFile."plasmarc"."Theme"."name" = "breeze-dark";

    # Sounds and Splash Screen
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";
    configFile."ksplashrc"."KSplash"."Theme" = "None";

    configFile."kdeglobals"."General"."XftAntialias" = true;
    configFile."kdeglobals"."General"."XftSubPixel" = "rgb";
    configFile."kdeglobals"."General"."AntiAliasingExcludeRangeEnabled" = false;
    configFile."kdeglobals"."General"."XftHintStyle" = "hintslight";

    fonts = {
      general = {
        family = "Inter";
        pointSize = 10;
      };
      fixedWidth = {
        family = "JetBrains Mono";
        pointSize = 10;
      };
      small = {
        family = "Inter";
        pointSize = 8;
      };
      toolbar = {
        family = "Inter";
        pointSize = 10;
      };
      menu = {
        family = "Inter";
        pointSize = 10;
      };
      windowTitle = {
        family = "Inter";
        pointSize = 10;
      };
    };

    panels = [
      {
        location = "bottom";
        alignment = "center";
        lengthMode = "fill";
        hiding = "dodgewindows";
        opacity = "adaptive";
        floating = true;
        height = 35;

        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };

  xdg.desktopEntries = {
    "brave-chatgpt" = {
      name = "ChatGPT";
      exec = "brave --app=https://chatgpt.com/";
      icon = "${./Icons/ChatGPT-Dark.svg}";
      terminal = false;
      categories = [
        "Network"
        "Utility"
      ];
    };
    "brave-gemini" = {
      name = "Gemini";
      exec = "brave --app=https://gemini.google.com/";
      icon = "${./Icons/Gemini.svg}";
      terminal = false;
      categories = [
        "Network"
        "Utility"
      ];
    };
    "brave-whatsapp" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      categories = [ "Network" ];
    };
  };
}
