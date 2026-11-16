#!/usr/bin/env bash

file2calc="$1"
if [[ -z "$file2calc" ]]; then
    echo >&2 "Missing filename, please give a single parameter with filename."
    exit 1
fi

hash=$(openssl dgst -sha256 -binary "$file2calc" | openssl base64 -A)
rawHash="sha256-${hash}"
cleanedHash="$(echo -e "sha256-$hash" | tr "/" "_")"
echo -e "normal hash:\n$rawHash\n"
echo -e "cleaned hash:\n$cleanedHash"

copy_to_clipboard()
{
    if command -v pbcopy &>/dev/null; then
        pbcopy
    elif command -v wl-copy &>/dev/null; then
        wl-copy
    elif command -v xclip &>/dev/null; then
        xclip -selection clipboard
    elif command -v xsel &>/dev/null; then
        xsel --clipboard --input
    else
        return 127
    fi
}

if printf '%s' "$cleanedHash" | copy_to_clipboard 2>/dev/null; then
    echo "(copied to clipboard)"
else
    echo "(no clipboard tool found, hash not copied)"
fi
