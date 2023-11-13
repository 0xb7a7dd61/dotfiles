## My Personal Neovim Setup

### Requirements
For markdown preview we need `deno` (MacOS install):
```
curl -fsSL https://deno.land/x/install/install.sh | sh
```
For Oil we need the `trash-put` command (MacOS install, requires python3's pip):
```
pipx install trash-cli
```
For solidity lsp we need to install the nomic vscode lsp globally:
```
npm install @nomicfoundation/solidity-language-server -g
```
```
brew install ripgrep
brew install fd
brew install lazygit
brew install tmux
brew install fzf
```

### Installation
```
cd nvim
cp -R . ~/.config/
```

### Optional
I like FiraCode font (MacOS install):
```
cd ~/Library/Fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/Light/FiraCodeNerdFont-Light.ttf
```
NOTE: Don't forget to select the font in the terminal app!
For Warp:
Warp | Settings...Settings | Appearance | Scroll to Text | Click
'View all available system fonts' | 'Select FiraCode Nerd Font'

For yabai:
```
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
yabai --start-service
skhd --start-service
```
