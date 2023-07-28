{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.applications.editors.nvim.nvchad;
in {
  options = with lib; {
    modules.applications.editors.nvim.nvchad = {
      enable =
        mkEnableOption "applications.editors.nvim.nvchad"
        // {
          default = false;
        };
    };
  };

  config = with lib;
    mkIf config.modules.applications.editors.nvim.enable (mkMerge [
      {
        my.hm.user.home.activation.vim = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
          if [[ ! -d "$HOME/.config/nvim" ]]; then
             ${pkgs.git}/bin/git clone --depth 1 https://github.com/NvChad/NvChad ~/.config/nvim
          fi
        '';
      }
    ]);
}
