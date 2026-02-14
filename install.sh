#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_CONF="$SCRIPT_DIR/.tmux.conf"
TARGET="$HOME/.tmux.conf"

if [ -e "$TARGET" ]; then
    if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$TMUX_CONF" ]; then
        exit 0
    fi

    BACKUP="$TARGET.backup.$(date +%Y%m%d_%H%M%S)"
    mv "$TARGET" "$BACKUP" || { echo "Failed to backup existing configuration" >&2; exit 1; }
fi

ln -s "$TMUX_CONF" "$TARGET" || { echo "Failed to create symlink" >&2; exit 1; }
