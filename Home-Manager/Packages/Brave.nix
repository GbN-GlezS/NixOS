{ pkgs, ... }:

{
  # The set of packages to appear in the user environment.
  home.packages = with pkgs; [
    (brave.override {
      commandLineArgs = [
        "--password-store=basic"
      ];
    }) # Privacy-oriented browser for Desktop and Laptop computers.
  ];
}
