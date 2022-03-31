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
  echo "USAGE: ${SCRIPT_NAME%%.*} <profile-name>
  
  where: <profile-name> is a <profile-name>.gitconfig files in $PROFILE_DIR
  
  flags:
    -h,--help     Show this help text.
    -s,--save     Save current .gitconfig in $PROFILE_DIR/default.gitconfig
    -a,--alias    Show bashrc alias to use the script from anywhere
    -V,--version  Show script version."
}

# This functions save the actual .gitconfig in profiles/default.gitconfig
save_gitconfig() {
  if cp ~/.gitconfig $PROFILE_DIR/default.gitconfig; then
    echo "INFO: Profile saved in $PROFILE_DIR/default.gitconfig"
    return 0
  else
    echo "ERROR: Profile not saved! Be sure the profiles path exists in $PROFILE_DIR"
    return 1
  fi
}

# Script flags
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
  -V | --version )
    echo $VERSION
    exit
    ;;
  -s | --save )
    save_gitconfig
    exit
    ;;
  -a | --alias )
    echo "Paste the following string in your .bashrc to call the script from anywhere:"
    echo "alias git-profile='$SCRIPT_DIR/$SCRIPT_NAME.sh'"
    exit
    ;;
  -h | --help )
    get_usage
    exit
    ;;
  * )
    echo "Flag $1 not recognised!"
    get_usage
    exit
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi

# See if the script has at least a param
if [[ $# -ne 1 ]]; then
    get_usage
    exit 1
fi

# Replace the Git config and check if it's ok or not
if cp $PROFILE_DIR/$1.gitconfig ~/.gitconfig; then
  echo "INFO: Profile $1 applied!"
else
  echo "ERROR: Profile $1 not applied! Be sure the file $1.gitconfig exists in $PROFILE_DIR"
  exit 1
fi
