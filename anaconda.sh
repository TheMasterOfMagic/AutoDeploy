. ./utils.sh

# make sure anaconda is installed
if [[ ! -d "${HOME}"/anaconda3 ]]; then
    log_begin_msg "downloading anaconda3 installation script"
    wget https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh &> /dev/null && \
    [[ $(sha256sum Anaconda3-2019.03-Linux-x86_64.sh) == "45c851b7497cc14d5ca060064394569f724b67d9b5f98a926ed49b834a6bb73a  Anaconda3-2019.03-Linux-x86_64.sh" ]]
    log_end_msg $? || exit $?
    log_begin_msg "installing anaconda3"
    bash Anaconda3-2019.03-Linux-x86_64.sh -b > /dev/null
    log_end_msg $? || exit $?
fi

# make sure anaconda is confirued correctly
if [[ -f "${HOME}"/.zshrc ]]; then
    rc_file="${HOME}"/.zshrc
else
    rc_file="${HOME}"/.bashrc
fi
log_begin_msg "configuring anaconda3"
script="export PATH=\$PATH:\$HOME/anaconda3/bin"
if ! grep "${rc_file}" "${script}" > /dev/null; then
    echo "${script}" >> "${rc_file}"
    log_warning_msg "For this change to become active, you have to open a new terminal."
fi
log_end_msg 0