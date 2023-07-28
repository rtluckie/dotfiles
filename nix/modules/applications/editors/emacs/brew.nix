{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.applications.editors.emacs.brew;
in {
  options = with lib; {
    modules.applications.editors.emacs.brew = {
      enable =
        mkEnableOption "applications.editors.emacs.brew"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf config.modules.applications.editors.emacs.enable (mkMerge [
      {
        homebrew.taps = [
          "d12frosted/emacs-plus"
        ];
        homebrew.brews = [
          "libgccjit"
          "texinfo"
          "gcc"
          # {
          #   name = "d12frosted/emacs-plus/emacs-plus@${emacsVersion}";
          #   args = [
          #     "ignore-dependencies"
          #     "with-no-titlebar-and-round-corners"
          #     "with-native-comp"
          #     "with-memeplex-slim-icon"
          #     "with-xwidgets"
          #     "with-imagemagick"
          #     "with-mailutils"
          #   ];
          #   restart_service = false;
          #   start_service = false;
          # }
        ];
      }
    ]);
}
