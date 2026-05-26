#!/usr/bin/env bash

format_tokens() {
    local n="$1"
    if awk "BEGIN { exit !($n >= 1000000) }"; then
        awk "BEGIN { printf \"%.1fM\", $n / 1000000 }"
    elif awk "BEGIN { exit !($n >= 1000) }"; then
        awk "BEGIN { printf \"%.0fk\", $n / 1000 }"
    else
        printf "%d" "$n"
    fi
}

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
used_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')

if [ -z "$ctx_size" ]; then
    printf "%s" "$model"
    exit 0
fi

ctx_size_fmt=$(format_tokens "$ctx_size")

# Build percentage bar (20 cells wide)
if [ -n "$used_pct" ]; then
    filled=$(awk "BEGIN { v = int($used_pct / 5 + 0.5); if (v > 20) v = 20; printf \"%d\", v }")
    empty=$((20 - filled))
    bar=""
    for i in $(seq 1 "$filled"); do bar="${bar}█"; done
    for i in $(seq 1 "$empty");  do bar="${bar}░"; done

    used_pct_fmt=$(awk "BEGIN { printf \"%.0f%%\", $used_pct }")
    used_tokens_fmt=$(format_tokens "${used_tokens:-0}")

    printf "%s (%s context) | [%s] | %s | %s / %s" \
        "$model" "$ctx_size_fmt" "$bar" "$used_pct_fmt" "$used_tokens_fmt" "$ctx_size_fmt"
else
    # No API call yet — show model and context size only
    printf "%s (%s context)" "$model" "$ctx_size_fmt"
fi
