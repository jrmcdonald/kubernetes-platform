#!/bin/sh
VAULT_PW_FILENAME=".vault-pass"
gpg --quiet --batch --use-agent --decrypt --armor $VAULT_PW_FILENAME
