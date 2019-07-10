. ./utils.sh

check_root_priv () {
    start "checking root privilege"
    [[ "$(id -u)" == 0 ]]
    end $?
}

check_ubuntu_1804 () {
    start "checking Ubuntu 18.04"
    [[ "$(head -n 1 /etc/issue | cut -b -12)" == "Ubuntu 18.04" ]]
    end $?
}

configure_dpkg () {
    start "configuring dpkg"
    if [[ -f /etc/dpkg/dpkg.cfg.d/excludes ]]; then
        sed -i '/path-exclude=\/usr\/share\/man\/*/c\#path-exclude=\/usr\/share\/man\/*' /etc/dpkg/dpkg.cfg.d/excludes
    fi
    end $?
}

configure_apt () {
    start "configuring apt"
    rm -r /etc/apt &> /dev/null || true
    cp -r ./static/apt /etc/apt && mkdir /etc/apt/preferences.d
    end $?
}

pre_deploy () {
    start "pre deploying"
    check_root_priv && \
    check_ubuntu_1804 && \
    configure_dpkg && \
    configure_apt
    end $?
}
