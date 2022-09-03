# dotfiles

## How to setup and use?

https://www.atlassian.com/git/tutorials/dotfiles


## Installs

### via [deb-get](https://github.com/wimpysworld/deb-get)

```plain
balena-etcher-electron
code
deb-get
docker-ce
discord
google-chrome-stable
obsidian
rpi-imager
slack-desktop
spotify-client
```

### Git credentials caching

```bash
sudo apt-get install libsecret-1-0 libsecret-1-dev
cd /usr/share/doc/git/contrib/credential/libsecret
sudo make
git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
```
