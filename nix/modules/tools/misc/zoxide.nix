{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.misc.zoxide;
in {
  options = {
    modules.tools.misc.zoxide = {
      enable =
        mkEnableOption "tools.misc.zoxide"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "zoxide"
      ];
    }
    {
      my.hm.user = {
        home = {
          sessionPath = [];
          sessionVariables = {
            # https://github.com/ajeetdsouza/zoxide#environment-variables
            "_ZO_DATA_DIR" = "$HOME/.local/share/zoxide";
            "_ZO_ECHO" = 0;
            "_ZO_EXCLUDE_DIRS" = "";
            # "_ZO_FZF_OPTS" = "$_FZF_DEFAULT_OPTS --select-1";
            "_ZO_MAXAGE" = 10000;
            "_ZO_RESOLVE_SYMLINKS" = 1;
          };
        };
      };
    }
    {
      my.hm.user.home.shellAliases = {
        cd = "z";
      };
    }
  ]);
}
