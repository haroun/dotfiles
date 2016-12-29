#!/bin/sh
# https://help.github.com/articles/changing-author-info/

git filter-branch --env-filter '
OLD_EMAIL="harouna@pc23.home"
CORRECT_NAME="Harouna Traoré"
CORRECT_EMAIL="h.traore@me.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
