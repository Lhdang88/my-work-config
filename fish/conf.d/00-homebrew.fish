# homebrew (Apple Silicon)
# in conf.d so it runs before plugins like sdk.fish, which need brew's bash 4+
if test -x /opt/homebrew/bin/brew
   /opt/homebrew/bin/brew shellenv | source
end
