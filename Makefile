PWD := $(shell pwd)

setup:
	@echo Copying nvim dotfiles...
	mkdir -p ~/.config/nvim
	cp -R $(PWD)/nvim/* ~/.config/nvim

	@echo Copying tmux dotfiles...
	cp $(PWD)/tmux/.tmux.conf ~/
	cp $(PWD)/tmux/tmux-sessionizer ~/.local/bin/
	cp $(PWD)/tmux/tmux-windowizer ~/.local/bin/

	@echo Copying yabai dotfiles...
	mkdir -p ~/.config/yabai
	cp -R $(PWD)/yabai/* ~/.config/yabai

	@echo Copying skhd dotfiles...
	mkdir -p ~/.config/skhd
	cp -R $(PWD)/skhd/* ~/.config/skhd

	@echo Copying wezterm dotfiles...
	cp $(PWD)/wezterm/.wezterm.lua ~/

.PHONY:	setup
