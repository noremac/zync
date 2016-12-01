# zync

zync is a minimal framework inspired by oh-my-zsh for organizing your zsh themes and plugins.

# Why zync?

Oh-my-zsh is awesome and migrating to it made me stop to reconsider how I was handling my plugins and other random dotfiles. However, after a while I found myself adding a bunch of customizations to remove certain functionality or modify it in non-standard ways that made keeping it up-to-date annoying/impossible. zync is the core foundation of what I found useful about oh-my-zsh: organizing themes and plugins.

# Setup

**TL;DR** See the example-zshrc.zsh file in this repo.

Setting up zync is easy, especially if you are familiar with oh-my-zsh. You will need to define a root zync directory by defining a `ZYNC_PATH` variable in your .zshrc. This directory is expected to contain a directory named themes, and a directory named plugins, both of which are optional.

* The themes directory should contain files of the form `my-theme.theme.zsh`.
* The contents in the plugins directory can be in two different forms. The first is a simple file: `my-git-plugin.plugin.zsh`. The second is: `my-git-plugin/my-git-plugin.plugin.zsh`.

# Configuring plugins and themes

Once you have your `ZYNC_PATH` setup and defined correctly, you will want to load your themes and plugins.

* To load a theme, define a `ZYNC_THEME` variable in your .zshrc that is the name of your theme minus the extension. For example: `ZSH_THEME=my-theme`
* To load plugins, define a `ZYNC_PLUGINS` variable in your .zshrc that is an array of your plugin names minus the extensions. For example: `ZSH_PLUGINS=(my-git-plugin my-aliases)` Additionally, instead of passing a plugin name, you may pass a path to any file and it will be sourced.

# Loading zync

Following your `ZYNC_PATH`, `ZYNC_THEME`, and `ZYNC_PLUGINS` variable definitions, simply  source the zync.zsh file: `source /path/to/zync.zsh`

