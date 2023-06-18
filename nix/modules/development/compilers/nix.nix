{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.compilers.nix;
in {
  options = {
    modules.development.compilers.nix = {
      enable =
        mkEnableOption "development.compilers.nix"
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
