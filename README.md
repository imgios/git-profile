# `>_` Git Profile

Bash script in order to switch between various Git profiles, where each profile is represented as `.gitconfig` file.

> A scenario could be:
> - A Git profile with the working email (e.g. imgios@github.com) and ssh-key defined to access a repository hosted on the intranet;
> - A different Git profile with the personal email (e.g. imgios@giosuesulipano.it) to access a repository hosted on GitHub (or any other hosting)

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
$ chmod +x git-profile
```

<details>
  <summary><b>(Optional) Global installation and Bash completion ➡</b></summary>
  
  - Install the script:
  
  ```shell
  $ sudo install -o root -g root -m 0755 git-profile /usr/local/bin/git-profile
  ```

  - Source the bash completion:
  
  ```shell
  $ echo "source <(git-profile completion)" >> .bashrc
  ```

</details>

3. Create the `~/.gitprofile` dir and save your actual `.gitconfig` in the profiles path:
```shell
# Manual
$ mkdir ~/.gitprofile && cp ~/.gitconfig ~/.gitprofile/default.gitconfig # You can use any name you wish to use
# Using the script
$ git-profile save <name> # If you have the alias you can use git-profile -s
```
4. Create a new `.gitconfig` file in the profiles path for each account you want to configure (e.g. `github.gitconfig`, `gitlab.gitconfig`, ...), and switch between them using the script:
```shell
$ git-profile set <profile-name>
```

### Usage

Before starting make sure you have saved (see [Installing - Point 3](#installing)) your currently used `.gitconfig`, otherwise you will risk to lose it. Then navigate in the `~/.gitprofile` path and create a new `.gitconfig` for each profile you want to setup.

<details>
  <summary><b>GitConfig example ➡</b></summary>
  
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

</details>

When you're done populating the profiles path, you can start using the script:

```shell
$ git-profile help
USAGE: git-profile <command> [profile] [options]
 
  where: <profile-name> is a <profile-name>.gitconfig files in /home/imgios/.gitprofile
 
  commands:
    set           Set the profile specified as third argument.
    save          Save the profile in-use as default.gitconfig in /home/imgios/.gitprofile.
                  An argument can be passed to customize the profile name.
    list          List all the available profiles present in /home/imgios/.gitprofile
    help          Show this help test.
    version       Show git-profile version.
 
  flags:
    -d,--dir      Specify the Git Profiles directory that will be used to retrieve/store all profiles.
    -v,--verbose  Increase the log level to DEBUG.
 
  examples:
    git-profile set github
    git-profile save work -d /etc/.gitprofile
    git-profile list
 
  Feedbacks and issues can be reported at https://github.com/imgios/git-profile
```

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on the code of conduct, and the process for submitting pull requests.

See also the list of [contributors](https://github.com/imgios/git-profile/contributors) who participated in this project.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/imgios/git-profile/tags).

The current version in development can always be found in the [`dev`](https://github.com/imgios/git-profile/tree/dev) branch.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
