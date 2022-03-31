#!/usr/bin/bash

# Switch Git Profile replacing the .gitconfig
# Usage ./git-profile.sh <github/gitlab>
# Where github/gitlab are .gitconfig files existing in the scriptdir/profiles

# Func: Print USAGE
get_usage() {
  echo "USAGE: ${SCRIPT_NAME%%.*} {github|gitlab}"
}

if [[ $# -ne 1 ]]; then
    SCRIPT_NAME=$(basename $0)
    get_usage
    exit 1
fi

case "$1" in
    github | gitlab)
        SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
        cp $SCRIPT_DIR/profiles/$1.gitconfig ~/.gitconfig
        ;;
    *)
        get_usage
        exit 1
        ;;
esac
