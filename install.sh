#!/bin/bash

mode=$1

print_header() {
  echo -e "\n\n===================================================="
  echo "== $1"
  echo "===================================================="
}

if [ "$mode" != "postshell" ]; then
    # Update package lists
    sudo apt-get update -y

    # Check and install dependencies
    for cmd in zsh git curl; do
        command -v $cmd &> /dev/null || to_install+=($cmd)
    done
    print_header "Installing dependencies (${to_install[@]})"
    (( ${#to_install[@]} )) && sudo apt-get install -y ${to_install[@]}

    # Install oh-my-zsh if not present
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
      print_header "Installing oh-my-zsh"
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
      print_header "oh-my-zsh is already installed"
    fi

    # Call second stage
    zsh $0 postshell
fi

if [ "$mode" = "postshell" ]; then
    # Function to clone a git repo if directory doesn't exist
    install_from_git() {
        if [ ! -d "$1" ]; then
          print_header "Installing $(basename "$1")"
          git clone $2 $1
        else
          print_header "$(basename "$1") is already installed"
        fi
    }

    # Install nvm
    if [ ! -d "${HOME}/.nvm" ]; then
      print_header "Installing NVM"
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
      [ -s "${HOME}/.nvm/nvm.sh" ] && . "${HOME}/.nvm/nvm.sh"  # source nvm
      nvm use --lts
    else
      print_header "NVM is already installed"
    fi

    # Install powerlevel10k theme
    install_from_git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" 'https://github.com/romkatv/powerlevel10k.git'

    # Install zsh-nvm
    install_from_git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-nvm" 'https://github.com/lukechilds/zsh-nvm'

    # Install zsh-autosuggestions
    install_from_git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" 'https://github.com/zsh-users/zsh-autosuggestions'

    # Install fzf
    FZF_DIR="${HOME}/.fzf"
    install_from_git "$FZF_DIR" 'https://github.com/junegunn/fzf.git'
    "$FZF_DIR"/install --all

    # Copy .zshrc
    print_header "Copying .zshrc file"
    cp ~/.dotfiles/.zshrc ~/.zshrc

    # Replace the current shell with Zsh
    exec zsh -l
fi