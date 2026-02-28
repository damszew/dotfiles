# dotfiles

## How to setup and use?

### non-NixOS

1. [Install `nix`](https://zero-to-nix.com/concepts/nix-installer)
2. Clone this repo to `${HOME}/dotfiles` directory and `cd` there.
3. Activate config with:
    ```shell
    nix run home-manager/master -- switch --flake .#damian
    ```
4. Subsequent calls cal be done via `home-manager`:
    ```shell
    home-manager switch --flake .#damian
    ```

#### Other software

```plain
1password
docker-ce
google-chrome
wezterm
zed
```

## Cheatsheet

### nix flakes

| action                     | cmd                                               |
|--------------------------- | ------------------------------------------------- |
| update inputs in lock file | `nix flake update`                                |
| nixos config switch        | `nixos-rebuild switch --flake .`                  |
| home-manager init          | `nix run home-manager/master -- switch --flake .` |
| home-manager switch        | `home-manager switch --flake .`                   |
| remove old generations     | `nix-collect-garbage --delete-older-than 1w`      |
