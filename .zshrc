
########## EXPORTS #######################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export LESS="-Xr"
export BAT_THEME=TwoDark

########## ALIASES #######################

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias vim='nvim'
# alias cat='bat'

########## USER CONFIGURATION #######################

ZSH_THEME=""                    # Let starship own the prompt

DISABLE_AUTO_TITLE="true"       # Don't fight tmux window names

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Disables the "compfix" security check in Oh My Zsh.
# Useful if you are aware of your setup and want to avoid repetitive permission
# prompts, but you should only use it if you trust the security of your configuration.
ZSH_DISABLE_COMPFIX=true

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    command-not-found
    dirhistory
    docker
    dotenv
    encode64
    gcloud
    gitignore
    jsontools
    kubectl
    kubectx
    ssh
    sudo
    timer
    zsh-autosuggestions
    zsh-syntax-highlighting
)

########### PLUGIN SETTINGS #######################

### Timer Plugin Settings ####################
# Customize the appearance of the command timer plugin.
# This plugin displays the time taken to execute commands in the terminal.
TIMER_FORMAT='[%d]'
TIMER_PRECISION=2

### ZSH DotEnv Plugin Settings ####################
# You can also modify the name of the file to be loaded with the variable `ZSH_DOTENV_FILE`.
# If the variable isn't set, the plugin will default to use `.env`.
# For example, this will make the plugin look for files named `.dotenv` and load them:
# ZSH_DOTENV_FILE=.dotenv

# Set `ZSH_DOTENV_PROMPT=false` in your zshrc file if you don't want the confirmation message.
# You can also choose the `Always` option when prompted to always allow sourcing the .env file
# in that directory. See the next section for more details.
ZSH_DOTENV_PROMPT=false

# The default behavior of the plugin is to always ask whether to source a dotenv file. There's
# a **Y**es, **N**o, **A**lways and N**e**ver option. If you choose Always, the directory of the .env file
# will be added to an allowed list; if you choose Never, it will be added to a disallowed list.
# If a directory is found in either of those lists, the plugin won't ask for confirmation and will
# instead either source the .env file or proceed without action respectively.
# The allowed and disallowed lists are saved by default in `$ZSH_CACHE_DIR/dotenv-allowed.list` and
# `$ZSH_CACHE_DIR/dotenv-disallowed.list` respectively. If you want to change that location,
# change the `$ZSH_DOTENV_ALLOWED_LIST` and `$ZSH_DOTENV_DISALLOWED_LIST` variables, like so:
# ZSH_DOTENV_ALLOWED_LIST=/path/to/dotenv/allowed/list
# ZSH_DOTENV_DISALLOWED_LIST=/path/to/dotenv/disallowed/list

### ZSH Autosuggestions Highlighting Plugin Settings ####################
## https://github.com/zsh-users/zsh-autosuggestions

# Set `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE` to configure the style that the suggestion is shown
# with. The default is `fg=8`, which will set the foreground color to color 8 from the
# [256-color palette](https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg).
# If your terminal only supports 8 colors, you will need to use a number between 0 and 7.
# Background color can also be set, and the suggestion can be styled bold, underlined, or
# standout. For example, this would show suggestions with bold, underlined, pink text on a
# cyan background:
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=##6200ff'
# For more info, read the Character Highlighting section of the zsh manual: `man zshzle` or
# [online](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting).

# `ZSH_AUTOSUGGEST_STRATEGY` is an array that specifies how suggestions should be generated.
# The strategies in the array are tried successively until a suggestion is found. There
# are currently three built-in strategies to choose from:

# - `history`: Chooses the most recent match from history.
# - `completion`: Chooses a suggestion based on what tab-completion would suggest. (requires
#                `zpty` module, which is included with zsh since 4.0.1)
# - `match_prev_cmd`: Like `history`, but chooses the most recent match whose preceding history
#                     item matches the most recently executed command
#                     ([more info](src/strategies/match_prev_cmd.zsh)). Note that this strategy
#                     won't work as expected with ZSH options that don't preserve the history
#                     order such as `HIST_IGNORE_ALL_DUPS` or `HIST_EXPIRE_DUPS_FIRST`.

# For example, setting `ZSH_AUTOSUGGEST_STRATEGY=(history completion)` will first try to find a
# suggestion from your history, but, if it can't find a match, will find a suggestion from the completion engine.

# ### Widget Mapping
# This plugin works by triggering custom behavior when certain
# [zle widgets](http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Widgets) are invoked.
# You can add and remove widgets from these arrays to change the behavior of this plugin:

# - `ZSH_AUTOSUGGEST_CLEAR_WIDGETS`: Widgets in this array will clear the suggestion when invoked.
# - `ZSH_AUTOSUGGEST_ACCEPT_WIDGETS`: Widgets in this array will accept the suggestion when invoked.
# - `ZSH_AUTOSUGGEST_EXECUTE_WIDGETS`: Widgets in this array will execute the suggestion when invoked.
# - `ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS`: Widgets in this array will partially accept the suggestion when invoked.
# - `ZSH_AUTOSUGGEST_IGNORE_WIDGETS`: Widgets in this array will not trigger any custom behavior.

# Widgets that modify the buffer and are not found in any of these arrays will fetch a new suggestion after they are invoked.
# **Note:** A widget shouldn't belong to more than one of the above arrays.

# ### Disabling suggestion for large buffers
# Set `ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE` to an integer value to disable autosuggestion for large buffers.
# The default is unset, which means that autosuggestion will be tried for any buffer size.
# Recommended value is 20. This can be useful when pasting large amount of text in the terminal, to
# avoid triggering autosuggestion for strings that are too long.

# ### Asynchronous Mode
# Suggestions are fetched asynchronously by default in zsh versions 5.0.8 and greater. To disable
# asynchronous suggestions and fetch them synchronously instead, `unset ZSH_AUTOSUGGEST_USE_ASYNC`
# after sourcing the plugin.

# ### Disabling automatic widget re-binding
# Set `ZSH_AUTOSUGGEST_MANUAL_REBIND` (it can be set to anything) to disable automatic widget
# re-binding on each precmd. This can be a big boost to performance, but you'll need to handle
# re-binding yourself if any of the widget lists change or if you or another plugin wrap any of the
# autosuggest widgets. To re-bind widgets, run `_zsh_autosuggest_bind_widgets`.

# ### Ignoring history suggestions that match a pattern
# Set `ZSH_AUTOSUGGEST_HISTORY_IGNORE` to a
# [glob pattern](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Operators) to prevent
# offering suggestions for history entries that match the pattern. For example, set it to `"cd *"`
# to never suggest any `cd` commands from history. Or set to `"?(#c50,)"` to never suggest anything
# 50 characters or longer.
# **Note:** This only affects the `history` and `match_prev_cmd` suggestion strategies.

# ### Skipping completion suggestions for certain cases
# Set `ZSH_AUTOSUGGEST_COMPLETION_IGNORE` to a
# [glob pattern](http://zsh.sourceforge.net/Doc/Release/Expansion.html#Glob-Operators) to
# prevent offering completion suggestions when the buffer matches that pattern. For example,
# set it to `"git *"` to disable completion suggestions for git subcommands.
# **Note:** This only affects the `completion` suggestion strategy.

# ### Key Bindings
# This plugin provides a few widgets that you can use with `bindkey`:
# 1. `autosuggest-accept`: Accepts the current suggestion.
# 2. `autosuggest-execute`: Accepts and executes the current suggestion.
# 3. `autosuggest-clear`: Clears the current suggestion.
# 4. `autosuggest-fetch`: Fetches a suggestion (works even when suggestions are disabled).
# 5. `autosuggest-disable`: Disables suggestions.
# 6. `autosuggest-enable`: Re-enables suggestions.
# 7. `autosuggest-toggle`: Toggles between enabled/disabled suggestions.

# For example, this would bind <kbd>ctrl</kbd> + <kbd>space</kbd> to accept the current suggestion.
# bindkey '^ ' autosuggest-accept

### ZSH Syntax Highlighting Plugin Settings ####################
# https://github.com/zsh-users/zsh-syntax-highlighting

# Syntax highlighting is done by pluggable highlighters:
# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
# * `main` - the base highlighter, and the only one [active by default][main].
# * `brackets` - [matches brackets][brackets] and parenthesis.
# * `pattern` - matches [user-defined patterns][pattern].
# * `regexp` - matches [user-defined regular expressions][regexp].
# * `cursor` - matches [the cursor position][cursor].
# * `root` - highlights the whole command line [if the current user is root][root].
# * `line` - applied to [the whole command line][line].

# To activate an highlighter, add it to the `ZSH_HIGHLIGHT_HIGHLIGHTERS` array.
# By default `ZSH_HIGHLIGHT_HIGHLIGHTERS` is `(main)`. For example to activate
# `brackets`, `pattern`, and `cursor` highlighters, in `~/.zshrc` do:
ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets pattern line)

# Highlighters look up styles from the `ZSH_HIGHLIGHT_STYLES` associative array.
# Navigate into the [individual highlighters' documentation](highlighters/) to
# see what styles (keys) each highlighter defines; the syntax for values is the
# same as the syntax of "types of highlighting" of the zsh builtin
# `$zle_highlight` array, which is documented in [the `zshzle(1)` manual
# page][zshzle-Character-Highlighting].
# [zshzle-Character-Highlighting]: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
#ZSH_HIGHLIGHT_STYLES[line]='bold'
#ZSH_HIGHLIGHT_STYLES[cursor]='bg=blue'

# Pattern highlighter matches user-defined patterns, which are defined in the
# Declare the variable
typeset -A ZSH_HIGHLIGHT_PATTERNS

# To have commands starting with `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')

# By default, all command lines are highlighted.  However, it is possible to
# prevent command lines longer than a fixed number of characters from being
# highlighted by setting the variable `${ZSH_HIGHLIGHT_MAXLENGTH}` to the maximum
# length (in characters) of command lines to be highlighter.
# ZSH_HIGHLIGHT_MAXLENGTH=512

########## FUNCTIONS #######################

# Simple encode and decode functions.  Mostly useful as an example of
# a simple bash function that can be added to a shell file.
# Function to encode strings to base64
encode () {
  echo "$1" | base64
}
# Function to decode base64 encoded strings.
decode () {
  echo "$1" | base64 -d ; echo
}

# Unset LESS to avoid conflicts with other LESS settings or tools
unset LESS;

# If kubectl is found in PATH, enable zsh completion for the first kubectl found
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# Enable bash completion in zsh by loading bashcompinit
autoload -U +X bashcompinit && bashcompinit

# Load nvm (Node Version Manager) if it exists
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Load nvm bash completion if it exists
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If GITHUB_TOKEN isn't already exported (e.g. --env-file didn't fire or the container was
# started outside Dev Containers), fall back to sourcing the workspace .env directly.
# `set -a` auto-exports every variable assigned until `set +a`, making them true env vars.
if [[ -z "$GITHUB_TOKEN" && -f "/workspace/.env" ]]; then
    set -a
    source /workspace/.env
    set +a
fi

# Load gh copilot shell aliases only when a token is available; otherwise skip silently.
if [[ -n "$GITHUB_TOKEN" ]]; then
    eval "$(gh copilot alias -- zsh 2>/dev/null)"
fi

# Override the default ssh command to set a universally safe TERM and to rename tmux windows
# when connecting to a new host.
ssh() {
  # Universally safe TERM for remotes
  local ssh_term="xterm-256color"

  if [[ -n "$TMUX" ]]; then
    # Rename the pane so you know where you are
    local dest="${@[-1]}"
    tmux rename-window "→ ${dest}"

    TERM=$ssh_term command ssh "$@"
    local ret=$?

    # Restore automatic naming on return
    tmux setw automatic-rename on

    return $ret
  else
    TERM=$ssh_term command ssh "$@"
  fi
}

# Add SSH keys to the ssh-agent for the session
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
fi

# The above script is not apparently persistent across sessions, so we need to add the keys
# to the ssh-agent for each session. This is done by loading the keys from ~/.ssh
# Look for private keys to load into the ssh-agent
# Note: This will find and attempt to load all private keys in ~/.ssh with logic to exclude
# specific files in the directory such as `known_hosts`, `authorized_keys`, and `config` and
# any files with an extension other than `.pem` (files with no extension are included).
# for key in $(find ~/.ssh -type f \( -name '*' -o -name '*.pem' \) ! -name '*.*' ! -name 'known_hosts' ! -name 'authorized_keys' ! -name 'config'); do
#     if ! ssh-add -q "$key" 2>/dev/null; then
#         # If standard add fails, try using ssh-add with password prompt allowed
#         if ! ssh-add "$key" </dev/tty 2>/dev/null; then
#             echo "Failed to add $key to ssh-agent"
#         fi
#     fi
#     if ! ssh-add --apple-use-keychain "$key" 2>/dev/null; then
#         echo "Failed to add $key to ssh-agent with --apple-use-keychain"
#     fi
# done

# Note - if the above script does not appear to be persisting SSH keys so that they are loaded
# for every session, then run the following commands in the terminal:
# chmod 600 ~/.ssh/config
# source ~/.zshrc


########## OPTIONS #######################

#!/usr/bin/zsh
#
# https://zsh.sourceforge.io/Doc/Release/Options.html
#
# If you want to share history across terminal instances:
#   setopt SHARE_HISTORY
#
# But be warned this can be annoying when you want to⬆️the history and find your
# recent command is no longer the most recent.
#

setopt AUTO_CD # Automatically changes to a directory if a command matches a directory name, without requiring the cd command.
setopt CDABLE_VARS # Allows variable names to be used with cd. If the argument to cd matches a variable name, Zsh changes to the directory stored in the variable.
setopt CD_SILENT # Suppresses output when changing directories with cd.
setopt CHASE_DOTS # Resolves . and .. in pathnames when navigating directories, even if symbolic links are present.
setopt CHASE_LINKS # Resolves symbolic links to their target directory when changing directories.
setopt ALWAYS_LAST_PROMPT # Ensures the prompt is always displayed after executing a command, even if the terminal output is redirected.
setopt ALWAYS_TO_END # Moves the cursor to the end of the line when a history entry is modified during editing.
setopt AUTO_LIST # Automatically lists completions when the tab key is pressed, and there is more than one possible match.
setopt AUTO_MENU # Displays a menu of completion options after a partial match is typed and tab is pressed multiple times.
setopt AUTO_NAME_DIRS # Automatically creates named directory aliases for directories specified in the cdpath.
setopt AUTO_PARAM_KEYS # When completing associative array keys, Zsh will add a closing ] automatically.
setopt AUTO_PARAM_SLASH # Automatically adds a trailing slash when completing directory names.
#setopt AUTO_REMOVE_SLASH # Removes an unnecessary trailing slash from pathnames when not needed.
setopt COMPLETE_IN_WORD # Allows completion to occur in the middle of a word rather than just at the cursor’s end.
setopt GLOB_COMPLETE # Enables completion that treats globs (e.g., *.txt) as potential matches to complete filenames.
setopt HASH_LIST_ALL # Lists all executables in the hash table when hashing is enabled (used for command lookup).
setopt LIST_AMBIGUOUS # Lists possible completions for ambiguous inputs instead of waiting for more typing.
setopt LIST_PACKED # Displays completion options in a compact, multi-column format.
setopt LIST_TYPES # Adds a file type indicator (e.g., / for directories, * for executables) when listing completions.
setopt MENU_COMPLETE # Cycles through completion options by repeatedly pressing the tab key.
setopt EXTENDED_GLOB # Enables advanced globbing features like negation (^), matching ranges, etc.
setopt REMATCH_PCRE # Enables Perl-compatible regular expressions (PCRE) for pattern matching in Zsh.
setopt INC_APPEND_HISTORY # Appends commands to the history file incrementally as they are executed.
setopt HIST_EXPIRE_DUPS_FIRST # Removes the oldest duplicate entries from history when the history size limit is reached.
setopt HIST_FCNTL_LOCK # Uses file locking to prevent simultaneous access issues with the history file.
setopt HIST_FIND_NO_DUPS # Avoids showing duplicate history entries when searching interactively.
setopt HIST_IGNORE_ALL_DUPS # Removes all duplicate entries from history when a new duplicate command is added.
setopt HIST_REDUCE_BLANKS # Removes extra whitespace from commands saved to history.
setopt ALIASES # Enables alias expansion for command lines.
#setopt VI # Enable vi-style keybindings for command-line editing.
#setopt NOCORRECT NOCORRECTALL # Disables spell checking for the current command or for all commands.

# http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
# By default, if a command line contains a globbing expression which doesn't
# match anything, Zsh will print the error message you're seeing, and not run
# the command at all. You can disable this using the following...
#setopt +o nomatch


# Load and run Oh My Zsh
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"     # Must be after OMZ source

# If tmux is installed and we're not already in a tmux session, attach to the most recently
# used detached session or start a new one.
if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
  # Find any detached session with no name (auto-numbered, name is just digits)
  unattached=$(tmux ls 2>/dev/null \
    | awk -F: '/\(0 clients\)/ && /^[0-9]+/ {print $1; exit}')
  
  if [[ -n "$unattached" ]]; then
    exec tmux attach -t "$unattached"
  else
    exec tmux new-session
  fi
fi