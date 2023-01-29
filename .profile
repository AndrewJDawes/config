if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

if [ -f $HOME/.cfg_scripts/system/report.sh ]; then
    source $HOME/.cfg_scripts/system/report.sh;
    get_system_report;
fi
