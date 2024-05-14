#!/usr/bin/env bash

set -euo pipefail

if [ $# -lt 2 ]; then
  echo "Usage: decrypt.sh <encrypted.txt> <password>"
  exit 1
fi

filename="$1"
password="$2"

tail -n +2 "$filename" \
  | base64 --decode \
  | openssl enc -d -aes-256-cbc -pbkdf2 -salt -in - -out - -k "$password"
