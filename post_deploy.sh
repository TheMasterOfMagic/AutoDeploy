. ./utils.sh

configure_locale () {
    start "configuring locale"
    if grep "^export LANG=" "${HOME}/.zshrc" &> /dev/null; then
        sed -i "s/^export LANG=.*/export LANG=en_US.UTF-8/g" "${HOME}/.zshrc"
    else
        printf "\nexport LANG=en_US.UTF-8\n" >> "${HOME}/.zshrc"
    fi
    end $?
}

post_deploy () {
    start "post deploying"
    configure_locale
    end $?
    log "Note: You may need to start a new terminal to apply some changes."
}