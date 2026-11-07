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

## Secrets

API keys and passwords are not tracked.
`.zshrc` sources `~/.zshrc.local` at the end; copy `home/.zshrc.local.example` there and fill in real values.
