#! /bin/bash

set -e

npm run build
TARGET_DIR="/www/wwwroot/thoughost.com"
rm -rf $TARGET_DIR/*
cp -r dist/* $TARGET_DIR

echo "Deployed to $TARGET_DIR"