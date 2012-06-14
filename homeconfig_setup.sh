#!/bin/bash

PUB_KEY=~/.ssh/id_rsa.pub
GITHUB_USER=Dr0m0k
GITHUB_REP=homeconfig
GIT_FOLDER=".$GITHUB_REP.git"


error_exit() {
  echo $1 1>&2
  exit 1
}

which git 1>/dev/null || error_exit "Installed git required!!!"
echo "Testing connection to github..." 1>&2

if ! ssh -T git@github.com 2>&1 | grep "^Hi $GITHUB_USER" > /dev/null; then #dirty hack ;)
  if [ ! -e $PUB_KEY ]; then
    echo -n "Enter comment which will be used to identify key: " 1>&2
    read COMM || error_exit "Can't read comment!!"
    echo "Creating ssh keys..." 1>&2
    ssh-keygen -t rsa -C"$COMM" || error_exit "Fail to generate pub key"
  fi
  echo "Copy pub key to https://github.com/settings/ssh" 1>&2
  cat  $PUB_KEY 
fi 

[ -e "~/$GIT_FOLDER" ] && error_exit "Repository already checkout!!!"
REP_TMP="$(mktemp -d)"
pushd $REP_TMP
echo "Repository checkout..." 1>&2
git clone "git@github.com:$GITHUB_USER/$GITHUB_REP" .
#remove this script
find . -name "'$(basename $0)'" -delete
#move git dir
mv ".git" "$GIT_FOLDER"

#get list of files  that already exists in home
BAK_FILES="$( find . -mindepth 1 -depth -exec sh -c "[ -e '$HOME/{}' ] && echo '{}'" \; )"
BAK_AR="$HOME/.$GITHUB_REP.bak"
[ -e "$BAK_AR" ] && error_exit "Backup '$BAK_AR' already exist!!!"

cpio -oF "$BAK_AR" <<<"$BAK_FILES" || error_exit "Fail to create backup archive"
echo ======================================
echo This files was copied to  "BAK_AR"
echo "$BAK_FILES"
echo ======================================
echo "Copy repository files"
find . -depth | cpio -pamvdu ~/
popd


