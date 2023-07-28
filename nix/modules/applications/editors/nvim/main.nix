{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.applications.editors.nvim;
in {
  options = with lib; {
    modules.applications.editors.nvim = {
      enable =
        mkEnableOption "applications.editors.nvim"
        // {
          default = true;
        };
    };
  };

  config = with lib;
    mkIf cfg.enable (mkMerge [
      {
        my.hm.user.programs.neovim = with pkgs; {
          enable = true;
          # package = neovim;
        };
      }

      {
        my.hm.user.programs.zsh.shellAliases = {
          nvim = "nvim";
          vi = "nvim";
        };
      }
    ]);
}
