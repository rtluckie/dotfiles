{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.development.tools.pet;
in {
  options = {
    modules.development.tools.pet = {
      enable =
        mkEnableOption "development.tools.pet"
        // {
          default = true;
        };
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      my.hm.user.programs.pet = rec {
        enable = true;
        snippets = [
          {
            description = "Clean up your system profile";
            command = "sudo nix-collect-garbage --delete-older-than <day=3>d";
            tag = ["nix"];
          }

          {
            description = "Clean up your system profile";
            command = "sudo nix-store --optimise";
            tag = ["nix"];
          }

          {
            description = "restart emacs user agent service in macos";
            command = "sudo launchctl kickstart -k gui/$UID/org.nixos.emacs";
            tag = ["emacs" "macos"];
          }
          {
            description = "check all services";
            command = "checkin my services";
            tag = ["slack"];
          }
          {
            description = "check all services";
            command = "checkin content-management-service";
            tag = ["slack"];
          }
        ];
      };
    }
  ]);
}
