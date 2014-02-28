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
check_link zsh/zshrc         .zshrc
check_link vim/vim           .vim
check_link vim/vimrc         .vimrc
check_link git/gitconfig     .gitconfig
check_link git/global_ignore .global_ignore
check_link tmux.conf         .tmux.conf
# mysql config, see https://github.com/nitso/colour-mysql-console
check_link mysql/grcat       .grcat
check_link mysql/my.cnf      .my.cnf
