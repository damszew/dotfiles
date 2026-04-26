# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Nix-based dotfiles managed with [home-manager](https://github.com/nix-community/home-manager). Two separate home-manager configurations live side-by-side:

- `home.nix` — `damian` profile (non-NixOS, e.g. a VM or generic Linux without nixGL)
- `home-2.nix` — `tuxedo` profile (non-NixOS with nixGL for OpenGL/GPU support)

Both are wired into `flake.nix` as `homeConfigurations`. There is also a legacy `nixosConfigurations.nixos-vm` entry (uses `home.nix` + `configuration.nix`), but NixOS support is planned for removal.

## Applying changes

First-time activation (no `home-manager` in PATH yet):
```sh
nix run home-manager/master -- switch --flake .#damian
# or for the tuxedo profile:
nix run home-manager/master -- switch --flake .#tuxedo
```

Subsequent activations:
```sh
home-manager switch --flake .#damian
home-manager switch --flake .#tuxedo
```

Other useful commands:
```sh
nix flake update                              # bump all inputs in flake.lock
nix fmt                                       # format all nix files (uses alejandra in home.nix profile)
nix-collect-garbage --delete-older-than 1w   # prune old generations
```

## Key structural notes

- **nixGL** — a wrapper that patches OpenGL/GPU library paths so Nix-built apps can use the host system's GPU drivers. Required on non-NixOS machines with proprietary or hybrid GPUs (hence the tuxedo profile uses it; the damian VM profile does not). nixGL is a flake input (`github:nix-community/nixGL`) passed to the tuxedo config via `extraSpecialArgs`; packages are activated with `targets.genericLinux.nixGL.packages` and individual apps wrapped with `config.lib.nixGL.wrap <pkg>`.

- **Notable files** — `wezterm.lua` is the shared WezTerm config read by both profiles. `helix/` contains a standalone Helix config (legacy; the active config is inlined in the nix files). `wallpaper.png` is referenced directly by its absolute path in dconf.

- **Two profiles, mostly duplicated** — `home.nix` and `home-2.nix` share the same packages, fish config, helix config, and git aliases. The main differences:
  - `home.nix` uses `programs.git` with the `pkgs.gitFull` package and `credential.helper = "libsecret"`; `home-2.nix` uses raw `settings` attrset and `credential.helper = "store"`.
  - `home-2.nix` enables `programs.wezterm` directly and wraps it with `config.lib.nixGL.wrap` for GPU support; `home.nix` disables the wezterm program and symlinks `wezterm.lua` manually (OpenGL workaround for non-nixGL systems).
  - `home-2.nix` sets Wayland session variables (`NIXOS_OZONE_WL`, `MOZ_ENABLE_WAYLAND`, `QT_QPA_PLATFORM`, `GDK_BACKEND`, etc.) for native Wayland support; `home.nix` does not.
  - `home.nix` applies a 1Password polkit overlay and sets GNOME `favorite-apps`; `home-2.nix` does not.
  - `home.nix` adds `git-town` to packages; `home-2.nix` does not.

- **Nix formatter for Helix** — `home.nix` uses `alejandra` as the nix formatter; `home-2.nix` relies on nil's default.

- **SSH agent** — Both profiles set `SSH_AUTH_SOCK` to `~/.1password/agent.sock` as a workaround for `git-bug` ignoring `IdentityAgent`.

- The repo must be cloned to `~/dotfiles` for the wallpaper and wezterm symlink paths to resolve correctly.
