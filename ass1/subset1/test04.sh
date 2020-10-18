#!/bin/sh

./shrug-init; echo hello >a; echo world >b; echo A >c; ./shrug-add a; ./shrug-commit -m first; ./shrug-add b c; ./shrug-commit -m second; ./shrug-log; ./shrug-show 1:c; rm -rf .shrug;./shrug-show 1:c