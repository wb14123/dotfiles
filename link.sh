#!/bin/sh

check_link() {
	LINK=`pwd`/$1
	TARGET=~/$2
	if [ -h $TARGET ] ; then
		echo -n "remove symbolic link: "
		rm -v $TARGET
	elif [ -e $TARGET ] ; then
		echo -n "move: "
		mv -v $TARGET $TARGET.old
	fi
	echo -n "link: "
	ln -sv $LINK $TARGET
}

git submodule init && git submodule update
check_link zsh/zshrc       .zshrc
check_link vim/vim         .vim
check_link vim/vimrc       .vimrc
check_link git/gitconfig   .gitconfig
check_link xprofile        .xprofile
check_link openbox         .config/openbox
check_link tmux.conf       .tmux.conf
check_link awesome         .config/awesome
check_link Xresources      .Xresources
echo "reconfig xterm" && xrdb ~/.Xresources
