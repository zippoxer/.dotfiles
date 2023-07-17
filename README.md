# .dotfiles

- git
- curl
- [Node Version Manager (nvm)](https://github.com/nvm-sh/nvm)
- [zsh](http://zsh.sourceforge.net/)
- [oh-my-zsh](https://ohmyz.sh/) with plugins:
  - [powerlevel10k theme](https://github.com/romkatv/powerlevel10k)
  - [zsh-nvm](https://github.com/lukechilds/zsh-nvm)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [command-line fuzzy finder (fzf)](https://github.com/junegunn/fzf)

## Try it out with Docker

```bash
docker-compose build && docker-compose run playground
```

## Installation

```bash
cd ~
git clone https://github.com/zippoxer/.dotfiles.git
~/.dotfiles/install.sh
```

_Note: If you already had a `.zshrc`, it's been backed up to `~/.zshrc.bak`. You may want to copy important parts of it over to the new `.zshrc`._

## Uninstallation

If anything went wrong, just revert to your previous `.zshrc`:

```bash
mv ~/.zshrc.bak ~/.zshrc
```

_Note: everything else remains installed._
