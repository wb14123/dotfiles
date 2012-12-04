#!/bin/sh

check_link() {
	LINK=`pwd`/$1
	TARGET=~/$2
	if [ -e $TARGET ] ; then
		echo -n "move: "
		mv -v $TARGET $TARGET.old
	fi
	echo -n "link: "
	ln -sv $LINK $TARGET
}

check_link zsh/oh-my-zsh   .oh-my-zsh
check_link zsh/zshrc       .zshrc
check_link vim/vim         .vim
check_link vim/vimrc       .vimrc
check_link git/gitconfig   .gitconfig
check_link xprofile        .xprofile
