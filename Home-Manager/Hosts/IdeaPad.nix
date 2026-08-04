{ ... }:

{
  home.stateVersion = "26.05"; # It is occasionally necessary for Home Manager to change configuration defaults in a way that is incompatible with stateful data.

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Desactivar Baloo (indexador de archivos) declarativamente
    configFile."baloorc"."Basic Settings"."Indexing-Enabled" = false;
  };
}
