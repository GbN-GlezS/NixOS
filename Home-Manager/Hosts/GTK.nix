{
  pkgs,
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
in
{
  # Add Orchis theme and Murrine engine to packages
  home.packages = with pkgs; [
    orchis-theme-custom
    gtk-engine-murrine
  ];

  # GTK Theme configuration
  gtk = {
    enable = true;

    theme = {
      name = "Orchis-" + OrchisTheme + "-" + OrchisColor;
      package = orchis-theme-custom;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = if OrchisColor == "dark" then 1 else 0;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = if OrchisColor == "dark" then 1 else 0;
    };
  };

  # Sync dark theme setting across Desktop Environments / Flatpaks
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = if OrchisColor == "dark" then "prefer-dark" else "default";
      gtk-theme = "Orchis-" + OrchisTheme + "-" + OrchisColor;
    };
  };
}
