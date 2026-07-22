{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];

    profiles.default.userSettings = {
      "[nix]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
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
}
