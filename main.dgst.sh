#! /usr/bin/env bash
cat main.lua | openssl dgst -sha256 -hmac 'key' | cut -d ' ' -f2
