final: prev:
# stolen from https://github.com/midchildan/dotfiles/blob/master/overlays/nixpkgs.nix
# FIXME: workaround for wait util it ready for nixpkgs-unstable
# https://nixpk.gs/pr-tracker.html?pr=147289
# prev.lib.optionalAttrs prev.stdenv.isDarwin {
#   clang-tools =
#     prev.clang-tools.override { llvmPackages = prev.llvmPackages_12; };
# } //
{
  installApplication = {
    name,
    appname ? name,
    version,
    src,
    description,
    homepage,
    postInstall ? "",
    sourceRoot ? ".",
    ...
  }:
    with prev;
      stdenv.mkDerivation {
        name = "${name}-${version}";
        version = "${version}";
        inherit src;
        buildInputs = [undmg unzip];
        inherit sourceRoot;
        phases = ["unpackPhase" "installPhase"];
        installPhase =
          ''
            mkdir -p "$out/Applications/${appname}.app"
            cp -pR * "$out/Applications/${appname}.app"
          ''
          + postInstall;
        meta = with lib; {
          inherit description;
          inherit homepage;
          maintainers = [];
          platforms = platforms.darwin;
        };
      };

  emacsPlusNativeComp = prev.callPackage ./emacs-plus.nix {};
}
