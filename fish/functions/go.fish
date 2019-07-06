function gohere -d "Sets up a Go Workspace in the specified Dir"
    mkdir -p $argv/bin $argv/src $argv/pkg;
    set -g GOPATH (pwd)/$argv;
    set -g PATH $PATH (pwd)/$argv/bin;
    echo New GOPATH is $GOPATH;
end

function goset -d "Sets up the Go environment in current Dir"
    set -g GOPATH (pwd);
    set -g PATH $PATH (pwd)/bin;
    echo New GOPATH is $GOPATH;
end