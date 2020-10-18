#!/bin/sh

./shrug-init;echo 1 >a; ./shrug-add a; ./shrug-commit -m first; ./shrug-log; ./shrug-show :a; rm -rf .shrug