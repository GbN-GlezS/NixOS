{ config, pkgs, ... }:

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
  home.packages = [ papirus-icon-theme-custom ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 16;
  };

  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = papirus-icon-theme-custom;
  };

  programs.plasma = {
    configFile."kdeglobals"."General"."AccentColor" = "233,58,154";
    configFile."kdeglobals"."General"."LastUsedCustomAccentColor" = "233,58,154";

    workspace = {
      colorScheme = "BreezeDark";
      theme = "default";
      iconTheme = "Papirus-Dark";

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 16;
      };
    };
  };
}
