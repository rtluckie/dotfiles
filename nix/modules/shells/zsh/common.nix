{
  config,
  lib,
  pkgs,
  ...
}: {
  config = with lib; let
    cmn = import ../../common.nix {inherit config lib pkgs;};
  in (mkMerge [
    {
      environment = with pkgs; {
        shells = [
          zsh
        ];
        systemPackages = [
          zsh
        ];
        pathsToLink = ["/share/zsh"];
      };
    }
    {
      environment = {
        interactiveShellInit = "";
        loginShellInit = "";
        shellAliases = {};
        shellInit = "";
      };
    }
    {
      environment = with pkgs; {
        systemPackages = [
        ];
      };
    }
    {
      environment = {
        variables = {
        };
      };
    }
    {
      my.hm.user.home = {
        sessionPath = [
        ];
      };
    }
    {
      my.hm.user.home = {
        sessionVariables = {
        };
      };
    }
  ]);
}
