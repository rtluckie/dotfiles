{
  pkgs,
  lib,
  config,
  options,
  inputs,
  ...
}: let
  cfg = config.modules.applications.editors.nvim.lunarvim;
in {
  options = with lib; {
    modules.applications.editors.nvim.lunarvim = {
      enable =
        mkEnableOption "applications.editors.nvim.lunarvim"
        // {
          default = true;
        };
    };
  };

  config = with lib;
    mkIf config.modules.applications.editors.nvim.enable (mkMerge [
      # {
      #   my.hm.user.home.packages = with pkgs; [
      #     (python3.withPackages (
      #       ps:
      #         with ps; [
      #           # pynvim
      #         ]
      #     ))
      #     # pynvim
      #   ];
      # }
      # {
      #   my.hm.user.home.packages = with pkgs; [
      #     # nodePackages.neovim
      #   ];
      # }
    ]);
}
