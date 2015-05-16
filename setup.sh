#!/bin/bash

config_tmux(){
	rm -rf ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	cp "$DIR/tmux/tmux.conf" ~/.tmux.conf
}
config_git(){
	cp "$DIR/git/gitconfig" ~/.gitconfig
}
config_bash(){
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt.sh
	cp "$DIR/bash/bashrc" ~/.bashrc
	cp "$DIR/bash/bash_profile" ~/.bash_profile
}

config_neovim(){
	rm -rf ~/.nvim
	curl -fLo ~/.nvim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	cp "$DIR/neovim/nvimrc" ~/.nvimrc
}

main(){
	set +e
	set -o pipefail
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	config_bash
	config_git
	config_tmux
  config_neovim
}
main "$@"
