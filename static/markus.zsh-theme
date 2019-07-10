#!/usr/bin/env bash

# pre defines
declare reset_color > /dev/null
declare fg_bold > /dev/null
reset="%{$reset_color%}"
red="%{${fg_bold[red]}%}"
yellow="%{${fg_bold[yellow]}%}"
green="%{${fg_bold[green]}%}"
cyan="%{${fg_bold[cyan]}%}"
blue="%{${fg_bold[blue]}%}"
magenta="%{${fg_bold[magenta]}%}"
white="%{${fg_bold[white]}%}"


# username and hostname
uh_color="%(!:${magenta}:${cyan})"
uh_content="%n@%1m"
uh="${uh_color}${uh_content}${reset}"

# directory info
dir_color="${yellow}"
dir_content="\${PWD/#\$HOME/~}"
dir="${dir_color}${dir_content}${reset}"

# git info
export ZSH_THEME_GIT_PROMPT_PREFIX="${white}[${blue}"
export ZSH_THEME_GIT_PROMPT_CLEAN=" ${green}✔ "
export ZSH_THEME_GIT_PROMPT_DIRTY=" ${red}✘ "
export ZSH_THEME_GIT_PROMPT_SUFFIX="${reset}"
export ZSH_THEME_GIT_PROMPT_SHA_BEFORE="${red}"
export ZSH_THEME_GIT_PROMPT_SHA_AFTER="${reset}${white}]"
git_info="\$(git_prompt_info)\$(git_prompt_short_sha)"

# ret symbol
ret_color="%(?:${green}:${red})"
ret_content="➜ "
ret="${ret_color}${ret_content}${reset}"

# prompt
export PROMPT="
${uh}:${dir} ${git_info}
${ret}"
