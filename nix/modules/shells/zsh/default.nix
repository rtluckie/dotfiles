{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./oh-my-zsh.nix
    ./common.nix
    ./main.nix
  ];
}
