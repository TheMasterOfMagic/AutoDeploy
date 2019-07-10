. ./utils.sh

install_zsh () {
    start "installing zsh"
    update_apt_if_needed && \
    install zsh
    end $?
}

apply_zsh () {
    start "applying zsh for current user"
    chsh -s "$(command -v zsh)" "$(whoami)"
    end $?
}

install_oh_my_zsh () {
    local d f status

    start "checking oh-my-zsh status"
    [[ -d "${HOME}"/.oh-my-zsh ]]
    d=$?
    [[ -f "${HOME}"/.zshrc ]]
    f=$?

    if [[ $d == 0 && $f == 0 ]]; then
        log "oh-my-zsh found, installation skipped"
        status=0
    elif [[ $d != 0 && $f != 0 ]]; then
        log "oh-my-zsh not found, about to install"
        status=1
    else
        log "broken oh-my-zsh found, about to reinstall"
        status=2
        start "cleaning broken oh-my-zsh"
        (rm -r "${HOME}"/.oh-my-zsh &> /dev/null || true) && (rm "${HOME}"/.zshrc &> /dev/null || true)
        end $?
    fi
    end 0

    if [[ "${status}" != 0 ]]; then
        start "installing oh-my-zsh"        
        git clone https://github.com/robbyrussell/oh-my-zsh.git "${HOME}"/.oh-my-zsh > /dev/null && \
        cp "${HOME}"/.oh-my-zsh/templates/zshrc.zsh-template "${HOME}"/.zshrc
        end $?
    fi
}

configure_oh_my_zsh () {
    set_zsh_theme () {
        start "setting zsh theme"
        cp ./static/markus.zsh-theme "${HOME}"/.oh-my-zsh/custom/themes/markus.zsh-theme && \
        sed -i "s/^ZSH_THEME=.*/ZSH_THEME=markus/" "${HOME}"/.zshrc
        end $?
    }
    install_plugins () {
        ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
        download_plugin () {
            start "downloading plugin $1"
            if [[ -d "${ZSH_CUSTOM}"/plugins/"$1" ]]; then
                log "already downloaded"
            else
                git clone https://github.com/zsh-users/"$1" "${ZSH_CUSTOM}"/plugins/"$1" > /dev/null
            fi
            end $?
        }
        apply_plugins () {
            start "applying plugins"
            sed -i "s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" "${HOME}"/.zshrc
            end $?
        }
        start "installing plugins"
        download_plugin "zsh-autosuggestions" && \
        download_plugin "zsh-syntax-highlighting" && \
        apply_plugins
        end $?
    }
    start "configuring oh-my-zsh"
    set_zsh_theme && install_plugins
    end $?
}

deploy_shell () {
    start "deploying shell"
    install_zsh && apply_zsh && install_oh_my_zsh && configure_oh_my_zsh
    end $?
}