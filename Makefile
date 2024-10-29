.PHONY: default additional-arch additional-arch-system additional-brew additional-pacman git gpg install terminal update upgrade vim zsh
# .SILENT:

CURDIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
TARGETDIR := $$HOME

default: install

additional-arch:
	@echo '>> arch'
	ln -nfs "$(CURDIR)/additional/arch/fuzzel" "$(TARGETDIR)/.config/fuzzel"
	ln -nfs "$(CURDIR)/additional/arch/mako" "$(TARGETDIR)/.config/mako"
	ln -nfs "$(CURDIR)/additional/arch/sway" "$(TARGETDIR)/.config/sway"
	ln -nfs "$(CURDIR)/additional/arch/swaylock" "$(TARGETDIR)/.config/swaylock"
	ln -nfs "$(CURDIR)/additional/arch/swappy" "$(TARGETDIR)/.config/swappy"
	ln -nfs "$(CURDIR)/additional/arch/waybar" "$(TARGETDIR)/.config/waybar"
	ln -nfs "$(CURDIR)/additional/arch/etc/systemd/logind.conf.d" "$(TARGETDIR)/.config/waybar"
	@echo 'Try running "pacman -Syu $(< ./additional/arch/packages-repository.txt)"'

additional-arch-system:
	@echo '>> arch (system)'
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
	@echo 'Link alacritty'
	mkdir -p "$(TARGETDIR)/.config/alacritty"
	ln -fs "$(CURDIR)/terminal/alacritty/alacritty.toml" "$(TARGETDIR)/.config/alacritty/alacritty.toml"
	ln -fs "$(CURDIR)/terminal/alacritty/color-base16-ocean.toml" "$(TARGETDIR)/.config/alacritty/color-base16-ocean.toml"
	ln -fs "$(CURDIR)/terminal/alacritty/color-catpuccin-mocha.toml" "$(TARGETDIR)/.config/alacritty/color-catpuccin-mocha.toml"
	ln -fs "$(CURDIR)/terminal/alacritty/color-nord.toml" "$(TARGETDIR)/.config/alacritty/color-nord.toml"
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
	@echo 'Please refer to https://github.com/haroun/kickstart.nvim'

zsh:
	@echo '>> zsh'
	@echo 'Link .zshrc'
	ln -fs "$(CURDIR)/zsh/.zshenv" "$(TARGETDIR)/.zshenv"
	ln -fs "$(CURDIR)/zsh/.zshrc" "$(TARGETDIR)/.zshrc"
	ln -nfs "$(CURDIR)/zsh/modules" "$(TARGETDIR)/.zshmodules"
