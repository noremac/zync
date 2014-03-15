#
# zync.sh
#

_ZYNC_BASE_PATH=$(dirname $0)

ZYNC_LOG_LEVEL_NONE=
ZYNC_LOG_LEVEL_INFO=1
ZYNC_LOG_LEVEL_DEBUG=2

function _zync_log
{
    local logMessage=$1
    local logLevel=$2

    if [[ -z $logLevel ]]
    then
        logLevel=$ZYNC_LOG_LEVEL_INFO
    fi

    if [[ $logLevel -le $ZYNC_LOG_LEVEL ]]
    then
        echo $1
    fi
}

function _zync_error
{
    local message=$1
    echo "$message" >&2
}

if [[ -z "$ZYNC_PATH" ]]
then
    _zync_error "Please define a ZYNC_PATH"
    _ZYNC_INTERNAL_INCONSISTENCY_STATE=$_ZYNC_INTERAL_INCONSISTENCY_ERROR
else
    _ZYNC_PLUGIN_PATH=$ZYNC_PATH/plugins
    _ZYNC_THEME_PATH=$ZYNC_PATH/themes
fi

function _zync_plugin
{
    local plugin=$1
    local pluginName=
    local pluginPath=

    if [[ -f $plugin ]]
    then
        # this is just a straight file
        pluginName=`basename $plugin`
        pluginPath=$plugin
    else
        # assume it's a folder in the plugin directory
        pluginName=$plugin
        pluginPath=$_ZYNC_PLUGIN_PATH/$plugin/$plugin.plugin.zsh

        if [[ ! -f $pluginPath ]]
        then
            # try it as a flat file in the plugins directory
            pluginPath=$_ZYNC_PLUGIN_PATH/$plugin.plugin.zsh
        fi

        if [[ ! -e $pluginPath ]]
        then
            _zync_error "$plugin is not a valid plugin bundle"
            pluginName=
            pluginPath=
        fi
    fi

    if [[ -n "$pluginName" ]] && [[ -n "$pluginPath" ]]
    then
        _zync_log "loading $pluginName" ZYNC_LOG_LEVEL_INFO
        source $pluginPath
        return 0
    else
        return 1
    fi
}

_ZYNC_ERROR=

# load the plugins if specified
if [[ -n "$ZYNC_PLUGINS" ]]
then
    for plugin in $ZYNC_PLUGINS
    do
        if ! _zync_plugin $plugin
        then
            _ZYNC_CONTINUE_LOADING=
            _zync_error "Should zync continue trying to load plugins? (y/n)"
            read _ZYNC_CONTINUE_LOADING

            case "$_ZYNC_CONTINUE_LOADING" in
                [yY][eE][sS]|[yY])
                    _zync_error "Continuing..."
                    ;;
                *)
                    _ZYNC_ERROR="yes"
                    break
                    ;;
            esac
        fi
    done
fi

# load the theme if specified
if [[ -n "$ZYNC_THEME" ]]
then
    # load the theme if one is defined and there were no previous errors
    if [[ "$_ZYNC_ERROR" = "yes" ]]
    then
        _zync_error "zync is not loading the theme due to previous errors"
    else
        _zync_log "loading theme $ZYNC_THEME" ZYNC_LOG_LEVEL_INFO
        source $_ZYNC_THEME_PATH/$ZYNC_THEME.theme.zsh
    fi
fi

