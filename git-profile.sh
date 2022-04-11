#!/usr/bin/bash

# Git-Profile
# https://github.com/imgios/git-profile
# Any idea/feedback/bug can be shared/reported using GitHub Issues https://github.com/imgios/git-profile/issues
#
# Usage ./git-profile.sh <profile-name>
# Where <profile-name> is a <profile-name>.gitconfig files existing in the scriptdir/profiles path.
# For more information use ./git-profile.sh --help

# Variables
VERSION=0.1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROFILE_DIR=$SCRIPT_DIR/profiles
SCRIPT_NAME=$(basename $0)

# This function prints a USAGE-related string
get_usage() {
  echo "USAGE: ${SCRIPT_NAME%%.*} <profile-name>
  
  where: <profile-name> is a <profile-name>.gitconfig files in $PROFILE_DIR
  
  flags:
    -h,--help     Show this help text.
    -s,--save     Save current .gitconfig in $PROFILE_DIR/default.gitconfig if no name is passed, otherwise it will be saved in $PROFILE_DIR/<name_passed>.gitconfig
    -a,--alias    Show bashrc alias to use the script from anywhere
    -V,--version  Show script version."
}

# This function save the actual .gitconfig in profiles/default.gitconfig
save_gitconfig() {
  if cp ~/.gitconfig $PROFILE_DIR/$1.gitconfig; then
    echo "INFO: Profile saved in $PROFILE_DIR/$1.gitconfig"
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
    PROFILE_NAME="default"
    if [[ -n "$2" ]]; then
      PROFILE_NAME=$2
    fi 
    save_gitconfig "$PROFILE_NAME"
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

# See if the script has just one param (the file name)
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
