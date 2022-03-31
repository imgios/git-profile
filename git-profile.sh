#!/usr/bin/bash

# Switch Git Profile replacing the .gitconfig
# Usage ./git-profile.sh <profile-name>
# Where <profile-name> is a <profile-name>.gitconfig files existing in the scriptdir/profiles path.

# Func: Print USAGE
get_usage() {
  echo "USAGE: ${SCRIPT_NAME%%.*} <profile-name>"
}

# See if the script has the profile name
if [[ $# -ne 1 ]]; then
    SCRIPT_NAME=$(basename $0)
    get_usage
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROFILE_DIR=$SCRIPT_DIR/profiles
# Replace the Git config and check if it's ok or not
if (cp $PROFILE_DIR/$1.gitconfig ~/.gitconfig); then
  echo "INFO: Profile $1 applied!"
elif
  echo "ERROR: Profile $1 not applied! Be sure the file $1.gitconfig exists in $PROFILE_DIR"
  exit 1
fi
