function update-tools --description 'Update brew packages, SDKMAN candidates and fisher plugins'
    brew update; and brew upgrade --greedy
    sdk selfupdate; sdk update; sdk upgrade
    fisher update
end
