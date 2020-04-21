#!/bin/bash

# Required environment variables
if [[ -z ${SSH_AUTH_SOCK_DIR} ]]; then
  printf >&2 "Environment variable SSH_AUTH_SOCK must be set\n"
  exit 1
fi

if [[ -z ${SSH_PRIVKEY} ]]; then
  printf >&2 "Environment variable SSH_PRIVKEY must be set\n"
  exit 1
fi

printf "Starting ssh-agent\n"
eval $(ssh-agent -a ${SSH_AUTH_SOCK_DIR})

printf "Adding ssh private key\n"
ssh-add - <<<"${SSH_PRIVKEY}"

printf "Listing adding keys\n"
ssh-add -L
