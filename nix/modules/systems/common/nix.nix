{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nixFlakes;
    # package = pkgs.nixUnstable;
    settings = {
      #      allowed-users = [ "root" "@admin" "*" ];
      #      trusted-users = [ "root" ];
      allowed-users = ["*"];
      trusted-users = ["root"];
      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
      build-cores = 0;
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://cache.nixos.org" "https://nix-community.cachix.org" "https://cachix.org/api/v1/cache/devenv"];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
    gc = {
      interval = {Hour = 24 * 7;};
      automatic = false;
      options = "--delete-older-than 10d";
      user = "${config.my.username}";
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };
  };
}