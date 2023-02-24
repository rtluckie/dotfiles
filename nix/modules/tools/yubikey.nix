{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.yubikey;
in {
  options = {
    modules.tools.yubikey = {
      enable =
        mkEnableOption "tools.yubikey"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        paperkey
        pgpdump

        # Yubico's official tools
        yubikey-manager
        yubikey-personalization
        # yubikey-personalization-gui
        yubico-piv-tool

        # Password generation tools
        diceware
        pwgen

        # Miscellaneous tools that might be useful beyond the scope of the guide
        cfssl
      ];
    }
  ]);
}
