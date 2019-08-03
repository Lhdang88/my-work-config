# PATHs
# set nvm
set -x  NVM_DIR ~/.nvm
# set rvm
set -x PATH $PATH ~/.rvm/bin 
# set go
set -x GOPATH (go env GOPATH)

# Abbreviations
# reload this
abbr -a rl omf reload
# little helpers
abbr -a cdt cd ~/Desktop
abbr -a cdl cd ~/Downloads
abbr -a cdd cd ~/Develop
abbr -a cpy pbcopy
abbr -a pst pbpaste

# vs code, docker, k8s etc.
abbr -a cc code .
abbr -a dc docker
abbr -a dcp docker-compose
abbr -a kctl kubectl
# git
abbr -a gcl git clone
abbr -a gs git status
abbr -a ga git add .
abbr -a gc git commit -am
abbr -a grb git rebase -i
abbr -a gp git push
abbr -a gpl git pull
abbr -a gpt git push --tags

# set rvm default
if rvm use default
   printf "rvm ready\n"
else
   printf "consider running 'rvm install' ...\n"
end

# sourcing nvm
function nvm
   bass source /usr/local/opt/nvm/nvm.sh --no-use ';' nvm $argv
end

if nvm use default
   printf "nvm ready \n"
else
   nvm install --lts
   nvm alias default node
   nvm use default
   printf "nvm ready \n"
end
