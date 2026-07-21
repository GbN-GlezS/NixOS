{ pkgs, ... }:

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
  home.packages = [ papirus-icon-theme-custom ];

  home.pointerCursor.name = "Bibata-Modern-Ice";

  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = papirus-icon-theme-custom;
  };

  programs.plasma = {
    configFile."kdeglobals"."General"."AccentColor" = "61,174,233";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "61,174,233";

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      iconTheme = "Papirus-Dark";
      cursor.theme = "Bibata-Modern-Ice";
    };
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];

    profiles.default.userSettings = {
      "[nix]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };
    };
  };

  xdg.desktopEntries = {
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
