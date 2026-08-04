{
  pkgs,
  ThemeColor ? "pink",
  OrchisColor,
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  FontSize ? 10,
  ...
}:

let
  Papirus-Icon-Theme-Custom = pkgs.papirus-icon-theme.overrideAttrs (oldAttrs: {
    dontFixup = true;
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.papirus-folders ];
    postInstall = (oldAttrs.postInstall or "") + ''
      export XDG_DATA_HOME="$out/share"
      papirus-folders -o -C ${ThemeColor} -t Papirus-${IconVariant}
    '';
  });

  Orchis-Theme-Custom = pkgs.orchis-theme.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      ${pkgs.bash}/bin/bash ./install.sh -d $out/share/themes -t pink -c dark --tweaks solid primary
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
    Orchis-Theme-Custom
    gtk-engine-murrine
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

    theme = {
      name = "Orchis-" + OrchisColor + "-" + IconVariant;
      package = Orchis-Theme-Custom;
    };

    iconTheme = {
      name = "Papirus-" + IconVariant;
      package = Papirus-Icon-Theme-Custom;
    };

    font = {
      name = "Inter";
      size = FontSize;
      package = pkgs.inter;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
