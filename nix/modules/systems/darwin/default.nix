{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  system.stateVersion = 4;
  services.nix-daemon.enable = true;
  services.activate-system.enable = true;
  imports = [./service-defaults.nix];
  # my.hm.user.home.packages = with pkgs; [
  #   darwin.cf-private
  # ];
}
