{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.compilers.jsonnet;
in {
  options = {
    modules.development.compilers.jsonnet = {
      enable =
        mkEnableOption "development.compilers.jsonnet"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        go-jsonnet
        jsonnet-bundler
        jsonnet-language-server
      ];
    }
  ]);
}
