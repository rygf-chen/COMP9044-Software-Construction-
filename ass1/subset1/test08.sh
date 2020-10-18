#!/bin/sh

./shrug-init; echo 1 >a; echo 2 >b; echo 3 >c; ./shrug-add a; ./shrug-commit -m first; ./shrug-show 0:a; ./shrug-add b c; ./shrug-commit -m second; ./shrug-show 1:b; rm -rf .shrug