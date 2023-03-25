# dotfiles

## How to setup and use?

1. Install `nix` -> https://zero-to-nix.com/concepts/nix-installer
2. Install `home-manager` -> https://nix-community.github.io/home-manager/index.html
3. Clone this repo to `${HOME}/dotfiles` directory
4. Symlink `home.nix` -> `ln -sf ${HOME}/dotfiles/home.nix ${HOME}/.config/home-manager/home.nix`
5. Install other apps mentioned from [Installs](#installs)

## Installs

### Classic packages

```plain
1password
docker-ce
dropbox
google-chrome-stable
rpi-imager
slack-desktop
```

### Flatpak

```plain
discord
spotify
obsidian
firefox
```

