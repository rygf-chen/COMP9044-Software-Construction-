#!/bin/sh

./shrug-init; echo 1 >a; echo 2 >b; echo 3 >c; ./shrug-add a; ./shrug-commit -m first; ./shrug-commit -m first; rm -rf .shrug