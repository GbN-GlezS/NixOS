{ ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    # Desactivar Baloo (indexador de archivos) declarativamente
    configFile."baloorc"."Basic Settings"."Indexing-Enabled" = false;
  };
}
