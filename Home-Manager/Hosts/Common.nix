{
  pkgs,
  ThemeColor ? "pink",
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  FontSize ? 10,
  ...
}:

let
  Papirus-Icon-Theme-Custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME="$out/share"
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${ThemeColor} -t Papirus
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${ThemeColor} -t Papirus-Dark    
      ${pkgs.papirus-folders}/bin/papirus-folders -o -C ${ThemeColor} -t Papirus-Light
    '';
  });
in

{
  home.stateVersion = "26.05"; # It is occasionally necessary for Home Manager to change configuration defaults in a way that is incompatible with stateful data.

  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    bibata-cursors # Material Based Cursor Theme.
    inter # Typeface specially designed for user interfaces.
    jetbrains-mono # Typeface made for developers.
    papirus-folders # Tool to change papirus icon theme color.
    Papirus-Icon-Theme-Custom # Pixel perfect icon theme for Linux.
  ];

  # Cursor configuration.
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-" + CursorVariant;
    package = pkgs.bibata-cursors;
    size = CursorSize;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-" + IconVariant;
      package = Papirus-Icon-Theme-Custom;
    };

    font = {
      name = "Inter";
      size = FontSize;
      package = pkgs.inter;
    };
  };
}
