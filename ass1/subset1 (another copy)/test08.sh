#!/bin/sh

.shrug-init; echo 1 >a; echo 2 >b; echo 3 >c; .shrug-add a; .shrug-commit; .shrug-log; .shrug-show :a