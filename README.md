# dotfiles

## How to setup and use?

### NixOS

1. `nixos-rebuild switch --flake .` - it uses host name to determine config to apply

### non-NixOS

1. [Install `nix`](https://zero-to-nix.com/concepts/nix-installer)
2. Clone this repo to `${HOME}/dotfiles` directory
3. Activate config with `nix run .#hm -- switch`
   1. Can be also used as `nix run damszew/dotfiles#hm -- switch` to skip cloning

#### Other software

```plain
1password
docker-ce
```

## Cheatsheet

### nix-env

| action                                      | cmd                                 |
|-------------------------------------------- | ----------------------------------- |
| update package list                         | `sudo -i nix-channel --update`      |
| upgrade installed                           | `nix-env -u`                        |
| show generations                            | `nix-env --list-generations`        |
| rollback                                    | `nix-env --rollback`                |
| remove old generations (keep only latest 5) | `nix-env --delete-generations +5`   |

### nix flakes

| action                     | cmd                                               |
|--------------------------- | ------------------------------------------------- |
| update inputs in lock file | `nix flake update`                                |
| nixos config switch        | `nixos-rebuild switch --flake .`                  |
| home-manager init          | `nix run home-manager/master -- init --switch .` |
| home-manager switch        | `home-manager switch --flake .`                   |
| remove old generations     | `nix-collect-garbage --delete-older-than 1w`      |
