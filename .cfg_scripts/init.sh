#!/usr/bin/env bash
function config() {
    git --git-dir=$HOME/.cfg --work-tree=$HOME "$@" >/dev/null 2>&1
}
config config core.hooksPath "$HOME/.cfg_scripts/.githooks"
config checkout
