#!/bin/sh

./shrug-init; echo 1 >a;echo hello >>a; ./shrug-add a; ./shrug-commit -m first; ./shrug-log;./shrug-show 0:a; rm -rf .shrug