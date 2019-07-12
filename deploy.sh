. ./pre_deploy.sh
. ./deploy_basics.sh
. ./deploy_shell.sh
. ./deploy_editor.sh
. ./post_deploy.sh

pre_deploy && \
deploy_basics && \
deploy_shell && \
deploy_editor && \
post_deploy