#!/bin/bash

# Required environment variables
if [[ -z ${GPG_PUBKEY}  ]]; then
  echo "Environment variable GPG_PUBKEY must be set"
  exit 1
fi
  
if [[ -z ${GPG_PRIVKEY}  ]]; then
  echo "Environment variable GPG_PRIVKEY must be set"
  exit 1
fi

echo "Configuring GPG credentials"
echo -e "${GPG_PUBKEY}" | gpg --import
echo -e "${GPG_PRIVKEY}" | gpg --import
