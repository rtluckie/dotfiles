{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.gpg;
in {
  options = {
    modules.term.gpg = {
      enable =
        mkEnableOption "term.gpg"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.user.packages = with pkgs; [
        # gnupg
        # pinentry-gtk2
        pinentry
        pinentry_mac
        # pinentry-emacs
      ];
    }
    {
      my.hm.user.programs.gpg = rec {
        enable = true;
        homedir = "${config.my.homeDirectory}/.config/gpg";
        scdaemonSettings = {
          disable-ccid = true;
        };
        settings = {
          throw-keyids = true;
        };
      };
    }

    {
      my.hm.configFile = {
        "gpg/gpg-agent.conf".text = ''
          # ${config.my.nixManaged}
          #allow-emacs-pinentry
          #allow-loopback-entry
          default-cache-ttl 14400
          enable-ssh-support
          max-cache-ttl 14400
          ttyname $GPG_TTY
          pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        '';
      };
    }
    {
      homebrew.casks = [
        "gpg-suite-no-mail"
      ];
    }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "gpg-agent"
      ];
    }
  ]);
}
