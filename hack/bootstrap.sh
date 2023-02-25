#!/usr/bin/env bash

set -Eeuf -o pipefail
SCRIPT_PATH=$(readlink -f "${BASH_SOURCE}")

# =======================================================================
# = Helpers & setting some variables
# =======================================================================

DOTFILES_REPO_NAME="dotfiles"
DOTFILES_REPO_BRANCH="main"
DOTFILES_DIR="$HOME/.dotfiles"
GITHUB_USER="rtluckie"
BITBUCKET_USER="${GITHUB_USER}"
GITLAB_USER="${GITHUB_USER}"
NIX_HOSTNAME="CHANGEME"

tput sgr0
# shellcheck disable=SC2034
RED=$(tput setaf 1)
# shellcheck disable=SC2034
ORANGE=$(tput setaf 3)
# shellcheck disable=SC2034
GREEN=$(tput setaf 2)
# shellcheck disable=SC2034
PURPLE=$(tput setaf 5)
# shellcheck disable=SC2034
CYAN=$(tput setaf 4)
# shellcheck disable=SC2034
BLUE=$(tput setaf 6)
# shellcheck disable=SC2034
WHITE=$(tput setaf 7)
# shellcheck disable=SC2034
BOLD=$(tput bold)
RESET=$(tput sgr0)

log() {
  local LABEL="[$1]"
  local COLOR="$2"
  shift
  shift
  local MSG=("$@")
  printf "${COLOR}${LABEL}%*s${RESET}" $(($(tput cols) - ${#LABEL})) | tr ' ' '='
  for M in "${MSG[@]}"; do
    ((COL = $(tput cols) - 2 - ${#M}))
    printf "%s%${COL}s${RESET}" "$COLOR* $M"
  done
  printf "${COLOR}%*s${RESET}\n\n" "$(tput cols)" | tr ' ' '='
}

log_error() {
  log "FAIL" "$RED" "$@"
  exit 1
}

log_info() {
  log "INFO" "$ORANGE" "$@"
}

log_success() {
  log "OK" "$GREEN" "$@"
}

if [[ -z ${NIX_HOSTNAME+x} ]]; then
  log_error "NIX_HOSTNAME is unset"
else
  log_info "NIX_HOSTNAME is set to '${NIX_HOSTNAME}'"
fi

show_banner() {
  cd "$HOME"
  command cat << EOF
$GREEN
                            _       _    __ _ _
                           | |     | |  / _(_) |
                         __| | ___ | |_| |_ _| | ___  ___
                        / _. |/ _ \| __|  _| | |/ _ \/ __|
                       | (_| | (_) | |_| | | | |  __/\__ \ $()
                      (_)__,_|\___/ \__|_| |_|_|\___||___/
$RESET
EOF

  if [ -d "$DOTFILES_DIR/.git" ]; then
    command cat << EOF
$BLUE
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(yellow)commit:  %h')
         $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(red)date:    %ad' --date=short)
         $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(cyan)author:  %an')
         $(git --git-dir "$DOTFILES_DIR/.git" --work-tree "$DOTFILES_DIR" log -n 1 --pretty=format:'%C(green)message: %s')
      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$RESET
EOF
  fi
}

get_confirmation() {
  read -p "Continue with $* (y/n)? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 0
  else
    log_error "Need confirmation to continue."
  fi
}
# =======================================================================
# = Main functions
# =======================================================================

install_xcode() {
  get_confirmation "install_xcode"
  log_info "START: install xcode..."
  if command -v xcodebuild &> /dev/null; then
    log_success "xcode already installed"
    return 0
  fi
  xcode-select --install
  sudo xcodebuild -license
  sudo softwareupdate --install --agree-to-license -aR
  log_success "COMPLETE:  install_xcode "
}

install_homebrew() {
  get_confirmation "install_homebrew"
  log_info "START: install_homebrew"
  if command -v brew &> /dev/null; then
    log_info ">> homebrew already installed"
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  log_success "COMPLETE: install_homebrew"
}

install_nix_base() {
  get_confirmation ">> install_nix_base"
  log_info "START: install_nix_base"
  if command -v nix &> /dev/null && command -v nix-env &> /dev/null; then
    log_info ">> nix already installed"
  else
    sh <(curl -L https://nixos.org/nix/install)
  fi
  log_success "COMPLETE: install_nix_base"
}
install_nix_base_deps() {
  get_confirmation ">> install_nix_base_deps"
  log_info "START: install_nix_base_deps"
  if ! command -v nix &> /dev/null || ! command -v nix-env &> /dev/null; then
    log_error ">> nix or nix-env not found. check nix installation."
  fi
  nix-env --install --attr nixpkgs.nixFlakes
  log_success "COMPLETE: install_nix_base_deps"
}

install_nix_darwin() {
  get_confirmation ">> install_nix_darwin"
  log_info "START: install install_nix_darwin"
  if [[ $(uname) != "Darwin" ]]; then
    log_error ">> Currently macos only supported..."
  fi
  if ! command -v nix &> /dev/null || ! command -v nix-env &> /dev/null; then
    log_error ">> nix or nix-env not found. check nix installation."
  fi

  if command -v nix-build &> /dev/null; then
    log_info ">> nix-darwin already installed..."
  else
    log_info ">> nix-darwin not found. starting install"
    log_info ">> see https://github.com/LnL7/nix-darwin#install for details"
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz --attr installer
    ./result/bin/darwin-installer
    for i in bash zsh; do
      if $(echo ${SHELL} | grep $i > /dev/null); then
        [[ -f /etc/static/$irc ]] && source /etc/static/$irc
      fi
    done
  fi
  log_success "COMPLETE: install install_nix_darwin"
}

install_nix() {
  get_confirmation "install_nix"
  log_info "START: get_dotfiles"
  install_nix_base
  install_nix_base_deps
  install_nix_darwin
  log_success "COMPLETE: get_dotfiles"
}

get_dotfiles() {
  get_confirmation "get_dotfiles"
  log_info "START: get_dotfiles"
  if [[ ! -d $DOTFILES_DIR ]]; then
    log_success "Cloning dotfiles..."
    git clone --branch "${DOTFILES_REPO_BRANCH}" --recurse-submodules --recursive "https://github.com/${GITHUB_USER}/${DOTFILES_REPO_NAME}.git" "$DOTFILES_DIR"

    cd "$DOTFILES_DIR" \
      && git remote set-url origin "git@github.com:${GITHUB_USER}/${DOTFILES_REPO_NAME}.git" \
      && git remote add bitbucket "git@bitbucket.org:${BITBUCKET_USER}/${DOTFILES_REPO_NAME}.git" \
      && git remote add gitlab "git@gitlab.com:${GITLAB_USER}/${DOTFILES_REPO_NAME}.git"
  else
    cd "$DOTFILES_DIR" \
      && CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git stash -u \
      && git checkout "${DOTFILES_REPO_BRANCH}" &> /dev/null \
      && git reset --hard "origin/${DOTFILES_REPO_BRANCH}" &> /dev/null \
      && git submodule update --init --recursive &> /dev/null \
      && git checkout - &> /dev/null &> /dev/null \
      && git stash pop &> /dev/null || true

    if [[ ${CURRENT_BRANCH} != ${DOTFILES_REPO_BRANCH} ]]; then
      log_error "Dotfiles repo (${DOTFILES_DIR}) is currently on ${CURRENT_BRANCH} desired branch is ${DOTFILES_REPO_BRANCH}\n PROCEED WITH CAUTION..."
    fi
  fi
  # for C in origin gitlab bitbucket; do git fetch "${C}"; done
  log_success "COMPLETE: get_dotfiles"
}

nix_first_run() {
  get_confirmation "nix_first_run"
  log_info "START: nix_first_run"
  # https://github.com/LnL7/nix-darwin#install
  if [[ "$(uname)" == "Darwin" ]]; then
    for i in shells zshenv zshrc zprofile bashrc bashrc.bash; do
      FP="/etc/${i}"
      if [[ -f ${FP} ]]; then
        sudo -u "$SUDO_USER" mv /etc/${i} /etc/${i}.old
      fi
    done
    cd "$DOTFILES_DIR" \
      && nix --experimental-features 'nix-command flakes' build "./#${NIX_HOSTNAME}" && "$DOTFILES_DIR"/result/sw/bin/darwin-rebuild switch --flake "./#${NIX_HOSTNAME}"
  else
    sudo -u "$SUDO_USER" nixos-rebuild switch --flake "./#$(hostname)"
  fi
  log_success "COMPLETE: nix_first_run"
}

bootstrap() {
  install_xcode $@
  install_homebrew $@
  install_nix $@
  get_dotfiles $@
  nix_first_run $@

  FAILED_COMMAND=$(fc -ln -1)

  if [ $? -eq 0 ]; then
    log_success "Done."
    log_info "Don't forget to generate SSH keys & import gpg keys"
  else
    log_error "Something went wrong, [ Failed on: $FAILED_COMMAND ]"
  fi
}

user_prompt() {
  options=("bootstrap" "get_dotfiles")
  for i in "$@"; do
    case $i in
      "bootstrap")
        bootstrap $@
        return
        ;;
      "get_dotfiles")
        get_dotfiles
        return
        ;;
      "quit")
        return
        ;;
      *)
        echo "Invalid option"
        return
        ;;
    esac
  done
}

run() {
  show_banner
  user_prompt $@
}

# =======================================================================
# = Run!
# =======================================================================

run $@
