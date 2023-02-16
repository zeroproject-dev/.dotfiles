#!/usr/bin/env bash

if [ x"$@" = x"shutdown" ]
then
  shutdown now
fi

if [ x"$@" = x"reboot" ]
then
  reboot now
fi

if [ x"$@" = x"logout" ]
then
  kill -9 -1
fi

echo "reboot"
echo "shutdown"
echo "logout"
