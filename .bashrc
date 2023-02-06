# Alias for managing dotfiles config
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
# Homebrew
if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
# Use pyenv to manage python versions if installed
if command -v pyenv 1>/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi
# Symlink to current NVM version
export NVM_SYMLINK_CURRENT=true
# Init nvm if it has been installed
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
# Add Homebrew PHPs as option
# PHP 7.3
if [ -e "/opt/homebrew/opt/php@7.3/bin" ]; then
    export PATH="/opt/homebrew/opt/php@7.3/bin:$PATH"
    export PATH="/opt/homebrew/opt/php@7.3/sbin:$PATH"
fi
# PHP 7.4
if [ -e "/opt/homebrew/opt/php@7.4/bin" ]; then
    export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
    export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
fi
# PHP 8.0
if [ -e "/opt/homebrew/opt/php@8.0/bin" ]; then
    export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
    export PATH="/opt/homebrew/opt/php@8.0/sbin:$PATH"
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
# Add macOS XAMPP executables to path if exist
if [ -d '/Applications/XAMPP/bin' ]; then
    export PATH="/Applications/XAMPP/bin":"$PATH";
fi
# Add Linux XAMPP executables to path if exist
if [ -d '/opt/lampp/bin' ]; then
   export PATH="/opt/lampp/bin":"$PATH";
fi
# Add node_modules globals to path if exists
if [ -d "$HOME/node_modules/.bin" ]; then
    export PATH="$HOME/node_modules/.bin":"$PATH";
fi
# VSCode
if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ] && [ ! -L "$HOME/Library/Application Support/Code/User/settings.json" ]; then
    mv "$HOME/Library/Application Support/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json.bak";
    ln -sf "$HOME/.config/Code/User/settings.json" "$HOME/Library/Application Support/Code/User/settings.json";
fi
# Add WebFX helper executables if exist
if [ -d "$HOME/.cmp/aliases" ]; then
   source "$HOME/.cmp/aliases";
fi
# Add /sbin/ to path
if [ -d "/sbin" ]; then
    export PATH="/sbin:$PATH"
fi
