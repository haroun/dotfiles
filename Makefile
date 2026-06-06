.PHONY: default additional-arch additional-arch-system additional-brew additional-pacman git gpg install terminal update upgrade vim zsh
# .SILENT:

CURDIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGETDIR := $$HOME

default: install

additional-arch:
	@echo '>> arch'
	ln -nfs "$(CURDIR)/additional/arch/fuzzel" "$(TARGETDIR)/.config/fuzzel"
	ln -nfs "$(CURDIR)/additional/arch/gtk-3.0" "$(TARGETDIR)/.config/gtk-3.0"
	ln -nfs "$(CURDIR)/additional/arch/mako" "$(TARGETDIR)/.config/mako"
	ln -nfs "$(CURDIR)/additional/arch/swappy" "$(TARGETDIR)/.config/swappy"
	ln -nfs "$(CURDIR)/additional/arch/sway" "$(TARGETDIR)/.config/sway"
	ln -nfs "$(CURDIR)/additional/arch/swaylock" "$(TARGETDIR)/.config/swaylock"
	ln -nfs "$(CURDIR)/additional/arch/Thunar" "$(TARGETDIR)/.config/Thunar"
	ln -nfs "$(CURDIR)/additional/arch/waybar" "$(TARGETDIR)/.config/waybar"
	@echo 'Try running "pacman -Syu $$(< ./additional/arch/packages-repository.txt)"'

additional-arch-system:
	@echo '>> arch (system)'
	sudo rsync -a --chown=root:root "$(CURDIR)/additional/arch/etc/greetd/" /etc/greetd/
	sudo rsync -a --chown=root:root "$(CURDIR)/additional/arch/etc/systemd/" /etc/systemd/

additional-brew:
	@echo '>> homebrew'
	brew update && brew upgrade && brew upgrade --cask

additional-pacman:
	@echo '>> pacman'
	sudo pacman -Syu
	yay -Sua

git:
	@echo '>> git'
	@echo 'Link .gitconfig, .gitconfig.user & .gitignore'
	ln -fs "$(CURDIR)/git/.gitconfig" "$(TARGETDIR)/.gitconfig"
	ln -fs "$(CURDIR)/git/.gitconfig.user" "$(TARGETDIR)/.gitconfig.user"
	ln -fs "$(CURDIR)/git/.gitignore" "$(TARGETDIR)/.gitignore"

gpg:
	@echo '>> gpg'
	@echo 'Link gpg-agent.conf'
	mkdir -p "$(TARGETDIR)/.gnupg"
	ln -fs "$(CURDIR)/gpg/gpg-agent.conf" "$(TARGETDIR)/.gnupg/gpg-agent.conf"
	ln -fs "$(CURDIR)/gpg/gpg.conf" "$(TARGETDIR)/.gnupg/gpg.conf"
	find "$(TARGETDIR)/.gnupg" -type f -exec chmod 600 {} \;
	find "$(TARGETDIR)/.gnupg" -type d -exec chmod 700 {} \;

install:
	@echo '> install'
	git submodule init && git submodule update && git submodule foreach "git checkout main || git checkout master || git checkout develop"
	make git
	make gpg
	make zsh
	make terminal
	make vim

terminal:
	@echo '>> terminal'
	mkdir -p "$(TARGETDIR)/.config"
	# @echo 'Link alacritty'
	# mkdir -p "$(TARGETDIR)/.config/alacritty"
	# ln -fs "$(CURDIR)/terminal/alacritty/alacritty.toml" "$(TARGETDIR)/.config/alacritty/alacritty.toml"
	# ln -fs "$(CURDIR)/terminal/alacritty/color-base16-ocean.toml" "$(TARGETDIR)/.config/alacritty/color-base16-ocean.toml"
	# ln -fs "$(CURDIR)/terminal/alacritty/color-catpuccin-mocha.toml" "$(TARGETDIR)/.config/alacritty/color-catpuccin-mocha.toml"
	# ln -fs "$(CURDIR)/terminal/alacritty/color-nord.toml" "$(TARGETDIR)/.config/alacritty/color-nord.toml"
	@echo 'Link tmux'
	ln -fs "$(CURDIR)/terminal/tmux/.tmux.conf" "$(TARGETDIR)/.tmux.conf"
	@echo 'Link dircolors'
	ln -fsr "$(CURDIR)/terminal/dircolors/arcticicestudio/nord-dircolors/src/dir_colors" "$(TARGETDIR)/.dir_colors"
	@echo 'Link bat'
	ln -nfs "$(CURDIR)/bat" "$(TARGETDIR)/.config/bat"
	@echo "Put your themes in '$(TARGETDIR)/.config/bat' and run 'bat cache --build' to rebuild cache"

update:
	@echo '>> update'
	git pull
	@echo 'dependencies'
	git submodule update --init

upgrade:
	@echo '>> upgrade'
	git pull
	@echo 'dependencies'
	git submodule foreach 'git checkout $$(git symbolic-ref --short HEAD) && git pull'

vim:
	@echo '>> vim'
	ln -nfs "$(CURDIR)/nvim-0.12" "$(TARGETDIR)/.config/nvim"
	ln -nfs "$(CURDIR)/nvim-0.12" "$(TARGETDIR)/.config/nvim-0.12"
	ln -nfs "$(CURDIR)/nvim-0.11" "$(TARGETDIR)/.config/nvim-0.11"
	@echo 'NVIM_APPNAME=nvim-0.12 nvim to run a specific config of neovim'
	@echo 'install LSPs'
	npm install -g @astrojs/language-server
	# cf. https://github.com/denoland/deno#installation
	npm install -g diagnostic-languageserver
	go install github.com/docker/docker-language-server/cmd/docker-language-server@latest
	# cf. https://github.com/elixir-lsp/elixir-ls#building-and-running
	npm install -g vscode-langservers-extracted
	cargo install gitlab-ci-ls
	npm install -g vscode-langservers-extracted
	npm install -g vscode-langservers-extracted
	# cf. https://luals.github.io/#neovim-install
	cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide
	npm install -g @stylelint/language-server
	npm install -g svelte-language-server
	npm install -g @tailwindcss/language-server
	# cf. https://github.com/hashicorp/terraform-ls/blob/main/docs/installation.md
	npm install -g typescript typescript-language-server
	npm install -g yaml-language-server
	@echo 'install telescope fzf'
	cd ~/.local/share/nvim/site/pack/core/opt/telescope-fzf-native.nvim && make && cd -

zsh:
	@echo '>> zsh'
	@echo 'Link .zshrc'
	ln -fs "$(CURDIR)/zsh/.zshenv" "$(TARGETDIR)/.zshenv"
	ln -fs "$(CURDIR)/zsh/.zshrc" "$(TARGETDIR)/.zshrc"
	ln -nfs "$(CURDIR)/zsh/modules" "$(TARGETDIR)/.zshmodules"
