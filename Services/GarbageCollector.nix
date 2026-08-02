{ ... }:

{
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-generations old";
  };

  # Opcional: optimiza el almacenamiento enlazando archivos idénticos diariamente
  nix.settings.auto-optimise-store = true;
}
