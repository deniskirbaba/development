#!/usr/bin/env bash
set -euo pipefail
umask 022

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
omz_dir="$HOME/.oh-my-zsh"
plugin_dir="$omz_dir/custom/plugins"

for command_name in git zsh; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    printf 'Required command is missing: %s. On Ubuntu: sudo apt-get install git zsh ca-certificates\n' "$command_name" >&2
    exit 1
  fi
done

if [[ ! -f "$omz_dir/oh-my-zsh.sh" ]]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$omz_dir"
fi

mkdir -p "$plugin_dir"
if [[ ! -f "$plugin_dir/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh" ]]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$plugin_dir/zsh-autosuggestions"
fi
if [[ ! -f "$plugin_dir/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ]]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$plugin_dir/zsh-syntax-highlighting"
fi

mkdir -p "$omz_dir/cache/completions"
chmod go-w "$omz_dir" "$omz_dir/cache" "$omz_dir/cache/completions"

source_file="$repo_dir/dotfiles/.zshrc"
destination_file="$HOME/.zshrc"
if [[ ! -f "$destination_file" ]] || ! cmp -s "$source_file" "$destination_file"; then
  if [[ -e "$destination_file" || -L "$destination_file" ]]; then
    backup_dir="$(mktemp -d "$HOME/.zsh-backup.XXXXXX")"
    mv "$destination_file" "$backup_dir/.zshrc"
    printf 'Previous config saved in: %s/.zshrc\n' "$backup_dir"
  fi
  cp "$source_file" "$destination_file"
fi

printf 'Zsh configuration installed. Open a new shell or run: exec zsh\n'
