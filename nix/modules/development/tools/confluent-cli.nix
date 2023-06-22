{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.confluent-cli;
in {
  options = {
    modules.development.tools.confluent-cli = {
      enable =
        mkEnableOption "development.tools.confluent-cli"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      homebrew.casks = [
        "confluent-cli"
      ];
    }
  ]);
}
