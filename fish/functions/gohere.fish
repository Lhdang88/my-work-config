function gohere -d "Sets up a Go Workspace in the specified Dir"
    mkdir -p $argv/bin $argv/src $argv/pkg;
    set -x GOPATH (pwd)/$argv;
    set -x PATH $PATH (pwd)/$argv/bin;
    echo New GOPATH is $GOPATH;
end