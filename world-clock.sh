#!/usr/bin/env bash
# Multi-timezone clock for tmux status bar - ET, PT, and UTC

ET=$(TZ='America/New_York' date '+%H:%M')
PT=$(TZ='America/Los_Angeles' date '+%H:%M')
UTC=$(TZ='UTC' date '+%H:%M')

echo "ET $ET  PT $PT  UTC $UTC"
