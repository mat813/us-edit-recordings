#!/usr/bin/env bash

while :
do
  if [ script.coffee -nt script.user.js ]
  then
    sed -ne '/==UserScript==/,/==\/UserScript==/s/^#/\/\//p' script.coffee > script.user.js
    coffee -pc script.coffee >> script.user.js
  else
    sleep 1
  fi
done
