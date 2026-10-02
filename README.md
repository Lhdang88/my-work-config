# my-work-config

setup script for my MacOS working environment (aka dotfiles) consisting of

1. fish shell, oh-my-fish + lambda theme, bass
1. visual studio code
1. nvm, nodejs
1. rvm, golang
1. utility aliases

## Setup

Requires [Homebrew](https://brew.sh).

```sh
git clone https://github.com/Lhdang88/my-work-config.git ~/develop/my-work-config
cd ~/develop/my-work-config
./install.sh
```

Then make fish the default shell (the script prints this if needed):

```sh
echo $(brew --prefix)/bin/fish | sudo tee -a /etc/shells && chsh -s $(brew --prefix)/bin/fish
```

On the first fish start, nvm installs the latest Node LTS and sets it as default.

## How it works

`install.sh` symlinks `~/.config/fish` to the `fish/` folder of this repo, so
any change to the fish config is a change in the repo — commit and push it.
An existing `~/.config/fish` is moved to `~/.config/fish.bak`.

```
fish/
├── config.fish        # PATHs, abbreviations, rvm/go/nvm setup
├── conf.d/00-homebrew.fish  # Homebrew PATH, loaded before plugins
├── conf.d/omf.fish    # oh-my-fish bootstrap
├── fish_plugins       # fisher plugins (sdkman-for-fish)
└── functions/         # gacp, gohere, goset, update-tools
```

`config.fish` only sets up rvm, go and nvm when they are installed, so fish
starts cleanly even if some of them are missing. nvm needs the `bass` plugin
(`omf install bass`).

`functions/rvm.fish` is downloaded by `install.sh` and ignored by git.

fisher plugins are listed in `fish/fish_plugins`; `install.sh` runs
`fisher update` to install them. The files fisher writes are ignored by git.

Java and Maven come from SDKMAN (`sdk`, via the sdkman-for-fish plugin);
kubectl and the AWS CLI come from Homebrew. In projects, use the Maven
wrapper `./mvnw`.

## Abbreviations

| abbr | expands to |
| --- | --- |
| `rl` | `omf reload` |
| `cdt` / `cdl` / `cdd` | `cd ~/Desktop` / `~/Downloads` / `~/Develop` |
| `cpy` / `pst` | `pbcopy` / `pbpaste` |
| `cc` | `code .` |
| `dc` / `dcp` | `docker` / `docker-compose` |
| `kctl` | `kubectl` |
| `gcl` | `git clone` |
| `gs` | `git status` |
| `ga` | `git add .` |
| `gc` | `git commit -am` |
| `grb` | `git rebase -i` |
| `gp` / `gpl` / `gpt` | `git push` / `git pull` / `git push --tags` |

## Functions

- `gacp <message>` — git add, commit and push in one
- `gohere <dir>` — create a Go workspace in `<dir>` and set `GOPATH`
- `goset` — use the current dir as `GOPATH`
- `update-tools` — upgrade Homebrew packages (including self-updating casks like IntelliJ), SDKMAN candidates and fisher plugins
