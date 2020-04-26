#!/bin/bash

# Required environment variables
if [[ -z ${GPG_PUBKEY} ]]; then
  printf >&2"Environment variable GPG_PUBKEY must be set\n"
  exit 1
fi

if [[ -z ${GPG_PRIVKEY} ]]; then
  printf >&2 "Environment variable GPG_PRIVKEY must be set\n"
  exit 1
fi

printf "Configuring GPG credentials"
echo -e "${GPG_PUBKEY}" | gpg --import
echo -e "${GPG_PRIVKEY}" | gpg --import

printf "Listing imported keys\n"
gpg --list-keys

printf "Listing imported secret keys\n"
gpg --list-secret-keys
