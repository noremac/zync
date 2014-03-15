
ZYNC_PATH=~/Dropbox/my-zync-folder
ZYNC_THEME=my-theme

ZYNC_PLUGINS=(
base
git
my-fancy-plugin
$HOME/randomPlace/aliases.zsh # full path to a file that is outside of the ZYNC_PATH/plugins directory.
)

source ~/Dropbox/zync/zync.zsh
