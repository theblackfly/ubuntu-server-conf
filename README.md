# Blackfly's Ubuntu Server Configuration

## Setup

### Install dependencies

```bash
sudo apt-get install python3 python3-pip python-is-python3
sudo apt-get install neovim
sudo apt-get install ranger
sudo apt-get install bat
sudo apt-get install fzf
```

```bash
pip install virtualenvwrapper
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
cd $HOME && git reset master
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
