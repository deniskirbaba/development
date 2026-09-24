# Development

Personal configs and setup instructions for a new Linux/Ubuntu server.

Currently includes Zsh, [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh), the `robbyrussell` theme, Git aliases, [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), and [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).

## Install on Ubuntu

Run these commands as the user whose shell you want to configure:

```sh
sudo apt-get update
sudo apt-get install -y git zsh ca-certificates

git clone https://github.com/deniskirbaba/development.git ~/development
bash ~/development/install.sh
exec zsh
```

The installer downloads Oh My Zsh and its plugins from their official repositories, then installs `dotfiles/.zshrc` as `~/.zshrc`. An existing, different config is moved to `~/.zsh-backup.XXXXXX/.zshrc` before replacement. Re-running the installer keeps already installed dependencies and skips an unchanged config.

No GitHub account or token is needed to download this public repository and its dependencies. The server still needs network access to GitHub over HTTPS and to its configured Ubuntu package mirrors.

To make Zsh the default shell for a local account:

```sh
chsh -s "$(command -v zsh)"
```

Reconnect after changing the default shell. For centrally managed accounts, change the shell through your account administrator.

## Update

```sh
git -C ~/development pull --ff-only
bash ~/development/install.sh
exec zsh
```

Edit `dotfiles/.zshrc`, commit and push your changes, then run these commands on your other servers.

## Machine-specific settings

Put local paths, private environment variables and extra aliases in `~/.zshrc.local`. It is loaded before Oh My Zsh, so it can also override the theme and plugin list. Keep credentials outside this repository.

## Files

- `dotfiles/.zshrc` — shared shell configuration.
- `install.sh` — installs Oh My Zsh, plugins and the shared config for the current user.
- `README.md` — installation and update instructions.
