{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.applications.editors.vim;
in {
  options = with lib; {
    modules.applications.editors.vim = {
      enable =
        mkEnableOption "applications.editors.vim"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      {
        my.hm.user.programs.neovim = rec {
          enable = true;
        };
      }
      {
        my.hm.user = {
          home = {
            sessionPath = [];
            sessionVariables = {};
            packages = with pkgs; [];
          };
        };
      }
      {
        my.hm.user.home.activation.vim = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [[ ! -d "$HOME/.config/nvim" ]]; then
             ${pkgs.git}/bin/git clone --depth 1 https://github.com/NvChad/NvChad ~/.config/nvim
          fi
        '';
      }
      {
        my.hm.user.programs.zsh.shellAliases = {
          vim = "nvim";
          vi = "nvim";
        };
      }
    ]);
}
