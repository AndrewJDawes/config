# Alias for managing dotfiles config
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'
# Homebrew
if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
# Use pyenv to manage python versions if installed
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
#      export PATH="$HOME/.pyenv/bin:$PATH"
#      eval "$(pyenv init -)"
#      eval "$(pyenv virtualenv-init -)"
fi

# Init nvm if it has been installed
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Add composer to path if exists
if [ -d "$HOME/.composer/vendor/bin" ]; then
    export PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# Add ~/.local/bin to path if exists
if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Add Magento Cloud CLI to path if exists
if [ -d "$HOME/"'.magento-cloud/bin' ]; then
    export PATH="$HOME/"'.magento-cloud/bin':"$PATH"
    if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then
        . "$HOME/"'.magento-cloud/shell-config.rc';
    fi 
fi

# Add XAMPP executables to path if exists
if [ -d '/Applications/XAMPP/bin' ]; then
    export PATH="/Applications/XAMPP/bin":"$PATH";
fi

# Add node_modules globals to path if exists
if [ -d "$HOME/node_modules/.bin" ]; then
    export PATH="$HOME/node_modules/.bin":"$PATH";
fi
