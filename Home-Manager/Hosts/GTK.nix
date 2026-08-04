{
  pkgs,
  ...
}:

let
  orchis-theme-custom = pkgs.orchis-theme.overrideAttrs (oldAttrs: {
    postInstall = (oldAttrs.postInstall or "") + ''
      ${pkgs.bash}/bin/bash ./install.sh -d $out/share/themes -t pink -c dark --tweaks solid primary
    '';
  });
in
{
  home.packages = [
    orchis-theme-custom
    pkgs.gtk-engine-murrine
  ];

  gtk = {
    enable = true;

    theme = {
      name = "Orchis-pink-dark";
      package = orchis-theme-custom;
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Orchis-pink-dark";
    };
  };
}
