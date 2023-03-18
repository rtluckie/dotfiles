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
      trusted-users = ["root" "${config.my.username}" "@admin"];
      auto-optimise-store = true;
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
      build-cores = 0;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org"
        "https://cachix.org/api/v1/cache/devenv"
        "https://cachix.org/api/v1/cache/emacs"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "emacs.cachix.org-1:b1SMJNLY/mZF6GxQE+eDBeps7WnkT0Po55TAyzwOxTY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
