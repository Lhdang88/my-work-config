#!/bin/bash
set -e

RED='\x1b[31m'
GREEN='\x1b[32m'
YELLOW='\x1b[33m'
NC='\x1b[0m' # No Color

# brew must be installed
printf "${GREEN}[BREW] - updating ${NC} brew ...\n"
brew update

printf "${GREEN}[IDE] - installing${NC} visual studio code ...\n"
brew cask install visual-studio-code

printf "${GREEN}[SHELL] - installing${NC} fish shell ...\n"
brew install fish

if fish -c "omf version" 2> /dev/null ; then
    printf "oh-my-fish! is already installed \n"
else
    printf "${GREEN}[SHELL] - installing${NC} oh-my-fish ...\n"
    curl -L https://get.oh-my.fish > omf_install && chmod 755 omf_install
    ./omf_install --noninteractive
    rm omf_install
    
    printf "${GREEN}[SHELL] - installing${NC} edc/bass for fish shell ...\n"
    fish -c "omf install bass"

    printf "${GREEN}[SHELL] - installing${NC} themes for fish shell ...\n"
    fish -c "omf install lambda"
    fish -c "omf theme lambda"
fi

printf "${GREEN}[SHELL] -copying${NC} configs for fish shell ...\n"
cp -r $PWD/fish ~/.config

printf "${GREEN}[NODE] installing${NC} NVM ...\n"
brew install nvm

printf "${GREEN}[RUBY] installing${NC} RVM ...\n"
gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
curl -L --create-dirs -o ~/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish

printf "${GREEN}[GOLANG] installing${NC} Golang ...\n"
brew install golang

# print notes
printf "${YELLOW}[SHELL] - change ${NC} default shell to fish shell with \n"
printf "    ${GREEN}sudo sh -c \"echo '/usr/local/bin/fish' >> /etc/shells\" && chsh -s /usr/local/bin/fish ${NC} \n"
