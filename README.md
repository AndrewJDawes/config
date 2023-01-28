* Tutorial
	* https://www.atlassian.com/git/tutorials/dotfiles
* Make sure your .bash_profile sources .bashrc
	* Explanation
		* .bash_profile is sourced on login shells
			* These are the types of shells that the Terminal program opens by default
		* .bashrc is only sourced for non-login shells
			* These are the types of shells that you get when you explicitly open bash from a login shell
			* For example, .bashrc would be sourced if you ran "bash" from a login shell
	* Specific command (alias) required for this to work
```
alias config='/usr/bin/git --git-dir=/Users/Andrew/.cfg/ --work-tree=/Users/Andrew'
```
* Run these commands, or download via curl and pipe through bash to automatically execute them
	* Raw commands
```
git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```
* curl -> bash
```
curl -Lks http://bit.do/cfg-init | /bin/bash
```
* Add files to repo
```
config add .vimrc
config commit -m "Added .vimrc"
```
* Create GitHub repo and set as remote
```
config remote add origin git@github.com:AndrewJDawes/config.git
```
* Push to the GitHub repo and set a new branch (usually "master") as upstream
```
config push -u origin master
```
* Cloning to another machine
	* Define the "config" alias (can just be for the current shell session) so you can use it to checkout the bare repo later
```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

* Create a .gitignore in the home directory (where all your dotfiles are saved)
    * Tell it to ignore the folder where you will clone the bare repo to

```
echo "/.cfg" >> .gitignore
```
* Clone the remote repo as a bare repo into a subdirectory of your local home repo
    * Should be the same name as what you added to the .gitignore file above
```
git clone --bare git@github.com:AndrewJDawes/config.git $HOME/.cfg
```
* Checkout the repo (using the "config" alias you defined earlier)
```
config checkout
```
* This might fail because by checking out you would be overwriting existing dotfiles in your home directory
    * Back these up and remove them
    * Then, run config checkout again
* Tell your local version of the bare repository to ignore untracked files
```
config config --local status.showUntrackedFiles no
```
