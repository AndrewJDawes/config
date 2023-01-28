#!/usr/bin/env bash
if command -v code >/dev/null 2>&1; then
    code --list-extensions --show-versions > "$HOME/.cfg_vscode_extensions"
fi
