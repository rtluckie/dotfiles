{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib; (mkMerge [
    {
      environment = {
        interactiveShellInit = "";
        loginShellInit = "";
        shellAliases = {};
        shellInit = "";
        extraInit =
          concatStringsSep "\n"
          (mapAttrsToList (n: v: ''export ${n}="${v}"'') config.my.env);
      };
    }
    {
      environment = {
        variables = {
          DOTFILES = "${config.my.dotfiles.dir}";
          DOTFILES_BIN = "${config.my.dotfiles.binDir}";
        };
      };
    }
    {
      my.hm.user.home = {
        sessionVariables = {
          DOTFILES_BIN = "${config.my.dotfiles.dir}/bin";
        };
        sessionPath = [
          "$DOTFILES_BIN"
          "$HOME/.nix-profile/bin"
          "$HOME/.local/bin"
          "/etc/profiles/per-user/${config.my.username}/bin"
        ];
      };
    }
    {
      my.hm.user.home = {
        sessionVariables = {
          EDITOR = "emacs";
          VISUAL = "$EDITOR";
          PAGER = "less";
        };
      };
    }
    {
      environment = with pkgs; {
        systemPackages = [
          file
          git
          rsync
          vim
        ];
      };
    }
  ]);
}
