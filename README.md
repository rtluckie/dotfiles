**Hey,** you. You're finally awake. You were trying to configure your OS
declaratively, right? Walked right into that nix ambush, same as us, and those
dotfiles over there.

> **Disclaimer:** _This is not a community framework or distribution._ It's a
> private configuration and an ongoing experiment to feel out nix. I make no
> guarantees that it will work out of the box for anyone but myself. It may also
> change drastically and without warning. 
> 
> Until I can bend spoons with my nix-fu, please don't treat me like an
> authority or expert in the nix space. Seek help on [the NixOS
> discourse](https://discourse.nixos.org) instead.

---
# **WARNING: Use at your own risk**

> I cannot stress this enough...  **Use at your own risk **
>
> * Adopting this approach to manage your system will require some effort.
>
> * `nix` is a interesting language but it can be frustrating at times and difficult to debug.
>
> * I am still very much a nix novice but I know just enough to be dangerous ;)
>
> * Try it out on a VM or a spare machine if you have one around.
>
> * For best experience use on a fresh, clean macOS install.
>
> * Currently only macOS is support I plan to support linux and nixos eventually.

---

## Background
I've used several different tools (stow, dotbot, custom shell script, rcm, yadm, chezmoi) to manage my system configuration and dotfiles over the years. Each of them has their strengths and weaknesses but none accomplished what I was looking for.

### Requirements for "ideal" dotfiles/system management tool

* [x] Declarative definition of system
* [x] Deterministic/idempotent output
* [x] Reusable components
* [x] Support for templating
* [x] Support for macOS and *nix
* [x] Ability to completely provision a new machine (or fresh os install) in >90m
* [x] Support installation and configuration of apps
* [x] Dependency management
* [x] Easy for others to fork, use and contribute back.
* [x] Based on OSS
* [x] Support for encryption of sensitive values (keys, etc)

Granted, the approach implemented in this repo is a bit overkill but

## Before You Start
> Read through the [learning links](#learning) 

## Initial Setup

1. Fork this repo and clone
1. Update relevant values in `nix/modules/options.nix`
1. Update relevant values in `hack/bootstrap.sh`
1. Run hack/set_sudo_nopassword.sh

    `bash -c "$(curl -fsSL https://raw.githubusercontent.com/rtluckie/dotfiles/main/hack/set_sudo_nopassword.sh)"`

1. cp `nix/hosts/example` to a different location and update hostname in `default.nix`

    `cp -pr nix/hosts/example nix/hosts/newhost; sed -i 's|example|newhost|g' nix/hosts/newhost`

1. Add reference to new host and update system arch if necesary (look for `system = "aarch64-darwin"`) in `flake.nix` 

    `sed -i 's|example|newhost|g' nix/hosts/newhost flake.nix`

1. update enabled modules in your new host config file in `nix/hosts`
1. Add and commit your changes and push to remote.
1. review operation in `dotfiles/main/hack/bootstrap.sh`
1. execute `dotfiles/main/hack/bootstrap.sh`
    * *WARNING*: the first run take a long time depending on your connection speed and machine. Let it finish...

## Daily Workflow
1. Make config changes, add modules, etc.
1. commit & push
1. Apply changes (replace `YOUR_HOST_NAME` with hostname from above.)

`make nix/all-nocommit/YOUR_HOST_NAME`

## Roadmap
- [ ] install emacs in a cleaner fashion
- [ ] doomemacs
- [ ] encrypted secrets

## Links
### Learning
* https://nixos.org/guides/nix-pills/ <- start here
* https://nixos.org/learn.html
* https://serokell.io/blog/practical-nix-flakes <- overview of flakes
* https://ianthehenry.com/posts/how-to-learn-nix/ <- interesting read, but some incorrect info...

### Reference
* https://search.nixos.org/packages?channel=unstable
* https://github.com/nix-community/home-manager
* https://nix-community.github.io/home-manager/
* https://github.com/LnL7/nix-darwin
* https://daiderd.com/nix-darwin/manual/index.html#sec-options
* https://github.com/NixOS/nixpkgs

### Inspiration
* https://github.com/hlissner/dotfiles <- from the same person responsible for [doomemacs](https://github.com/doomemacs/doomemacs)
* https://hhoeflin.github.io/nix/home_folder_nix
* https://github.com/ahmedelgabri/dotfiles
* https://github.com/cmacrae/config
* https://github.com/yuanw/nix-home
* https://github.com/hardselius/dotfiles
* https://github.com/montchr/dotfield

### Dotfiles
* https://github.com/theherk/commons