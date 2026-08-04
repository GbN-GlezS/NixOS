{
  pkgs,
  ThemeColor ? "pink",
  IconVariant ? "Light",
  CursorVariant ? "Classic",
  CursorSize ? 16,
  FontSize ? 10,
  OrchisTheme ? "pink", # default | purple | pink | red | orange | yellow | green | teal | grey
  OrchisColor ? "dark", # standard | light | dark
  OrchisSize ? "standard", # standard | compact
  OrchisTweaks ? [
    "solid"
    "primary"
  ], # e.g. [ "solid" "compact" "black" "primary" "macos" "submenu" "nord" "dracula" ]
  ...
}:

let
  # Creamos el paquete del tema con las variaciones elegidas usando overrideAttrs
  orchis-theme-custom = pkgs.orchis-theme.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      ${pkgs.bash}/bin/bash ./install.sh \
        -d $out/share/themes \
        -t ${OrchisTheme} \
        -c ${OrchisColor} \
        -s ${OrchisSize} \
        ${pkgs.lib.optionalString (
          OrchisTweaks != [ ]
        ) "--tweaks ${pkgs.lib.concatStringsSep " " OrchisTweaks}"}
    '';
  });

  # Reutilizamos la personalización de Papirus-Folders idéntica a tu Common.nix
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
  home.stateVersion = "26.05";

  # Paquetes requeridos para el funcionamiento e íconos/cursores
  home.packages = with pkgs; [
    bibata-cursors
    inter
    jetbrains-mono
    papirus-folders
    Papirus-Icon-Theme-Custom
    orchis-theme-custom
    gtk-engine-murrine # Dependencia necesaria para temas GTK2/3 basados en Murrine
  ];

  # Configuración del Cursor
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    x11.enable = true;
    name = "Bibata-Modern-" + CursorVariant;
    package = pkgs.bibata-cursors;
    size = CursorSize;
  };

  # Configuración principal de GTK
  gtk = {
    enable = true;

    # Tema de aplicaciones GTK (Orchis)
    theme = {
      name = "Orchis-" + OrchisTheme + "-" + OrchisColor;
      package = orchis-theme-custom;
    };

    # Tema de Íconos
    iconTheme = {
      name = "Papirus-" + IconVariant;
      package = Papirus-Icon-Theme-Custom;
    };

    # Tipografía
    font = {
      name = "Inter";
      size = FontSize;
      package = pkgs.inter;
    };

    # Ajustes GTK3 / GTK4 extras
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = if OrchisColor == "dark" then 1 else 0;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = if OrchisColor == "dark" then 1 else 0;
    };
  };

  # Configuración dconf para sincronizar la preferencia global de esquema de color en Wayland / GNOME / Flatpak
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = if OrchisColor == "dark" then "prefer-dark" else "default";
      gtk-theme = "Orchis-" + OrchisTheme + "-" + OrchisColor;
      icon-theme = "Papirus-" + IconVariant;
      cursor-theme = "Bibata-Modern-" + CursorVariant;
    };
  };
}
