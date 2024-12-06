#!/bin/bash


# Try something like this ...
# ./blah.sh 'a[$(./inj.sh)]' 2


if [[ "$1" -lt "$2" ]]; then
    echo hello
else
    echo world
fi


echo $PATH
echo $PWD
pwd

uname -a
