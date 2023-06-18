{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.security.yubikey;
in {
  options = {
    modules.tools.security.yubikey = {
      enable =
        mkEnableOption "tools.security.yubikey"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
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
