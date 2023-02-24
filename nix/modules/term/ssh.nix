{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.term.ssh;
in {
  options = {
    modules.term.ssh = {
      enable =
        mkEnableOption "term.ssh"
        // {
          default = true;
        };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.ssh = rec {
        enable = true;
        compression = true;
        controlMaster = "no";
        controlPath = "/tmp/ssh-%u-%r@%h:%p";
        controlPersist = "no";
        forwardAgent = true;
        hashKnownHosts = true;
        serverAliveCountMax = 3;
        serverAliveInterval = 0;
        extraConfig = ''
          VisualHostKey no
          PasswordAuthentication yes
          ChallengeResponseAuthentication no
          # StrictHostKeyChecking yes
          # VerifyHostKeyDNS yes
        '';
      };
    }
  ]);
}
