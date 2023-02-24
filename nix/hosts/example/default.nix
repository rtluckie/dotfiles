{
  lib,
  pkgs,
  config,
  services,
  ...
}: {
  my.hostname = "example";
  modules.editors.emacs.enable = false;
}
