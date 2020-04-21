#!/bin/bash

# Required environment variables
if [[ -z ${SSH_PRIVKEY}  ]]; then
  echo "Environment variable SSH_PRIVKEY must be set"
  exit 1
fi

echo "Configuring SSH credentials"
eval `ssh-agent`
ssh-add - <<< "${SSH_PRIVKEY}"
