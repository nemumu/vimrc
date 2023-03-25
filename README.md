# .vimrc
This is my .vimrc

## Supporting OS/dist
- macOS Catalina
- Ubuntu 18.04
- Ubuntu 20.04

## Installation
```bash
git clone git://github.com/nemumu/vimrc.git

# Vim
cp vimrc/.vimrc ~/

# Neovim
cp vimrc/init.vim ~/.config/nvim/init.vim
```

### Ubuntu
#### vim
```bash
sudo apt install mypy flake8 vim-python-jedi
```

#### Neovim
```bash
pip3 install pyright "python-lsp-server[all]" python-lsp-black pyls-isort

# Install latest Node.js (https://github.com/nodesource/distributions)
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
sudo apt-get install -y nodejs npm ripgrep

npm i -g vscode-langservers-extracted
npm i -g @ansible/ansible-language-server
npm i -g bash-language-server
```
