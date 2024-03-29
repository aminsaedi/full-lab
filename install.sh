#!/bin/bash

set -e

TEMP_DIR=$(mktemp -d)

ROOT_DIR=$(pwd)


# ask for confirmation

# cd to ./terraform dir and run terraform init

cd $ROOT_DIR/terraform

terraform init > /dev/null 2>&1

start_time=$(date +%s)

terraform apply -auto-approve > /dev/null 2>&1

end_time=$(date +%s)

terraform output -json > $TEMP_DIR/terraform-output.json

if [ $((end_time - start_time)) -gt 10 ]; then
  echo "Sleeping for 60 seconds to allow the Droplet to start"
  sleep 60
fi

cd $ROOT_DIR/ansible

GITLAB_HOST=$(jq -r '."gitlab-server-fqdn".value' $TEMP_DIR/terraform-output.json)

ansible-playbook -e "temp_dir=$TEMP_DIR gitlab_host=$GITLAB_HOST" playbooks/all.yml


echo "GitLab is ready at: https://$GITLAB_HOST"

PASSWORD=$(cat $TEMP_DIR/initial_root_password | grep -oP 'Password: \K.*')

echo "Username: root"
echo "Password: $PASSWORD"