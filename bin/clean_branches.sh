#!/bin/sh
git remote prune origin | grep prune | sed -e 's#.*origin/##g' | xargs -I% -n1 git branch -d %
