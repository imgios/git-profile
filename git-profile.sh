#!/usr/bin/bash

# Git-Profile
# https://github.com/imgios/git-profile
# Any idea/feedback/bug can be shared/reported using GitHub Issues https://github.com/imgios/git-profile/issues
#
# Usage ./git-profile.sh <profile-name>
# Where <profile-name> is a <profile-name>.gitconfig files existing in the scriptdir/profiles path.
# For more information use ./git-profile.sh --help

# Variables
VERSION=1.0
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_NAME=$(basename $0)
PROFILE_DIR=~/.gitprofile

error() {
  # This function prints error messages
  #
  # $1 is the message to display

  local message=''
  if [[ -z $1 ]]; then
    message="Something went wrong!"
  else
    message=$1
  fi
  local timestamp=$(date +"%m-%d-%yT%T")
  printf "[ %s ] - ERROR - %s" $timestamp $message
}

info() {
  # This function prints info messages
  #
  # $1 is the message to display

  local message=''
  if [[ -z $1 ]]; then
    message="Hello! The author forgot to add the message 👀"
  else
    message=$1
  fi
  local timestamp=$(date +"%m-%d-%yT%T")
  printf "[ %s ] - INFO - %s" $timestamp $message
}

get_usage() {
  # This function prints a USAGE-related string

  echo "USAGE: ${SCRIPT_NAME%%.*} <profile-name>
  
  where: <profile-name> is a <profile-name>.gitconfig files in $PROFILE_DIR
  
  flags:
    -h,--help     Show this help text.
    -s,--save     Save current .gitconfig in $PROFILE_DIR/default.gitconfig if no name is passed, otherwise it will be saved in $PROFILE_DIR/<name_passed>.gitconfig
    -a,--alias    Show bashrc alias to use the script from anywhere
    -V,--version  Show script version."
}

save_gitconfig() {
  # This function saves the actual .gitconfig in profiles/default.gitconfig

  if cp ~/.gitconfig $PROFILE_DIR/$1.gitconfig; then
    info "Profile saved in $PROFILE_DIR/$1.gitconfig"
    return 0
  else
    error "Profile not saved! Be sure the profiles path exists in $PROFILE_DIR"
    return 1
  fi
}

check_git() {
  # This function checks if git is installed on the machine using which

  local path=`which git`
  # if path is an empty string means that git is not installed
  if [[ -z "$path" ]]; then
    return 1
  else
    return 0
  fi
}

check_directory() {
  # Check if a directory is present in the filesystem

  if [[ -d "$1" ]]; then
    return 0
  else
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

# Check if git is present in the machine
# if it's missing exit
if [[ ! check_git ]]; then
  error "Git not found in the system!"
  exit 1;
fi

if ! check_directory $PROFILE_DIR ; then
  if ! mkdir $PROFILE_DIR ; then
    error "Unable to create profile directory '$PROFILE_DIR'. Please, create it manually."
  fi
fi

# Replace the Git config and check if it's ok or not
if cp $PROFILE_DIR/$1.gitconfig ~/.gitconfig; then
  info "Profile $1 applied!"
else
  error "Profile $1 not applied! Be sure the file $1.gitconfig exists in $PROFILE_DIR"
  exit 1
fi
