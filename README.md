# `>_` git-profile

Bash script in order to switch between various Git profiles, where each profile is represented as `.gitconfig` file.

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

<!-- ## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us. -->

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Giosuè Sulipano** - *Initial work* - [imgios](https://github.com/imgios)

See also the list of [contributors](https://github.com/imgios/git-profile/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
