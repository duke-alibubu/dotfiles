# dotfiles

Personal macOS configuration.

## Layout

```
home/                    # files that live in ~
  .zshrc                 # zsh + oh-my-zsh, aliases, PATH (nvm, go, pyenv, gcloud)
  .zprofile              # Homebrew shellenv, JetBrains Toolbox
  .bashrc                # bash: loads fzf
  .fzf.zsh / .fzf.bash   # fzf completion and key bindings
  .gitconfig             # git identity, global ignore, Sourcetree tools
  .gitignore_global      # global git ignore patterns
  .zshrc.local.example   # template for ~/.zshrc.local (secrets)
```

## Install

`install.sh` symlinks every file in `home/` into `~` (except `.zshrc.local.example`).
Anything it replaces is moved to `~/.dotfiles-backup/<timestamp>/` first, and re-running it is safe.

```sh
cp home/.zshrc.local.example ~/.zshrc.local   # then fill in real values
./install.sh --dry                            # preview
./install.sh
```

It refuses to run until `~/.zshrc.local` exists, so secrets are never silently dropped from your shell.

## Secrets

API keys and passwords are not tracked.
`.zshrc` sources `~/.zshrc.local` at the end; copy `home/.zshrc.local.example` there and fill in real values.
