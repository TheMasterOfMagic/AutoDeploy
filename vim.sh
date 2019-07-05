. ./utils.sh

update_apt_if_needed

# make sure vim is installed
if [[ -z "$(command -v vim)" ]]; then
    try_to_install vim
fi

# make sure vim is confiured correctly
cp .vimrc "${HOME}"/.vimrc