#!/bin/sh

./shrug-init; echo hello >>a; echo world >>b; echo A >>c; ./shrug-add a; ./shrug-commit; ./shrug-add b c; ./shrug-commit -m first; ./shrug-log; ./shrug-show 1:a; rm -rf .shrug