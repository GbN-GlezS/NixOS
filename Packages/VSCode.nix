# https://wiki.nixos.org/wiki/Visual_Studio_Code
# https://github.com/nix-community/vscode-nix-ide

{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    git # Distributed version control system.
    nil # Yet another language server for Nix.
    nixfmt # Official formatter for Nix code.
  ];

  programs.vscode = {
    enable = true; # Whether to enable VSCode editor.
    package = pkgs.vscode.fhs; # The vscode package to use.

    # The extensions Visual Studio Code should be started with.
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide # Nix language support with formatting and error report.
      github.vscode-github-actions # Visual Studio Code extension for GitHub Actions workflows and runs for github.com hosted repositories.
      redhat.vscode-yaml # YAML Language Support by Red Hat, with built-in Kubernetes and Kudo syntax support.
    ];

    # Configuration written to Visual Studio Code's settings.json.
    profiles.default.userSettings = {
      "[nix]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };

      "[yaml]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "redhat.vscode-yaml";
      };

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixfmt" ];
          };
        };
      };

      "git.enableSmartCommit" = true;
    };
  };

  xdg.mimeApps = {
    enable = true; # Whether to manage $XDG_CONFIG_HOME/mimeapps.list.

    defaultApplications = {
      "text/plain" = [ "code.desktop" ]; # .txt
      "text/x-nix" = [ "code.desktop" ]; # .nix
      "text/csv" = [ "code.desktop" ]; # .csv
      "text/yaml" = [ "code.desktop" ]; # .yaml
      "application/x-yaml" = [ "code.desktop" ]; # .yml
    };
  };
}
