{ config, pkgs, ... }:

let
  papirus-icon-theme-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME=$out/share
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C blue -t Papirus-Dark
    '';
  });
in

{
  home.packages = with pkgs; [
    bibata-cursors # Material Based Cursor Theme.
    inter # Typeface specially designed for user interfaces.
    jetbrains-mono # Typeface made for developers.
    papirus-icon-theme-custom # Pixel perfect icon theme for Linux.
    papirus-folders # Tool to change papirus icon theme color.
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = papirus-icon-theme-custom;
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

    configFile."kdeglobals"."General"."AccentColor" = "61,174,233";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "61,174,233";

    configFile."kdeglobals"."KDE"."widgetStyle" = "Breeze";
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";

    workspace = {
      colorScheme = "BreezeDark";
      theme = "dark";
      iconTheme = "Papirus-Dark";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 16;
      };

      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };

      splashScreen = {
        theme = "None";
      };
    };

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
    "brave-github" = {
      name = "GitHub";
      exec = "brave --app=https://github.com/";
      icon = "github";
      terminal = false;
      categories = [
        "Development"
        "Network"
        "Utility"
      ];
    };
    "brave-whatsapp" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com/";
      icon = "whatsapp";
      terminal = false;
      categories = [
        "Network"
      ];
    };
    "brave-youtube" = {
      name = "YouTube";
      exec = "brave --app=https://www.youtube.com/";
      icon = "youtube";
      terminal = false;
      categories = [
        "Network"
        "AudioVideo"
      ];
    };
  };
}
