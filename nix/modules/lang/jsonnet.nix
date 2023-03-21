{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.lang.jsonnet;
in {
  options = {
    modules.lang.jsonnet = {
      enable =
        mkEnableOption "lang.jsonnet"
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
