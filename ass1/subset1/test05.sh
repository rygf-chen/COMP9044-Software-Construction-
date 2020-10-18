#!/bin/sh

./shrug-init;echo hello >a; echo 1 >b; ./shrug-add a b; ./shrug-commit -m first; ./shrug-show 0:a; echo world >>a; ./shrug-add a; ./shrug-commit -m second; ./shrug-show 1:a  