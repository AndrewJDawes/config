if [ -f $HOME/.zshrc ]; then
    source $HOME/.zshrc
fi

if [ -f $HOME/.cfg_scripts/system/report.sh ]; then
    source $HOME/.cfg_scripts/system/report.sh;
    get_system_report;
fi
