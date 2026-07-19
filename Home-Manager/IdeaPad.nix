{
  config,
  pkgs,
  lib,
  ...
}:

let
  papirus-icon-theme-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME=$out/share
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C pink -t Papirus-Dark
    '';
  });
in

{
  home.stateVersion = "26.05";

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

    configFile."kdeglobals"."General"."AccentColor" = "233,58,154";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "233,58,154";
    configFile."kdeglobals"."KDE"."widgetStyle" = "Breeze";
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";

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

    workspace = {
      colorScheme = "BreezeDark";
      theme = "default";
      iconTheme = "Papirus-Dark";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
      };

      windowDecorations = {
        library = "org.kde.breeze";
        theme = "Breeze";
      };

      splashScreen = {
        theme = "None";
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
      categories = [
        "Network"
      ];
    };
  };
}
