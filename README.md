# `>_` Git Profile

Bash script in order to switch between various Git profiles, where each profile is represented as `.gitconfig` file.

> A scenario could be:
> - Work profile with the working email (e.g. imgios@github.com) and ssh-key defined to access a repository hosted on the intranet;
> - Personal profile with the personal email (e.g. imgios@giosuesulipano.it) to access a repository hosted on GitHub (or any other hosting)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for usage, development and testing purposes.

### Prerequisites

- Git
- Shell/Bash 🤷🏻‍♂️

### Installing

1. Download the [latest release](https://github.com/imgios/git-profile/releases) or clone the repository:
```shell
$ git clone https://github.com/imgios/git-profile.git
```
2. Make the script executable:
```shell
$ chmod +x git-profile.sh
```
2.1. (Optional) Create the alias to use it from anywhere:
```shell
$ alias git-profile='$(pwd)/git-profile.sh' # Paste this string into .bashrc
# You can also generate the string using the script
$ ./git-profile.sh --alias
```
3. Save your actual `.gitconfig` in the profiles path:
```shell
# Manual
$ cp ~/.gitconfig $(pwd)/profiles/default.gitconfig # You can use any name you wish to use
# Using the script
$ ./git-profile.sh -s # If you have the alias you can use git-profile -s
```
4. Create a new `.gitconfig` file in the profiles path for each account you want to configure (e.g. `github.gitconfig`, `gitlab.gitconfig`, ...), and switch between them using the script:
```shell
$ git-profile <profile-name>
```

### Usage

Before starting make sure you have saved (see [Installing - Point 3](#installing)) your currently used `.gitconfig`, otherwise you will risk to lose it. Then navigate in the `/profiles` path and create a new `.gitconfig` for each profile you want to setup.

```GitConfig
# Example .gitconfig used as Git profile
[user]
  name = Your Name
  email = your-email@example.com

[color]
  ui = auto

[alias]
  co = checkout
  ci = commit
  st = status
  br = branch -av
  brdel = branch -D

  # Show all configured aliases
  aliases = !git config --list | grep 'alias\\.' | sed 's/alias\\.\\([^=]*\\)=\\(.*\\)/\\1\\ \t => \\2/' | sort

  # Log format view
  lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
  hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
```

When you're done populating the profiles path, you can start using the script:

```shell
$ git-profile --help
USAGE: git-profile <profile-name>
  
  where: <profile-name> is a <profile-name>.gitconfig files in ~/git-profile/profiles/
  
  flags:
    -h,--help     Show this help text.
    -s,--save     Save current .gitconfig in ~/git-profile/profiles/default.gitconfig
    -a,--alias    Show bashrc alias to use the script from anywhere
    -V,--version  Show script version.
    
$ git-profile github # This will override the .gitconfig in use with the github.gitconfig defined in /profiles/github.config
INFO: Profile github applied!
```

> Examples using alias as described in [Installing - Optional Point 2.1](#installing), if you don't use it you can simply go with `./git-profile.sh`.

<!-- ## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us. -->

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Giosuè Sulipano** - *Initial work* - [imgios](https://github.com/imgios)

See also the list of [contributors](https://github.com/imgios/git-profile/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
