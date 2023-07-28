{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.security.gpg;

  gpgPkg = pkgs.gnupg;
  pinentryPkg = pkgs.pinentry-curses;
  homedir = "${config.my.homeDirectory}/.config/gpg";

  gpgInitStr = ''
    GPG_TTY="$(tty)"
    export GPG_TTY
  '';

  gpgFishInitStr = ''
    set -gx GPG_TTY (tty)
  '';
in {
  options = {
    modules.tools.security.gpg = {
      enable =
        mkEnableOption "tools.security.gpg"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.home.packages = with pkgs; [
        # gnupg
        pinentryPkg
        gpgPkg
        # pinentry-gtk2
        # pinentry-qt
        # pinentry
        pinentry_mac
        # pinentry-emacs
      ];
    }
    {
      my.hm.user.programs.gpg = {
        enable = true;
        package = pinentryPkg;
        homedir = homedir;
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
          allow-emacs-pinentry
          allow-loopback-pinentry
          default-cache-ttl 86400
          default-cache-ttl-ssh 86400
          max-cache-ttl 86400
          max-cache-ttl-ssh 86400
          no-allow-external-cache
          enable-ssh-support
          grab
          ttyname $GPG_TTY
          pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        '';
      };
    }
    {
      environment = {
        variables = {
        };
      };
    }
    # {
    #   homebrew.casks = [
    #     "gpg-suite-no-mail"
    #   ];
    # }
    {
      my.hm.user.programs.zsh.oh-my-zsh.plugins = [
        "gpg-agent"
      ];
    }
  ]);
}
