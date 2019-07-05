. /lib/lsb/init-functions

update_apt_if_needed () {
    last_update=$(stat -c %Y /var/cache/apt/pkgcache.bin) 
    now=$(date +%s)
    if [[ $((now - last_update)) -gt 3600 ]]; then
        log_begin_msg "updating apt"
        sudo apt-get update > /dev/null
        log_end_msg $? || exit $?
    fi
}

try_to_install () {
    log_begin_msg "installing $*"
    sudo apt-get install -y -qq "$@" > /dev/null
    log_end_msg $? || exit $?
}