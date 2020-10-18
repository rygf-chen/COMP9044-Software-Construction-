#!/bin/sh

./shrug-init; echo hello >a; echo world >b; echo WoW! >c;./shrug-add a b c; ./shrug-commit -m xx; ./shrug-log; ./shrug-show 0:a; ./shrug-show 0:b; ./shrug-show 0:c; rm -rf .shrug