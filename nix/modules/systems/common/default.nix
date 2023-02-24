{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  time.timeZone = config.my.timeZone;
  networking.hostName = config.my.hostname;

  imports = [./nix.nix ./fonts.nix];
  users.users.${config.my.username} = {
    home = config.my.homeDirectory;
  };
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;
  home-manager.users.${config.my.username} = lib.mkMerge [
    (import ./home.nix {inherit pkgs lib config;})
  ];
  services.activate-system.enable = true;
}
