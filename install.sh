#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMUX_CONF="$SCRIPT_DIR/.tmux.conf"
TARGET="$HOME/.tmux.conf"

# Symlink tmux config
if [ -e "$TARGET" ]; then
    if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$TMUX_CONF" ]; then
        echo "tmux config already symlinked"
    else
        BACKUP="$TARGET.backup.$(date +%Y%m%d_%H%M%S)"
        mv "$TARGET" "$BACKUP" || { echo "Failed to backup existing configuration" >&2; exit 1; }
        ln -s "$TMUX_CONF" "$TARGET" || { echo "Failed to create symlink" >&2; exit 1; }
        echo "tmux config symlinked (backup created)"
    fi
else
    ln -s "$TMUX_CONF" "$TARGET" || { echo "Failed to create symlink" >&2; exit 1; }
    echo "tmux config symlinked"
fi

# Symlink world clock script to tmux plugins
TMUX_SCRIPTS="$HOME/.tmux/plugins/tmux/scripts"
if [ -d "$TMUX_SCRIPTS" ]; then
    ln -sf "$SCRIPT_DIR/world-clock.sh" "$TMUX_SCRIPTS/world-clock.sh"
    echo "World clock script symlinked"
else
    echo "Tmux plugins not yet installed - run 'prefix + I' in tmux, then run this script again"
fi
