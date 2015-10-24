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

setup_go(){
	if which go > /dev/null; then
		echo -e "${yellow}INSTALL${end_color} ${bold}golang${normal} dependencies..."
		gopackages="\
		github.com/golang/lint/golint \
		github.com/jstemmer/gotags \
		github.com/kisielk/errcheck \
		github.com/nsf/gocode \
		golang.org/x/tools/cmd/godoc \
		golang.org/x/tools/cmd/goimports \
		golang.org/x/tools/cmd/gorename \
		golang.org/x/tools/cmd/oracle \
		golang.org/x/tools/cmd/vet \
		"

		for p in $gopackages; do
			echo -e "\t${yellow}INSTALL${end_color} ${bold}${p}${normal}..."
			go get -f -u $p
			echo -e "\t${green}DONE${end_color}    ${bold}${p}${normal}"
		done
		echo -e "${green}DONE${end_color}    ${bold}golang${normal} dependencies"
	fi
}

main(){
	set +e
	set -o pipefail
	DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	setup_go
	config_bash
	config_git
	config_tmux
	config_neovim
}
main "$@"
