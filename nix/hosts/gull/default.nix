{
  lib,
  pkgs,
  config,
  services,
  ...
}: {
  my.hostname = "gull";
  modules.editors.emacs.enable = true;
  # modules.editors.emacs-old.enable = true;
  modules.editors.emacs.doom.enable = true;
}
