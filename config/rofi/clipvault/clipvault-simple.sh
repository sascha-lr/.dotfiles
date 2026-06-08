#!/usr/bin/env bash
set -euo pipefail

clipvault list | rofi -dmenu -display-columns 2 | clipvault get | wl-copy
