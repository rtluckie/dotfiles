{
  config,
  lib,
  pkgs,
  home-manager,
  options,
  ...
}:
with lib; let
  mkOptStr = value:
    mkOption {
      type = with types; uniq str;
      default = value;
    };

  mkSecret = description: default:
    mkOption {
      inherit description default;
      type = with types; either str (listOf str);
    };

  mkOpt = type: default: mkOption {inherit type default;};

  mkOpt' = type: default: description: mkOption {inherit type default description;};

  mkBoolOpt = default:
    mkOption {
      inherit default;
      type = types.bool;
      example = true;
    };
  home =
    if pkgs.stdenv.isDarwin
    then "/Users/${config.my.username}"
    else "/home/${config.my.username}";
in {
  options = with types; {
    my = {
      homeDirectory = mkOptStr "${home}";
      name = mkOptStr "Ryan Luckie";
      username = mkOptStr "rluckie";
      email = mkOptStr "rtluckie@gmail.com";
      # gpgKey = mkOptStr "BF2ADAA2A98F45E7";
      gpgKey = mkOptStr "rtluckie@gmail.com";
      githubUsername = mkOptStr "rtluckie";
      timeZone = mkOptStr "America/Chicago";
      hostname = mkOptStr "somehostname";
      website = mkOptStr "https://lck.dev";
      nixManaged =
        mkOptStr "Nix managed - DO NOT EDIT";
      user = mkOption {type = options.users.users.type.functor.wrapped;};
      dotfiles = rec {
        dir = mkOpt path ../../.;
        nixDir = mkOpt path "${config.my.dotfiles.dir}/nix";
        binDir = mkOpt path "${config.my.dotfiles.dir}/bin";
        configDir = mkOpt path "${config.my.dotfiles.dir}/config";
        modulesDir = mkOpt path "${config.my.dotfiles.nixDir}/modules";
        themesDir = mkOpt path "${config.my.dotfiles.nixDir}/themes";
      };
      hm = {
        user = mkOption {type = options.home-manager.users.type.functor.wrapped;};
        file = mkOpt' attrs {} "Files to place directly in $HOME";
        cacheHome = mkOpt' path "${home}/.cache" "Absolute path to directory holding application caches.";
        configFile = mkOpt' attrs {} "Files to place in $XDG_CONFIG_HOME";
        configHome = mkOpt' path "${home}/.config" "Absolute path to directory holding application configurations.";
        dataFile = mkOpt' attrs {} "Files to place in $XDG_DATA_HOME";
        dataHome = mkOpt' path "${home}/.local/share" "Absolute path to directory holding application data.";
        stateHome = mkOpt' path "${home}/.local/state" "Absolute path to directory holding application states.";
      };
      env = mkOption {
        type = attrsOf (oneOf [str path (listOf (either str path))]);
        apply =
          mapAttrs
          (n: v:
            if isList v
            then concatMapStringsSep ":" (x: toString x) v
            else (toString v));
        default = {};
        description = "TODO";
      };
      font = mkOptStr "Fira Code";
    };
  };
  config = {
    users.users."${config.my.username}" = mkAliasDefinitions options.my.user;
    home-manager.users."${config.my.username}" = mkAliasDefinitions options.my.hm.user;
    my.user = {
      inherit home;
      description = "Primary user account";
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = false;
    my.hm.user = {
      xdg = {
        enable = true;
        cacheHome = mkAliasDefinitions options.my.hm.cacheHome;
        configFile = mkAliasDefinitions options.my.hm.configFile;
        configHome = mkAliasDefinitions options.my.hm.configHome;
        dataFile = mkAliasDefinitions options.my.hm.dataFile;
        dataHome = mkAliasDefinitions options.my.hm.dataHome;
        stateHome = mkAliasDefinitions options.my.hm.stateHome;
      };

      home = {
        # # Necessary for home-manager to work with flakes, otherwise it will
        # # look for a nixpkgs channel.
        stateVersion =
          if pkgs.stdenv.isDarwin
          then "23.05"
          else config.system.stateVersion;
        inherit (config.my) username;
        file = mkAliasDefinitions options.my.hm.file;
      };

      programs = {
        # Let Home Manager install and manage itself.
        home-manager.enable = true;
      };
    };

    # must already begin with pre-existing PATH. Also, can't use binDir here,
    # because it contains a nix store path.
    my.env.PATH = ["$HOME/.nix-profile/bin" "$PATH"];

    environment.extraInit =
      concatStringsSep "\n"
      (mapAttrsToList (n: v: "export ${n}=\"${v}\"") config.my.env);
  };
}
