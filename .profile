export CONFIG_PROFILE_SOURCED=1
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
# Use pyenv to manage python versions if installed
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
# Symlink to current NVM version
export NVM_SYMLINK_CURRENT=true

if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
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
fi
# Add macOS XAMPP executables to path if exist
if [ -d '/Applications/XAMPP/bin' ]; then
    export PATH="/usr/bin":"/Applications/XAMPP/bin":"$PATH";
fi
# Add Linux XAMPP executables to path if exist
if [ -d '/opt/lampp/bin' ]; then
   export PATH="/opt/lampp/bin":"$PATH";
fi
# Add node_modules globals to path if exists
if [ -d "$HOME/node_modules/.bin" ]; then
    export PATH="$HOME/node_modules/.bin":"$PATH";
fi
# Add /sbin/ to path
if [ -d "/sbin" ]; then
    export PATH="/sbin:$PATH"
fi

! (( CONFIG_RC_SOURCED == 1 )) && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

if [ -f $HOME/.cfg_scripts/system/report.sh ]; then
    source $HOME/.cfg_scripts/system/report.sh;
    get_system_report;
fi


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
