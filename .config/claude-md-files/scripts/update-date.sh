#!/usr/bin/env bash

FILE="$HOME/.claude/CLAUDE.md"
DATE="- **Current date**: $(date +%Y-%m-%d)"

# Update the first line containing "Current date"
sed -i.bak "/\*\*Current date\*\*/c\\
$DATE" "$FILE"
