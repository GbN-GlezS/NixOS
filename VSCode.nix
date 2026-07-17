# https://wiki.nixos.org/wiki/Visual_Studio_Code

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # VS Code FHS con extensión Nix IDE preinstalada
    (vscode-with-extensions.override {
      vscode = vscode.fhs;
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
      ];
    })
    nixfmt
  ];

  # --- OPTIMIZACIONES DE LA WIKI OFICIAL ---

  # 1. Habilitar nix-ld para resolver bibliotecas dinámicas
  programs.nix-ld.enable = true;

  # 2. Forzar ejecución nativa en Wayland (Ozone)
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
