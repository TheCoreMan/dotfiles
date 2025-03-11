# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	docker
	kubectl
	zsh-autosuggestions
	zsh-syntax-highlighting
	npm
	nvm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

HOMEBREW_NO_ENV_HINTS=true

alias 'cdc'='cd $HOME/Desktop/code'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# NVM stuff
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Search inside the command line
function lynx-duck() {
	lynx "duckduckgo.com/lite?q=$*"
}

alias '?'="lynx-duck"

alias airpods='blueutil --connect $(blueutil --paired --format json-pretty | jq -r ".[] | select(.name | contains(\"Shay’s AirPods Pro\")) | .address")'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Need this for pipenv
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
# Add pipenv to path
export PATH="$HOME/.local/bin:$PATH"
# Add python user binaries to path
export PATH="/Users/shay/Library/Python/3.11/bin:$PATH"

# Add go binaries to path
export PATH="$PATH:$HOME/go/bin"

# ~/.zshrc
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# See https://patloeber.com/pomodoro-app-cli-macos/
work() {
  # usage: work 10m, work 60s etc. Default is 20m
  timer "${1:-20m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -sound Crystal
}

rest() {
  # usage: rest 10m, rest 60s etc. Default is 5m
  timer "${1:-5m}" && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -sound Crystal
}

grab_download() {
    # Define variables
    latest_file=$(ls -dtr1 ~/Downloads/* | tail -1)
    current_dir=$(pwd)

    # Check if gum is installed
    if ! command -v gum &> /dev/null
    then
        echo "gum is not installed. Please install gum from https://github.com/charmbracelet/gum"
        return 1
    fi

    # Display information about the latest file
    file_info=$(file "$latest_file")
    gum style --bold --foreground "#FFA500" --border normal --border-foreground "#00FF00" "📄 Latest Downloaded File:" && gum style --italic --foreground "#00FFFF" "$file_info"

    # Copy the latest file to the current directory with a loader/spinner
    gum spin --spinner dot --title "Copying file..." -- cp -p "$latest_file" "$current_dir"

    # Inform the user of the successful copy operation
    gum style --bold --foreground "#00FF00" "✅ Successfully copied the latest downloaded file to the current directory!"

    # Print the final absolute path of the copied file
    gum style --bold --foreground "#FFA500" "📂 It's here:" && gum style --italic --foreground "#00FFFF" "$current_dir"
}

# fzf git
# see https://github.com/junegunn/fzf-git.sh
source ~/.zsh-plugins-manual/fzf-git.sh/fzf-git.sh

export K9S_EDITOR="vim"
export EDITOR="vim"

eval "$(zoxide init zsh)"
eval $(thefuck --alias)

alias git-clean-branches="git branch --merged main | grep -v -e 'main' -e '\*' | xargs -n 1 git branch -d && git remote prune origin || echo 'No local branches to remove, so nothing done.'"
alias githist='git log --abbrev-commit --oneline $(git merge-base origin/main HEAD)^..HEAD'

# Avoid some Python services crash.
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export PATH="/Users/shay/.pixi/bin:$PATH"
# For pg_dump and pg_restore
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
