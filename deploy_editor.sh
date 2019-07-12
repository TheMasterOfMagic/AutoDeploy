. ./utils.sh

install_vim () {
    start "installing vim"
    install vim
    end $?
}

configure_vim () {
    start "configuring vim"
    cp static/vimrc "${HOME}"/.vimrc
    end $?
}

deploy_editor () {
    start "deploying editor"
    install_vim && configure_vim
    end $?
}