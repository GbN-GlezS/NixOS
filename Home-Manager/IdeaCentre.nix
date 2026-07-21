{ pkgs, ... }:

let
  papirus-icon-theme-custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME=$out/share
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C pink -t Papirus-Light
    '';
  });
in
{
  home.packages = [ papirus-icon-theme-custom ];

  home.pointerCursor.name = "Bibata-Modern-Classic";

  gtk.iconTheme = {
    name = "Papirus-Light";
    package = papirus-icon-theme-custom;
  };

  programs.plasma = {
    configFile."kdeglobals"."General"."AccentColor" = "233,58,154";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "233,58,154";

    workspace = {
      colorScheme = "BreezeLight";
      theme = "default";
      iconTheme = "Papirus-Light";
      cursor.theme = "Bibata-Modern-Classic";
    };
  };

  xdg.desktopEntries = {
    "brave-canva" = {
      name = "Canva";
      exec = "brave --app=https://www.canva.com/";
      icon = "${./Icons/Canva.svg}";
      terminal = false;
      categories = [
        "Graphics"
        "Network"
      ];
    };
    "brave-classroom" = {
      name = "Classroom";
      exec = "brave --app=https://classroom.google.com/";
      icon = "${./Icons/Classroom.svg}";
      terminal = false;
      categories = [
        "Education"
        "Network"
      ];
    };
  };
}
