## What are Dotfiles?

If you're not familiar with the concept of dotfiles, check out Github's dotfiles page to learn more about them. Essentially, when someone says "dotfiles" they mean maintaining your command-line preferences in a Git repository (sort of like how I use Dropbox to manage my preference files for TextExpander, etc.) that you install on every computer.

The name dotfiles refers to the fact that most of the files that perform this sort of configuration start with a dot. The Zsh configuration file, for example, is `.zshrc` The SSH configuration folder is `.ssh` And so on. So the concept of "dotfiles" just means "versioning your configuration files."

Your dotfiles will help you create powerful and consistent shell shortcuts and functions, settings for your editors, color coding and layouts for your shell, preferences and authentication for ssh and mysql and other protocols, and more.

## Superhero Dotfiles and Their Super Powers

Dotfiles are split into two main types. Those that contain a set of commands and only run once, .osx for example runs a list of commands and gives OS X super powers. Other files such as .bash_profile and .bashrc run each time you open a new Terminal session and gives your Terminal super powers.

Here's a run down of the dotfiles in my repo and a description of what they can do.

### .bash_profile / .bashrc

When you open a new Terminal session, this file is loaded by Bash. It loads in the other dotfiles `path,bash_prompt,exports,aliases,functions,extra` and configures some useful settings such as auto correcting typos when using cd completion.

In some instances `.bashrc` can be loaded, so this file makes sure that .bash_profile is called.

### .path

This file speeds up the process of running executable files. Rather than having to cd back and forth across various paths to executable files, you can set the file paths in your .path dotilfe and then run executable files directly.

Generally, this file isn't held in the public repo as it can contain sensitive information.

Here’s an example `~/.path` file that adds `~/utils` to the `$PATH:
export PATH="$HOME/utils:$PATH"``

### .bash_prompt

Using this file you can customise and set the various colors of your Bash prompt.

### .exports

Sets environment variables, such as setting Vim as the default editor using export `EDITOR="sublime"` It also increases the amount of history saved, useful for backtracking over previous commands you've used.

### .aliases

This file contains useful aliases to help you write less. For example, instead of typing `cd ..` you can set it here to be '..'. Starting to like these files yet?

### .functions

Similar to aliases, except functions can take arguments.

Before when I mentioned I was looking over different dotfile repos, I did mkdir to create a directory. After that, I'd then need to cd into that directory.

### .gitconfig

This file is only used by Git, for example, when a git command is invoked. So although there's an `.aliases` file, those aliases are run directly.

### .gitignore

Set files that you'd like Git to ignore on the entire system. Yay, no more `.DS_Store` being accidentally committed!

### .gvimrc

A small file that improves readability for gvim.

### .hgignore

Simliar to .gitignore for Mercurial.

### .hushlogin

In some instances, for example, when you ssh into a machine, you may be presented with a message. It might look something like this:

```                                   _
                                  | |
 _ __ ___  _   _    ___ ___   ___ | |  ___  ___ _ ____   _____ _ __
| '_ ` _ \| | | |  / __/ _ \ / _ \| | / __|/ _ \ '__\ \ / / _ \ '__|
| | | | | | |_| | | (_| (_) | (_) | | \__ \  __/ |   \ V /  __/ |
|_| |_| |_|\__, |  \___\___/ \___/|_| |___/\___|_|    \_/ \___|_|
            __/ |
           |___/
Welcome to my cool server.
Any malicious and/or unauthorized activity is strictly forbidden.
All activity may be logged.
```

This file prevents this from being shown.

### .inputrc

Configures the 'Readline environment'. This controls the way keys work when you're entering a command into your shell.
An example of how I find this useful is to make tab autocomplete regardless of filename case:

`set completion-ignore-case on`

### .osx

This is my favorite of all the dotfiles. It is run once, manually, for the commands to run and take effect. Depending on what you've added to this file, you may need to restart your machine.

Some of the awesome things I love are:

- Disable the “Are you sure you want to open this application?” dialog
- Check for software updates daily, not just once per week
- Disable Notification Center and remove the menu bar icon
- Enable access for assistive devices
- Set a blazingly fast keyboard repeat rate
- Finder: allow quitting via `⌘ + Q` doing so will also hide desktop icons
- When performing a search, search the current folder by default
- Speed up Mission Control animations

### .screenrc

If you use screen, this removes the startup message.

### .vimrc

I'm not that familiar with vim. However some of the things you can do with this file include enabling line numbers and adding syntax highlighting.

### .wgetrc

If you use wget, this adds additional settings such as changing the timeout to 60 seconds rather than the default 15 minutes. It also sets the retry to three, rather than the default 20!

## Getting Started

If you notice, some files that have mentioned above don't exist in this repo. This is because i am using the amazing [bash-it](http://github.com/ahmadassaf/bash-it) repo to organize those dotfiles. 
I recommend you head overthere and read how to use them.d

## Installing the Scripts

For installing the above files outside of the workflow mentioned in the [main configurations](http://github.com/ahmadassaf/configurations), you need to run the following command `sh install.sh`. The command will symlink all the files in this directory into your home directory, overwriting existing files.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

```bash
./.osx
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](http://brew.sh/) formulae (after installing Homebrew, of course). 
`brew bundle` has been deprecated, thus i converted the files into executable shell ones:

```bash
brew install ~/.brewfile.sh
```

you can always remove or add files based on yor preferences. You can search for brew formulas [here](http://brewformulas.org/) in order to add or get more information about the ones I am using.

### Install native apps with `brew cask`

You could also install native apps with [`brew cask`](https://github.com/phinze/homebrew-cask):

```bash
brew install ~/.caskfile.sh
```

you can always remove or add files based on yor preferences. You can search for cask formulas [here](http://caskroom.io/) in order to add or get more information about the ones I am using.

## Thanks to…

* [Execution sequence for .bash_profile, .bashrc, .bash_login, .profile and .bash_logout](http://www.thegeekstuff.com/2008/10/execution-sequence-for-bash_profile-bashrc-bash_login-profile-and-bash_logout/) 
[Setting Up a Mac Dev Machine From Zero to Hero With Dotfiles](http://code.tutsplus.com/tutorials/setting-up-a-mac-dev-machine-from-zero-to-hero-with-dotfiles--net-35449)
* [@Mathias Bynens](http://twitter.com/mathias) and his [dotfiles repository](https://github.com/mathiasbynens/dotfiles)
* @ptb and [his _OS X Lion Setup_ repository](https://github.com/ptb/Mac-OS-X-Lion-Setup)
* [Ben Alman](http://benalman.com/) and his [dotfiles repository](https://github.com/cowboy/dotfiles)
* [Chris Gerke](http://www.randomsquared.com/) and his [tutorial on creating an OS X SOE master image](http://chris-gerke.blogspot.com/2012/04/mac-osx-soe-master-image-day-7.html) + [_Insta_ repository](https://github.com/cgerke/Insta)
* [Cãtãlin Mariş](https://github.com/alrra) and his [dotfiles repository](https://github.com/alrra/dotfiles)
* [Gianni Chiappetta](http://gf3.ca/) for sharing his [amazing collection of dotfiles](https://github.com/gf3/dotfiles)
* [Jan Moesen](http://jan.moesen.nu/) and his [ancient `.bash_profile`](https://gist.github.com/1156154) + [shiny _tilde_ repository](https://github.com/janmoesen/tilde)
* [Lauri ‘Lri’ Ranta](http://lri.me/) for sharing [loads of hidden preferences](http://osxnotes.net/defaults.html)
* [Matijs Brinkhuis](http://hotfusion.nl/) and his [dotfiles repository](https://github.com/matijs/dotfiles)
* [Nicolas Gallagher](http://nicolasgallagher.com/) and his [dotfiles repository](https://github.com/necolas/dotfiles)
* [Sindre Sorhus](http://sindresorhus.com/)
* [Tom Ryder](http://blog.sanctum.geek.nz/) and his [dotfiles repository](https://github.com/tejr/dotfiles)
* [Kevin Suttle](http://kevinsuttle.com/) and his [dotfiles repository](https://github.com/kevinSuttle/dotfiles) and [OSXDefaults project](https://github.com/kevinSuttle/OSXDefaults), which aims to provide better documentation for [`~/.osx`](https://mths.be/osx)
* [Haralan Dobrev](http://hkdobrev.com/)
