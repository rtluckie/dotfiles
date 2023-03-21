{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.lang.nix;
in {
  options = {
    modules.lang.nix = {
      enable =
        mkEnableOption "lang.nix"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        # nix-du
        alejandra
        cachix
        nix-prefetch-git
        nix-tree
        nixfmt
        nixpkgs-fmt
        treefmt
      ];
    }
  ]);
}
