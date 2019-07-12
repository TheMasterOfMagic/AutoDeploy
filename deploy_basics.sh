. ./utils.sh

install_basic_packages () {
    start "installing basic packages"
    install apt-utils && \
    install dialog && \
    install ssh git wget curl net-tools iproute2 iputils-ping traceroute man tcpdump locales locales-all
    end $?
}

deploy_basics () {
    start "deploying basics"
    install_basic_packages
    end $?
}
