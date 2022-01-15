#!/usr/bin/env bash

# Matches any whitespace, the start of a comment (At least two /s or one #, up
# to one whitespace, an optional commonmark `[link_name]: `, the link, any
# non-whitespace, then EOL.
link_re='^\s*(:?/{2,})?(:?#)?\s?(:?\[[a-zA-Z0-9_\-]+\]:\s)?https?://\S*$'

# Files matching this regex will be scrutinized
file_re='(.rs|.nix|.toml|.sh|.md)'

matches=$(fd "$file_re" \
    --exec rg "$link_re" --invert-match --no-filename --no-line-number {} \
    | rg "^.{81,}$");

if [ -z "$matches" ]; then
    echo info: all lines are acceptable lengths
else
    echo "error: lines over 80 columns exist:"
    # Ripgrep's output looks like this:
    #
    # src/main.rs:12:// Pretend this line is too long
    #
    # This strips the `src/main.rs:12:` part and then prints out lines where the
    # rest of the actual line is more than 80 columns. This way, the filename
    # and line number can be included in the error messages from this script.
    offending_lines_re='^[^:]*:[^:]*:.{81,}$'

    fd "$file_re" \
        --exec rg "$link_re" --invert-match --line-number --with-filename {} \
        | rg "$offending_lines_re"
    exit 1
fi
