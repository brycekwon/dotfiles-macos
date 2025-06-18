#!/usr/bin/env sh

# check if running as root: this should NOT be done
if [ "$(id -u)" -eq 0 ]; then
    printf "Error: this program should not be run with root privileges.\n" >&2
    exit 1
fi

# simple flagging system
force=0
for flag in "$@"; do
    case "$flag" in
        -f|--force)
            force=1
            break
            ;;
    esac
done

# by default, the dotfiles source will be in the 'home/' directory relative to
# this script.
readonly DOT_SRC="$(cd $(dirname "$0") && pwd)/home"
if [ -z "$DOT_SRC" ] || [ ! -d "$DOT_SRC" ]; then
    printf "Error: '$DOT_SRC' is not a readable directory.\n"
    exit 1
fi

# by default, the dotfiles destination will be the value of $HOME, which is
# typically the home directory of the current user.
readonly DOT_DST="$HOME"
if [ -z "$DOT_DST" ] || [ ! -d "$DOT_DST" ] || [ ! -w "$DOT_DST" ]; then
    printf "Error: '$DOT_DST' is not a writeable directory.\n"
    exit 1
fi

# the layout of the source should mimic that of the target. hidden files (files
# prefixed with '.') are skipped.
find "$DOT_SRC" -type f -print0 | while IFS= read -r -d $'\0' src; do
    case "${src##*/}" in
        .*) continue ;;
    esac

    dst="${DOT_DST}/$(printf '%s\n' "${src#$DOT_SRC/}" | sed 's/dot-/./g')"
    printf "$src => $dst\n"

    mkdir -p "$(dirname $dst)"
    if [ "$force" -eq 1 ]; then
        ln -snf "$src" "$dst"
    else
        ln -sni "$src" "$dst" < /dev/tty
        printf "\n"
    fi
done
