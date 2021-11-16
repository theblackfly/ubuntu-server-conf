# Blackfly's Ubuntu Server Configuration

## Setup

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
