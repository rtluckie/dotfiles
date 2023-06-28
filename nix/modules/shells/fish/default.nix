{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./common.nix
    ./main.nix
  ];
}
