#!/usr/bin/bash

# Git-Profile
# https://github.com/imgios/git-profile
# Any idea/feedback/bug can be shared/reported using GitHub Issues https://github.com/imgios/git-profile/issues
#
# Usage ./git-profile.sh <profile-name>
# Where <profile-name> is a <profile-name>.gitconfig files existing in the scriptdir/profiles path.
# For more information use ./git-profile.sh --help

# Variables
VERSION=1.1
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SCRIPT_NAME=$(basename $0)
PROFILE_DIR=~/.gitprofile
VERBOSE=false

error() {
  # This function prints error messages
  #
  # $1 is the message to display

  local message=''
  if [[ -z $1 ]]; then
    message="Something went wrong!"
  else
    message="$1"
  fi
  local timestamp=$(date +"%m-%d-%yT%T")
  printf "[ %s ] - ERROR - %s" "$timestamp" "$message"
}

info() {
  # This function prints info messages
  #
  # $1 is the message to display

  local message=''
  if [[ -z $1 ]]; then
    message="Hello! The author forgot to add the message 👀"
  else
    message="$1"
  fi
  local timestamp=$(date +"%m-%d-%yT%T")
  printf "[ %s ] - INFO - %s" "$timestamp" "$message"
}

get_usage() {
  # This function prints a USAGE-related string

  echo "USAGE: ${SCRIPT_NAME%%.*} <command> [profile] [options]
  
  where: <profile-name> is a <profile-name>.gitconfig files in $PROFILE_DIR

  commands:
    set           Set the profile specified as third argument.
    save          Save the profile in-use as default.gitconfig in $PROFILE_DIR.
                  An argument can be passed to customize the profile name.
    list          List all the available profiles present in $PROFILE_DIR
    help          Show this help test.
    version       Show ${SCRIPT_NAME%%.*} version.
  
  flags:
    -d,--dir      Specify the Git Profiles directory that will be used to retrieve/store all profiles.
    -v,--verbose  Increase the log level to DEBUG.
  
  examples:
    ${SCRIPT_NAME%%.*} set github
    ${SCRIPT_NAME%%.*} save work -d /etc/.gitprofile
    ${SCRIPT_NAME%%.*} list
    
  Feedbacks and issues can be reported at https://github.com/imgios/git-profile"
}

save() {
  # This function saves the .gitconfig currently in use.
  #
  # Params:
  #   $1  string  profile name to use

  if cp ~/.gitconfig $PROFILE_DIR/$1.gitconfig; then
    info "Profile saved in $PROFILE_DIR/$1.gitconfig"
    return 0
  else
    error "Profile not saved! Be sure the profiles path exists in $PROFILE_DIR"
    return 1
  fi
}

list() {
  # This function lists the content of $PROFILE_DIR

  if [ -d "$PROFILE_DIR" ]; then
    profiles=(`ls ${PROFILE_DIR} | grep gitconfig | sed 's/\.gitconfig//g'`)
    if [ "${#profiles[@]}" -gt 0 ] ; then
      info "Found ${#profiles[@]} profiles: ${profiles[@]}"
      return 0
    else
      info "No profile found in $PROFILE_DIR"
      return 1
    fi
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

set() {
  # This function implements the set command
  # and replace the Git profile with the one
  # passed as argument.
  #
  # Params:
  #   $1  string  profile name

  # Check if git is present in the machine
  # if it's missing exit
  if [[ ! check_git ]]; then
    error "Git not found in the system!"
    return 1;
  fi

  # Check if the first fun argument is the profile name
  # If so, store it in a given variable
  # otherwise, throw an error.
  PROFILE_NAME="None"
  first_positional="$1"
  if [[ ! -z "${first_positional// }" ]] && [[ ! "$1" =~ ^- ]]; then
    PROFILE_NAME=$1
  else
    error "Profile name must be passed as command argument!"
    # get_usage
    # exit 1
    return 1
  fi

  if ! check_directory $PROFILE_DIR ; then
    error "$PROFILE_DIR not found"
    read -p "Seems like $PROFILE_DIR doesn't exist, do you want to create it? " REPLY
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      if ! mkdir $PROFILE_DIR ; then
        error "Unable to create profile directory '$PROFILE_DIR'. Please, create it manually."
      fi
    else
      info "$PROFILE_DIR won't be created, exiting!"
    fi
  fi

  # Replace the Git config and check if it's ok or not
  if cp $PROFILE_DIR/$1.gitconfig ~/.gitconfig; then
    info "Profile $PROFILE_NAME applied!"
  else
    error "Profile $PROFILE_NAME not applied! Be sure the file $1.gitconfig exists in $PROFILE_DIR"
    exit 1
  fi
}

main() {
  # This function is the script entry point
  
  args=( "$@" )

  # Check for options
  for arg in "${args[@]}"; do
    if [[ "$arg" =~ ^- && ! "$arg" == "--" ]]; then
      case $arg in
        -d | --dir)
          if [[ -n "$2" ]]; then
            PROFILE_DIR=$2
          else
            error "$arg must be used with a value to specify the profiles directory!"
            exit 1
          fi
          ;;
        -v | --verbose)
          VERBOSE=true
          ;;
      esac
    fi
  done

  # Check if the first argument is a command or not
  case $1 in
    set)
      if [[ -n "$2" ]] && [[ ! "$1" =~ ^- ]]; then
        set "$2" && exit 0 || exit 1
      else
        error "Profile name is missing. Please, pass it as command argument."
        get_usage
      fi
      ;;
    save)
      if [[ -n "$2" ]] && [[ ! "$1" =~ ^- ]]; then
        save "$2" && exit 0 || exit 1
      else
        save "default" && exit 0 || exit 1
      fi
      ;;
    list)
      list && exit 0 || exit 1
      ;;
    help)
      get_usage
      exit 0
      ;;
    version)
      echo $VERSION
      exit 0
      ;;
    *)
      get_usage
      exit 1
      ;;
  esac
}

main "$@"