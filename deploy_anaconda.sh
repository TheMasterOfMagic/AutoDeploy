. ./utils.sh

filename="Anaconda3-2019.03-Linux-x86_64.sh" 

check_anaconda () {
    start "checking anaconda"
    if [[ -d "${HOME}"/anaconda3 ]]; then
        log "anaconda found, installation skipped"
        status=0
    else
        log "anaconda not found, about to install"
        status=1
    fi
    end $?
}

download_anaconda_installation_script () {
    local sha256="45c851b7497cc14d5ca060064394569f724b67d9b5f98a926ed49b834a6bb73a"

    if [[ ! -f "${filename}" ]]; then
        log "installation script not found, about to download"
        status=1
    elif [[ "$(sha256sum ${filename} | awk '{print $1}')" != "${sha256}" ]]; then
        log "broken installation script found, about to re-download"
        status=2
        start "removing broken install script"
        rm "${filename}" > /dev/null
        end $?
    else
        log "installation script found, download skipped"
        status=0
    fi && 
    if [[ "${status}" != 0 ]]; then
        start "downloading installation script, this may take a while"
        wget https://repo.anaconda.com/archive/"${filename}" &> /dev/null
        end $?
    fi
}

install_anaconda () {
    if [[ "${status}" == 1 ]]; then
        start "installing anaconda"
        download_anaconda_installation_script
        (bash "${filename}" -b > /dev/null)
        end $?
    fi
}

deploy_anaconda () {
    start "deploying anaconda"
    check_anaconda && install_anaconda
    end $?
}