. ./utils.sh

set_env_var () {
    if [[ -z "${2:-}" ]]; then
        return 1
    fi
    key="${1}"
    value="${2}"
    rc_file="${3:-${HOME}/.zshrc}"
    start "setting environment variables ${key}=${value}"
    script="export ${key}=${value}"
    if ! grep "^${script}$" "${rc_file}" &> /dev/null; then
        printf "\n${script}" >> "${rc_file}"
    fi
    end $?
}

post_deploy () {
    start "post deploying"
    set_env_var "LANG" "en_US.UTF-8" && \
    set_env_var "PATH" "\${PATH}:\${HOME}/anaconda3/bin"
    end $?
    log "Note: You may need to start a new terminal to apply some changes."
}
