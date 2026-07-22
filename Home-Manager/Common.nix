{
  pkgs,
  themeColor ? "pink",
  iconVariant ? "Papirus-",
  cursorTheme ? "Bibata-Modern-Classic",
  accentColor ? "233,58,154",
  lookAndFeel ? "org.kde.breeze.desktop",
  ...
}:

let
  papirus-icon-theme-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME=$out/share
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${themeColor} -t ${"Papirus-" + iconVariant}
    '';
  });
in

{
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    bibata-cursors
    inter
    jetbrains-mono
    papirus-folders
    papirus-icon-theme-custom
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = cursorTheme;
    package = pkgs.bibata-cursors;
    size = 16;
  };

  gtk = {
    iconTheme = {
      name = "Papirus-" + iconVariant;
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

    configFile."kdeglobals"."General"."AccentColor" = accentColor;
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = accentColor;
    configFile."kdeglobals"."Sounds"."Theme" = "freedesktop";
    configFile."ksplashrc"."KSplash"."Theme" = "None";

    workspace = {
      lookAndFeel = lookAndFeel;
      iconTheme = iconVariant;
      cursor.theme = cursorTheme;
    };

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
