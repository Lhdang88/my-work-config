#!/bin/bash
set -e

RED='\x1b[31m'
GREEN='\x1b[32m'
YELLOW='\x1b[33m'
NC='\x1b[0m' # No Color

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# brew must be installed
if ! command -v brew > /dev/null ; then
    printf "${RED}[BREW] - missing${NC} install it first: https://brew.sh\n"
    exit 1
fi
BREW_PREFIX="$(brew --prefix)"

printf "${GREEN}[BREW] - updating ${NC} brew ...\n"
brew update

printf "${GREEN}[IDE] - installing${NC} visual studio code ...\n"
brew install --cask visual-studio-code

printf "${GREEN}[IDE] - installing${NC} IntelliJ IDEA Ultimate ...\n"
brew install --cask intellij-idea

printf "${GREEN}[DB] - installing${NC} DBeaver ...\n"
brew install --cask dbeaver-community

printf "${GREEN}[SHELL] - installing${NC} fish shell ...\n"
brew install fish
FISH="$BREW_PREFIX/bin/fish"

# symlink so edits in ~/.config/fish stay in this repo
printf "${GREEN}[SHELL] - linking${NC} configs for fish shell ...\n"
mkdir -p ~/.config
if [ -L ~/.config/fish ] ; then
    rm ~/.config/fish
elif [ -e ~/.config/fish ] ; then
    printf "${YELLOW}[SHELL] - backing up${NC} existing ~/.config/fish to ~/.config/fish.bak ...\n"
    mv ~/.config/fish ~/.config/fish.bak
fi
ln -s "$REPO_DIR/fish" ~/.config/fish

if "$FISH" -c "omf version" 2> /dev/null ; then
    printf "oh-my-fish! is already installed \n"
else
    printf "${GREEN}[SHELL] - installing${NC} oh-my-fish ...\n"
    curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install
    "$FISH" omf_install --noninteractive --yes
    rm omf_install
fi

printf "${GREEN}[SHELL] - installing${NC} edc/bass for fish shell ...\n"
"$FISH" -c "omf install bass"

printf "${GREEN}[SHELL] - installing${NC} themes for fish shell ...\n"
"$FISH" -c "omf install lambda"
"$FISH" -c "omf theme lambda"

printf "${GREEN}[SHELL] - installing${NC} fisher and plugins from fish_plugins ...\n"
brew install fisher
"$FISH" -c "fisher update"

# SDKMAN needs bash 4+, macOS ships 3.2
printf "${GREEN}[JAVA] installing${NC} SDKMAN, Java and Maven ...\n"
brew install bash
if [ ! -d ~/.sdkman ] ; then
    curl -s "https://get.sdkman.io?rcupdate=false" | "$BREW_PREFIX/bin/bash"
fi
sed -i '' 's/^sdkman_auto_env=.*/sdkman_auto_env=true/' ~/.sdkman/etc/config
"$FISH" -c "sdk install java < /dev/null; sdk install maven < /dev/null"

printf "${GREEN}[K8S] installing${NC} kubectl ...\n"
brew install kubernetes-cli

printf "${GREEN}[AWS] installing${NC} AWS CLI ...\n"
brew install awscli

printf "${GREEN}[NODE] installing${NC} NVM ...\n"
brew install nvm
mkdir -p ~/.nvm

printf "${GREEN}[RUBY] installing${NC} RVM ...\n"
brew install gnupg
gpg --keyserver hkps://keys.openpgp.org --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
curl -fsSL --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.githubusercontent.com/lunks/fish-nuggets/master/functions/rvm.fish

printf "${GREEN}[GOLANG] installing${NC} Golang ...\n"
brew install go

# print notes
if [ "$SHELL" != "$FISH" ] ; then
    printf "${YELLOW}[SHELL] - change ${NC} default shell to fish shell with \n"
    printf "    ${GREEN}echo $FISH | sudo tee -a /etc/shells && chsh -s $FISH ${NC} \n"
fi
