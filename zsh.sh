. ./utils.sh

update_apt_if_needed

# make sure zsh is installed
if [[ -z "$(command -v zsh)" ]]; then
    try_to_install zsh
fi

# make sure zsh is applied for current user
sudo chsh -s "$(command -v zsh)" "$(whoami)"

# make sure oh-my-zsh is installed
[[ -d "${HOME}"/.oh-my-zsh ]]
directory_exists=$?
[[ -f "${HOME}"/.zshrc ]]
rcfile_exists=$?
if [[ "${directory_exists}" && ! "${rcfile_exists}" || ! "${directory_exists}" && "${rcfile_exists}" ]]; then
    log_warning_msg "broken oh-my-zsh, about to reinstall"
    rm -r "${HOME}"/.oh-my-zsh &> /dev/null || true
    rm "${HOME}"/.zshrc &> /dev/null || true
fi
if [[ ! -d "${HOME}"/.oh-my-zsh && ! -f "${HOME}"/.zshrc ]]; then
    log_begin_msg "installing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${HOME}"/.oh-my-zsh > /dev/null
    log_end_msg $? || exit $?
    cp "${HOME}"/.oh-my-zsh/templates/zshrc.zsh-template "${HOME}"/.zshrc
fi

# make sure oh-my-zsh is confiured correctly
log_begin_msg "setting theme"
cp ./markus.zsh-theme "${HOME}"/.oh-my-zsh/custom/themes/markus.zsh-theme
sed -i "s/^ZSH_THEME=.*/ZSH_THEME=markus/" "${HOME}"/.zshrc
log_end_msg $? || exit $?

ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
log_begin_msg "installing plugin zsh-autosuggestions"
[[ -d "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions > /dev/null
log_end_msg $? || exit $?
log_begin_msg "installing plugin zsh-syntax-highlighting"
[[ -d "${ZSH_CUSTOM}"/plugins/zsh-syntax-highlighting ]] || git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}"/plugins/zsh-syntax-highlighting > /dev/null
log_end_msg $? || exit $?
log_begin_msg "modifying .zshrc"
sed -i "s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" "${HOME}"/.zshrc
log_end_msg $? || exit $?