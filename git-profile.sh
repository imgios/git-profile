#!/usr/bin/bash

# Switch Git Profile replacing the .gitconfig
# Usage ./git-profile.sh <profile-name>
# Where <profile-name> is a <profile-name>.gitconfig files existing in the scriptdir/profiles path.

# Variables
VERSION=0.1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROFILE_DIR=$SCRIPT_DIR/profiles
SCRIPT_NAME=$(basename $0)

# This functions prints a USAGE-related string
get_usage() {
  echo "USAGE: ${SCRIPT_NAME%%.*} <profile-name>"
}

# This functions save the actual .gitconfig in profiles/default.gitconfig
save_gitconfig() {
  if (cp ~/.gitconfig $PROFILE_DIR/default.gitconfig); then
    echo "INFO: Profile saved in $PROFILE_DIR/default.gitconfig"
  elif
    echo "ERROR: Profile not saved! Be sure the profiles path exists in $PROFILE_DIR"
    exit 1
  fi
}

# See if the script has the profile name
if [[ $# -ne 1 ]]; then
    get_usage
    exit 1
fi

# Replace the Git config and check if it's ok or not
if (cp $PROFILE_DIR/$1.gitconfig ~/.gitconfig); then
  echo "INFO: Profile $1 applied!"
elif
  echo "ERROR: Profile $1 not applied! Be sure the file $1.gitconfig exists in $PROFILE_DIR"
  exit 1
fi
