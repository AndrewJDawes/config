export CONFIG_RC_SOURCED=1
# Alias for managing dotfiles config
alias config='git --git-dir=$HOME/.cfg --work-tree=$HOME'
# vi mode for command line editing
set -o vi
# Homebrew
if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi
# Use pyenv to manage python versions if installed
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi
# Init nvm if it has been installed
if [ -d "$HOME/.nvm" ]; then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi
# Add Magento Cloud CLI to path if exists
if [ -d "$HOME/"'.magento-cloud/bin' ]; then
    if [ -f "$HOME/"'.magento-cloud/shell-config.rc' ]; then
        . "$HOME/"'.magento-cloud/shell-config.rc';
    fi 
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
