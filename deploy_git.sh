. ./utils.sh

install_git () {
    start "installing git"
    install git
    end $?
}

configure_git () {
    start "configuring git"
    git config --global alias.st status
    git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    end $?
}

deploy_git () {
    start "deploying git"
    install_git && configure_git
    end $?
}
