# why not use stdenv isDarwin function
# https://github.com/nix-community/home-manager/issues/414
{
  lib,
  isDarwin ? false,
  isNixOS ? false,
}:
with lib; let
  loadModule = file: {condition ? true}: {inherit file condition;};
  allModules = [
    (loadModule ./applications/editors/emacs {})
    (loadModule ./applications/editors/goland.nix {})
    (loadModule ./applications/editors/helix.nix {})
    (loadModule ./applications/editors/idea.nix {})
    (loadModule ./applications/editors/jetbrains-gateway.nix {})
    (loadModule ./applications/editors/pycharm.nix {})
    (loadModule ./applications/editors/vim {})
    (loadModule ./applications/editors/vscode.nix {})
    (loadModule ./applications/media/spotify.nix {})
    (loadModule ./applications/media/vlc.nix {})
    (loadModule ./applications/misc/_1password.nix {})
    (loadModule ./applications/misc/amethyst.nix {})
    (loadModule ./applications/misc/fig.nix {})
    (loadModule ./applications/misc/google-drive.nix {})
    (loadModule ./applications/misc/istat-menus.nix {})
    (loadModule ./applications/misc/keycastr.nix {})
    (loadModule ./applications/misc/little-snitch.nix {})
    (loadModule ./applications/misc/navi.nix {})
    (loadModule ./applications/misc/nordvpn.nix {})
    (loadModule ./applications/misc/raycast.nix {})
    (loadModule ./applications/misc/rectangle.nix {})
    (loadModule ./applications/misc/rescuetime.nix {})
    (loadModule ./applications/networking/browsers/brave.nix {})
    (loadModule ./applications/networking/browsers/brave.nix {})
    (loadModule ./applications/networking/cluster/gcloud.nix {})
    (loadModule ./applications/networking/cluster/k8s.nix {})
    (loadModule ./applications/networking/cluster/lens.nix {})
    (loadModule ./applications/networking/cluster/pulumi.nix {})
    (loadModule ./applications/networking/cluster/terraform.nix {})
    (loadModule ./applications/networking/im/discord.nix {})
    (loadModule ./applications/networking/im/signal.nix {})
    (loadModule ./applications/networking/im/slack.nix {})
    (loadModule ./applications/networking/im/zoom.nix {})
    (loadModule ./applications/networking/p2p/qbittorrent.nix {})
    (loadModule ./applications/system/skhd.nix {})
    (loadModule ./applications/system/yabai.nix {})
    (loadModule ./applications/terminals/alacritty.nix {})
    (loadModule ./applications/terminals/iterm2.nix {})
    (loadModule ./applications/terminals/wezterm.nix {})
    (loadModule ./applications/virtualization/docker.nix {})
    (loadModule ./applications/virtualization/podman.nix {})
    (loadModule ./applications/virtualization/qemu.nix {})
    (loadModule ./development/common.nix {})
    (loadModule ./development/compilers/go.nix {})
    (loadModule ./development/compilers/jsonnet.nix {})
    (loadModule ./development/compilers/nix.nix {})
    (loadModule ./development/compilers/node.nix {})
    (loadModule ./development/compilers/python.nix {})
    (loadModule ./development/compilers/rust.nix {})
    (loadModule ./development/libraries.nix {})
    (loadModule ./development/tools/common.nix {})
    (loadModule ./development/tools/confluent-cli.nix {})
    (loadModule ./development/tools/dyff.nix {})
    (loadModule ./development/tools/git.nix {})
    (loadModule ./development/tools/jq.nix {})
    (loadModule ./development/tools/k6.nix {})
    (loadModule ./development/tools/pet.nix {})
    (loadModule ./development/tools/tokei.nix {})
    (loadModule ./development/tools/treefmt.nix {})
    (loadModule ./development/tools/yq.nix {})
    (loadModule ./helpers/apps.nix {})
    # (loadModule ./helpers/fonts.nix {})
    (loadModule ./helpers/media.nix {})
    (loadModule ./options.nix {})
    (loadModule ./servers/postgres.nix {})
    (loadModule ./servers/redis.nix {})
    (loadModule ./servers/redpanda.nix {})
    (loadModule ./shells/bash.nix {})
    (loadModule ./shells/zsh {})
    (loadModule ./tools/compression.nix {})
    (loadModule ./tools/dircolors.nix {})
    (loadModule ./tools/homebrew.nix {})
    (loadModule ./tools/media/ffmpeg.nix {})
    (loadModule ./tools/misc/asdf.nix {})
    (loadModule ./tools/misc/bat.nix {})
    (loadModule ./tools/misc/direnv.nix {})
    (loadModule ./tools/misc/exa.nix {})
    (loadModule ./tools/misc/fd.nix {})
    (loadModule ./tools/misc/fontconfig.nix {})
    (loadModule ./tools/misc/graphviz.nix {})
    (loadModule ./tools/misc/plantuml.nix {})
    (loadModule ./tools/misc/skim.nix {})
    (loadModule ./tools/misc/starship.nix {})
    (loadModule ./tools/admin/auth0.nix {})
    (loadModule ./tools/misc/steampipe.nix {})
    (loadModule ./tools/misc/tmux.nix {})
    (loadModule ./tools/misc/xclip.nix {})
    (loadModule ./tools/misc/zellij.nix {})
    (loadModule ./tools/misc/zoxide.nix {})
    (loadModule ./tools/networking/common.nix {})
    (loadModule ./tools/networking/ssh.nix {})
    (loadModule ./tools/networking/telepresence.nix {})
    (loadModule ./tools/networking/wireguard.nix {})
    (loadModule ./tools/networking/xh.nix {})
    (loadModule ./tools/security/gpg.nix {})
    (loadModule ./tools/security/yubikey.nix {})
    (loadModule ./tools/system.nix {})
    (loadModule ./tools/text/common.nix {})
    (loadModule ./tools/text/fzf.nix {})
    (loadModule ./tools/text/ripgrep.nix {})
  ];
  modules = map (getAttr "file") (filter (getAttr "condition") allModules);
in
  modules
