{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.helpers.bins;
in {
  options = {
    modules.helpers.bins = {
      enable =
        mkEnableOption "helpers.bins"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.activation.userBins = inputs.home-manager.lib.hm.dag.entryAfter ["writeBoundary"] ''
        cp -pr ${config.my.dotfiles.binDir} ${config.my.homeDirectory}
      '';
    }
  ]);
}
