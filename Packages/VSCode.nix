# https://wiki.nixos.org/wiki/Visual_Studio_Code
# https://github.com/nix-community/vscode-nix-ide

{ pkgs, ... }:

{
  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscode = vscode.fhs; # Code editor developed by Microsoft.
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide # Nix language support with formatting and error report.
      ];
    })

    git # Distributed version control system.
    nil # Yet another language server for Nix.
    nixfmt # Official formatter for Nix code.
  ];

  # A set of environment variables used in the global environment.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  programs.nix-ld.enable = true; # Whether to enable nix-ld.
}
