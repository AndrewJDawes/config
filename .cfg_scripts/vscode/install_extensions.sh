#!/usr/bin/env bash
if command -v code >/dev/null 2>&1 && [ -f "$HOME/.cfg_vscode_extensions" ]; then
    while read line; do
        code --install-extension "$line" >/dev/null 2>&1
    done < "$HOME/.cfg_vscode_extensions"
fi
