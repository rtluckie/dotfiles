{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.tools.networking.ssh;
in {
  options = {
    modules.tools.networking.ssh = {
      enable =
        mkEnableOption "tools.networking.ssh"
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
