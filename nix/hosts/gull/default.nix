{
  lib,
  pkgs,
  config,
  services,
  ...
}: {
  my.hostname = "gull";
  modules.applications.editors.emacs.enable = true;
  modules.applications.editors.emacs.doom.enable = true;
  modules.applications.editors.vim.enable = true;
}
