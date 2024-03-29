#!/bin/bash

set -e

TEMP_DIR=$(mktemp -d)

PWD=$(pwd)

# cd to ./terraform dir and run terraform init

cd $PWD/terraform

terraform init > /dev/null 2>&1

terraform apply -auto-approve > /dev/null 2>&1

terraform output -json > $TEMP_DIR/terraform-output.json

# cd to ./ansible dir and run ansible-playbook

