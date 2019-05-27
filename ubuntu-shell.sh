#!/usr/bin/env bash

set -e

# do apt-get update first and install dependencies
echo "updating apt-get"
sudo apt-get update &> /dev/null || (echo >&2 "failed to apt-get update" && exit 1)
echo "apt-get updated"
echo "installing dependencies"
sudo apt-get install -y git &> /dev/null || (echo >&2 "failed to install dependencies" && exit 1
echo "dependencies installed")

# make sure zsh is installed
if [[ "$(command -v zsh)" != "" ]]
then
    echo "zsh found, installation skipped"
else
    echo "zsh not found, installing"
    sudo apt-get install -y zsh &> /dev/null || (echo >&2 "failed to install zsh" && exit 1)
    echo "zsh installed"
fi
sudo chsh -s "$(command -v zsh)" "$(whoami)"
echo "zsh applied for $(whoami)"

# make sure oh-my-zsh is installed
if [[ -d "${HOME}"/.oh-my-zsh ]]
then
    echo "oh-my-zsh found, installation skipped"
else
    echo "oh-my-zsh not found, installing"
    git clone https://github.com/robbyrussell/oh-my-zsh.git "${HOME}"/.oh-my-zsh || (echo >&2 "failed to install oh-my-zsh" && exit 1)
    [[ -d "${HOME}"/.zshrc ]] || cp "${HOME}"/.oh-my-zsh/templates/zshrc.zsh-template "${HOME}"/.zshrc
    echo "oh-my-zsh installed"
fi

# make sure theme markus is installed
if [[ -f "${HOME}"/.oh-my-zsh/custom/themes/markus.zsh-theme ]]
then
    echo "markus.zsh-theme found, installation skipped"
else
    echo "markus.zsh-theme not found, installing"
    wget https://raw.githubusercontent.com/TheMasterOfMagic/AutoDeploy/master/markus.zsh-theme -O "${HOME}"/.oh-my-zsh/custom/themes/markus.zsh-theme &> /dev/null || (echo >& 2 "failed to download markus.zsh-theme" && exit 1)
    sed -i "s/^ZSH_THEME=.*/ZSH_THEME=markus/" "${HOME}"/.zshrc
    echo "markus.zsh-theme installed"
fi

# make sure plugins are installed
ZSH_CUSTOM="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
if [[ -d "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions ]]
then
    echo "zsh-autosuggestions found, installation skipped"
else
    echo "zsh-autosuggestions not found, installing"
    [[ -d "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions ]] || git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions || (echo >&2 "failed to install zsh-autosuggestions" && exit 1)
    echo "zsh-autosuggestions installed"
fi
if [[ -d "${ZSH_CUSTOM}"/plugins/zsh-syntax-highlighting ]]
then
    echo "zsh-syntax-highlighting found, installation skipped"
else
    echo "zsh-syntax-highlighting not found, installing"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM}"/plugins/zsh-syntax-highlighting || (echo >&2 "failed to install zsh-syntax-highlighting" && exit 1)
    echo "zsh-syntax-highlighting installed"
fi
sed -i "s/^plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" "${HOME}"/.zshrc

# the end
echo "finished, re-login to apply"