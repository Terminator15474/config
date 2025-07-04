# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
function set_env_vars_cygwin() {
	export HOME="/cygdrive/c/Users/jando"
	# export APPDATA="$HOME/AppData/Roaming"
}

case "$(uname -s)" in
	CYGWIN*) set_env_vars_cygwin ;;
	*) export HOME="/home/jan";;
esac


export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

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

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-syntax-highlighting
	zsh-autosuggestions
)

autoload -Uz compinit
compinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# =================================== #
# ====== Old Powershell config ====== #
# =================================== #

# === Oh My Posh ===
source "$HOME/.oh-my-zsh/oh-my-zsh.sh"
# === Terminal Icons (Not directly available in zsh) ===
# There’s no zsh equivalent to Terminal-Icons, but `lsd`, `exa`, or `colorls` provide icon-enhanced listings.

# === Remove built-in aliases or override ===
unalias cd 2>/dev/null
unalias curl 2>/dev/null
unalias gc gcb gcm gcs gl gm gpv gs ga gp gd sl nv gca 2>/dev/null

# === Aliases ===
alias vim="nvim"
alias vi="nvim"
alias vmi="nvim"
alias miv="nvim"
alias invm="nvim"
alias vnim="nvim"
alias nivm="nvim"
alias mvin="nvim"
alias nv="nvim"
alias mnvi="nvim"
alias ll="ls -alF"
alias sl="ls"
alias g="git"
alias gti="git"
alias cd="z"

# === Git functions ===
function gs() {
  git status
}

function ga() {
  git add *
}

function gd() {
  git diff "$@"
}

function gc() {
  git commit -m "$*"
}

function gp() {
  git push "$@"
}

function gl() {
  if [[ "$*" == *"-n"* ]]; then
    git log --oneline "$@"
  else
    git log --oneline -n 10 "$@"
  fi
}

function gca() {
	git commit --amend --no-edit
}

function gpa() {
  git pull --autostash "$@"
}

# === FZF Setup (Assuming fzf is installed) ===
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source "$HOME/.fzf/shell/key-bindings.zsh"

# === History Search & Key Bindings (zsh equivalent of PSReadLine + PSFzf) ===
bindkey -v  # Vi mode
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^R' history-incremental-search-backward
bindkey '^F' fzf-file-widget  # Requires fzf and fzf.zsh to be sourced

# === Zoxide (cd alternative) ===
eval "$(zoxide init zsh)"


# === Chocolatey Tab Completion (Windows only; skipped if not applicable) ===
if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  CHOCO_PROFILE="$ChocolateyInstall/helpers/chocolateyProfile.psm1"
  if [[ -f "$CHOCO_PROFILE" ]]; then
    powershell -Command "Import-Module '$CHOCO_PROFILE'"
  fi
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval `ssh-agent -s`
ssh-add ~/.ssh/github_rsa
