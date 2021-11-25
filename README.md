# Blackfly's Ubuntu Server Configuration

## Setup

### Install dependencies

```bash
sudo apt-get install python3 python3-pip python-is-python3
sudo apt-get install neovim
sudo apt-get install fzf
```

```bash
pip install virtualenvwrapper
```

### Install optional life-improvements

```bash
sudo apt-get install ranger
sudo apt-get install bat
```

```bash
sudo apt-get install ruby
gem install tmuxinator
sudo apt-get install wget
sudo wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O /usr/share/zsh/site-functions/_tmuxinator
```

### Emacs/Doom-Emacs

```bash
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt-get update
sudo apt-get remove emacs
sudo apt-get autoremove
sudo apt-get install emacs27

sudo apt-get install fd-find
sudo apt-get install ripgrep

git clone -b develop https://github.com/hlissner/doom-emacs ~/.local/src/doom-emacs
$HOME/.local/src/doom-emacs/bin/doom install

git clone https://github.com/plexus/chemacs.git ~/.local/src/chemacs
sh ~/.local/src/chemacs/install.sh

mkdir -p ~/.config/emacs
touch ~/.config/emacs/init.el

echo -e \
'(("default" . ((user-emacs-directory . "~/.local/src/doom-emacs")))
  ("vanilla" . ((user-emacs-directory . "~/.config/emacs"))))
' > ~/.emacs-profiles.el
```

### Configure git

```bash
git config --global user.name "Jensun Ravichandran"
git config --global user.email "jjensun@gmail.com"
git config --global init.defaultBranch master
git config --global pull.rebase false
```

### Clone the configuration repository and deploy dotfiles

```bash
git clone --no-checkout https://github.com/theblackfly/ubuntu-server-conf.git $HOME/ubuntu-server-conf

cd $HOME/ubuntu-server-conf && git config core.worktree "$HOME"
cd $HOME && echo "gitdir: $HOME/ubuntu-server-conf/.git" > .git
cd $HOME && git reset --hard master
```

## Tips and Tricks

1. [bat](https://github.com/sharkdp/bat) is `cat` clone with syntax highlighting
   and git integration. Next time, try using `batcat <filename>` instead of `cat
   <filename>`.

## Update

To update the dotfiles, simply run:

```bash
cd $HOME && git pull
```
