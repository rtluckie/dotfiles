{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  # emacsPkg = pkgs.emacsWithPackagesFromUsePackage {
  #   alwaysEnsure = true;
  #   alwaysTangle = true;
  #   config = "$HOME/.config/doom/config.org";
  #   package = pkgs.emacs;
  #   extraEmacsPackages = epkgs: [
  #     epkgs.vterm
  #   ];
  # };
  cfg = config.modules.applications.editors.emacs-old;
in {
  options = with lib; {
    modules.applications.editors.emacs-old = {
      enable =
        mkEnableOption "editors.emacs-old"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      {
        environment.systemPackages = with pkgs; [
        ];
        my.hm.user = {
          home = {
            sessionPath = ["$HOME/.config/emacs/bin"];
            sessionVariables = {
              # EMACS = "${emacsPkg}/bin/emacs";
              EMACSDIR = "$HOME/.config/emacs";
            };
            packages = with pkgs; [
            ];
          };
        };
      }
      {
        services.emacs.enable = true;
      }
      {
        my.hm.user.programs.emacs.enable = true;
        # my.hm.user.programs.emacs.package = emacsPkg;
      }
      {
        my.hm.user.programs.zsh.oh-my-zsh.plugins = [
          "emacs"
        ];
      }
    ]);
}
