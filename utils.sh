. ./logger.sh

update_apt_if_needed () {
    start "update apt if needed"
    last_update=$(stat -c %Y /var/cache/apt/pkgcache.bin 2> /dev/null || echo 0) 
    now=$(date +%s)
    if [[ $((now - last_update)) -gt 3600 ]]; then
        log "updating apt"
        apt-get update > /dev/null
    else
        log "no need"
    fi
    end $?
}

install () {
    update_apt_if_needed &&
    (
        start "apt installing $*"
        apt-get install -y -qq "$@" > /dev/null
        end $?
    )
}
