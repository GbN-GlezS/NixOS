# https://wiki.nixos.org/wiki/Visual_Studio_Code

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Versión FHS: Ideal para que extensiones de Python, C++, etc., ejecuten binarios nativos
    vscode.fhs
  ];

  # --- OPTIMIZACIONES DE LA WIKI OFICIAL ---

  # 1. Habilitar nix-ld para resolver bibliotecas dinámicas (Evita fallos en extensiones complejas)
  programs.nix-ld.enable = true;

  # 2. Forzar ejecución nativa en Wayland (Ozone) para máxima fluidez en KDE Plasma 6
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}