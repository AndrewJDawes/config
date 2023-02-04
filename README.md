# config
## Use
### Getting started
Clone the remote repo as a bare repo into a subdirectory of your home directory
```
git clone --bare git@github.com:AndrewJDawes/config.git $HOME/.cfg
```
Copy/paste the following init script to set up githooks and checkout the repo
```
git --git-dir=$HOME/.cfg --work-tree=$HOME "$@" >/dev/null config core.hooksPath "$HOME/.cfg_scripts/.githooks"
git --git-dir=$HOME/.cfg --work-tree=$HOME "$@" >/dev/null checkout
```
This might fail because by checking out you would be overwriting existing dotfiles in your home directory
- Back these up and remove them
- Then, try running the above init script again

Open a new terminal window to begin using the `config` alias, or source your rc file to define it:
```
source ~/.bashrc
```
### Add new files to repo
Check to see whether your .gitignore allows this file to be added to the git index:
```
# Does file show as untracked?
config status
# If not, check your .gitignore
vim ~/.gitignore
```
Proceed to add the file using the `config` alias:
```
config add .vimrc
config commit -m "Added .vimrc"
```
Push your changes to the remote
```
config push
```
## Create your own Dotfiles repo
### Tutorial
https://www.atlassian.com/git/tutorials/dotfiles
### Overview
- Create a bare git index and define an alias which points this git index's working tree to your home directory.
```
git init --bare $HOME/.cfg
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc && source $HOME/.bashrc
```
- Create a GitHub repo.
- Add that GitHub repo as a remote of your `config` index - use the `config` alias instead of `git`.
```
config remote add origin git@github.com:AndrewJDawes/config.git
```
- Push to the GitHub repo
```
config push -u origin main
```
### Troubleshooting
#### Make sure your .bash_profile sources .bashrc
* .bash_profile is sourced on login shells
	* These are the types of shells that the Terminal program opens by default
* .bashrc is only sourced for non-login shells
	* These are the types of shells that you get when you explicitly open bash from a login shell
	* For example, .bashrc would be sourced if you ran "bash" from a login shell
