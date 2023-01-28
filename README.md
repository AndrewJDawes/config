# config
## Use
### Getting started
Define the `config` alias is your current shell session
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```
Clone the remote repo as a bare repo into a subdirectory of your local home repo
```
git clone --bare git@github.com:AndrewJDawes/config.git $HOME/.cfg
```
Checkout the repo using the `config` alias you defined earlier
```
config checkout
```
This might fail because by checking out you would be overwriting existing dotfiles in your home directory
- Back these up and remove them
- Then, run `config checkout` again
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
