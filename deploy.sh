. ./pre_deploy.sh
. ./deploy_basics.sh
. ./deploy_shell.sh
. ./deploy_editor.sh
. ./deploy_git.sh
. ./post_deploy.sh

pre_deploy && \
deploy_basics && \
deploy_shell && \
deploy_editor && \
deploy_git && \
post_deploy