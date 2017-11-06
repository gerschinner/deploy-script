#!/bin/bash
set -e

WORKSPACE=`pwd`
ENVIRONMENT=$1
BRANCH=$2

source conf/${ENVIRONMENT}/${ENVIRONMENT}.conf

cd ${WORKSPACE}
echo "DEPLOY CODE ON ${SERVER}"
ssh -t jenkins@${SERVER} "sudo chown -R jenkins:jenkins ${DEPLOY_PATH}; cd  ${DEPLOY_PATH}/ && rm -rf .git; git init -q && git remote add origin ${REPO}; git pull --force -q --depth=1 origin ${BRANCH} ; git fetch -q --depth=1 -f ;git checkout -q ${BRANCH} -f; sudo chown -R apache:apache ${DEPLOY_PATH}; git status; sudo service httpd reload"
echo "DEPLOY CODE: DONE"

# Clear some space
[ -d $WORKSPACE/.git ] && rm -rf $WORKSPACE/.git

exit 0
