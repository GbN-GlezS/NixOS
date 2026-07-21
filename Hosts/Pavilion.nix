{ pkgs, ... }:

{
  # The set of packages that appear in /run/current-system/sw.
  environment.systemPackages = with pkgs; [
    kdePackages.kamoso # Application to take pictures and videos with your webcam.
  ];
}
