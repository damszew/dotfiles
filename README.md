# dotfiles

## How to setup and use?

1. Clone this repo to `${HOME}/dotfiles` directory
2. Run `./link_dotfiles.sh`
3. Install other apps mentioned in [Installs](#installs)

## Installs

### via [deb-get](https://github.com/wimpysworld/deb-get)

```plain
bat
balena-etcher-electron
code
deb-get
docker-ce
discord
dropbox
google-chrome-stable
obsidian
rpi-imager
slack-desktop
spotify-client
```

### Git credentials caching

```bash
sudo apt-get install build-essential libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```

### Other

```bash
git
curl
rust
starship
exa
ripgrep
```
