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

fetch_vim_bundle() {
        mkdir vim/vim/autoload
        curl -LSso vim/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
        mkdir vim/vim/bundle
	cd vim/vim/bundle
	for bundle in `cat ../../bundles`; do
		git clone $bundle
	done
	cd ../../..
}

fetch_vim_bundle
check_link zsh/zshrc         .zshrc
check_link vim/vim           .vim
check_link vim/vimrc         .vimrc
check_link git/gitconfig     .gitconfig
check_link git/global_ignore .global_ignore
check_link tmux.conf         .tmux.conf
# mysql config, see https://github.com/nitso/colour-mysql-console
check_link mysql/grcat       .grcat
check_link mysql/my.cnf      .my.cnf
