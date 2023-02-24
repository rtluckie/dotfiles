DEBUG ?= 1
MAKE_ARGS := --no-print-directory

SHELL := zsh

# -include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)

# all: init deps build install run workflows


## Create a distribution by coping $PACKAGES from $INSTALL_PATH to $DIST_PATH
deps:
	@exit 0

## Install Homebrew
init/install/homebrew:
	$(SHELL) -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install nix
init/install/nix:
	if [[ ! -d "/nix" ]]; then \
		echo "Install nix"; \
		sh <(curl -L https://nixos.org/nix/install); \
	fi

## Git pull
git/pull:
	@git pull

## Nix flake update
nix/flake/update:
	@nix flake update --refresh


## format
format:
	nix develop --command bash -c 'treefmt .'

## nix build
nix/build/%:
	@echo "Build"
	@nix build '.#$*'

## nix build-rebuild
nix/build/rebuild/%:
	@echo "Rebuild"
	@nix build --rebuild '.#$*'

## nix darwin rebuiild switch
nix/darwin/rebuild/switch/%:
	@echo "Switch"
	@darwin-rebuild switch --flake '.#$*'

## nix darwin activate
nix/darwin/rebuild/activate/%:
	@echo "Activate"
	@darwin-rebuild activate --flake '.#$*'

## Build derivation and switch
nix/all/%:
	@$(MAKE) $(MAKE_ARGS) git/pull
	@$(MAKE) $(MAKE_ARGS) nix/build/$*
	@$(MAKE) $(MAKE_ARGS) nix/darwin/rebuild/switch/$*

nix/all-nocommit/%:
	@$(MAKE) $(MAKE_ARGS) nix/build/$*
	@$(MAKE) $(MAKE_ARGS) nix/darwin/rebuild/switch/$*
	# @$(MAKE) $(MAKE_ARGS) nix/darwin/rebuild/activate/$*
