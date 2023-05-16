#!/usr/bin/env bash
set -e

bash create-terraform-storage.sh $1 inf true
bash create-terraform-storage.sh $1 app true
