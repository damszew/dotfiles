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
code
docker-ce
dropbox
google-chrome-stable
rpi-imager
slack-desktop
git
```

### Flatpak

```plain
discord
spotify
obsidian
firefox
```


### Git credentials caching

```bash
sudo apt-get install build-essential libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```


### Nix

via `nix-env`

```bash
nix
nushell
zola
```
