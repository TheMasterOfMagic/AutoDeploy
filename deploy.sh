. ./pre_deploy.sh
. ./deploy_basics.sh
. ./deploy_shell.sh
. ./post_deploy.sh

pre_deploy && \
deploy_basics && \
deploy_shell && \
post_deploy