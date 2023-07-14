# Install nvm if it's not already installed
if [ ! -s "${HOME}/.nvm/nvm.sh" ]; then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
else
    echo "nvm is already installed."
fi
# Source nvm to make it available for the script
[ -s "${HOME}/.nvm/nvm.sh" ] && \. "${HOME}/.nvm/nvm.sh"
nvm use --lts

# Install powerlevel10k theme if it's not already installed
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "powerlevel10k theme is already installed."
fi

# Install zsh-nvm if it's not already installed
if [ ! -d "${HOME}/.oh-my-zsh/custom/plugins/zsh-nvm" ]; then
    echo "Installing zsh-nvm..."
    git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
else
    echo "zsh-nvm is already installed."
fi

# Install fzf if it's not already installed
if [ ! -d "${HOME}/.fzf" ]; then
    echo "Installing fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
else
    echo "fzf is already installed."
fi

# Copy .zshrc
cp ~/.dotfiles/.zshrc ~/.zshrc
