PWD := $(shell pwd)

yabai_uninstall:
	# remove service file
	yabai --uninstall-service

	# uninstall the scripting addition
	sudo yabai --uninstall-sa

	# uninstall yabai
	# brew uninstall yabai
	
	# these are logfiles that may be created when running yabai as a service.
	rm -rf /tmp/yabai_$USER.out.log
	rm -rf /tmp/yabai_$USER.err.log
	
	# remove config and various temporary files
	# rm ~/.yabairc
	rm ~/.config/yabai/yabairc
	# rm /tmp/yabai_$USER.lock
	# rm /tmp/yabai_$USER.socket
	# rm /tmp/yabai-sa_$USER.socket
	rm /tmp/yabai*
	
	# unload the scripting addition by forcing a restart of Dock.app
	killall Dock

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
	# cp $(PWD)/yabai/yabairc ~/.yabairc

	@echo Copying skhd dotfiles...
	mkdir -p ~/.config/skhd
	cp -R $(PWD)/skhd/* ~/.config/skhd

	@echo Copying wezterm dotfiles...
	cp $(PWD)/wezterm/.wezterm.lua ~/

	@echo Copying zsh dotfiles...
	cp $(PWD)/zsh/.zshrc ~/

	@echo Grabbing installed lazy-lock.json...
	cp ~/.config/nvim/lazy-lock.json $(PWD)/nvim/lazy-lock.json

.PHONY:	setup
