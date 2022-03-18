export VISUAL=vim
export EDITOR="$VISUAL"

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/Users/Leonore/.asdf/installs/golang/1.17.5/packages/bin:$PATH"

# GITHUB aliases
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gd='git diff'
alias gp='git pull'
alias main='git checkout main'
alias dev='cd ~/Documents/Workspace/sourcegraph/'
alias upstream='git branch --set-upstream-to=origin/main'

# quick access functions
function ez() {
    vim ~/.zshrc
}
function sz() {
    source ~/.zshrc
}
function ev() {
    vim ~/.vimrc
}
function et() {
    vim ~/.tmux.conf
}

# cd into workspace or directly into a workspace directory if argument provided
work() { cd ~/Documents/Workspace/"$@";}

# Pretty bash tings
force_color_prompt=yes

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

setopt prompt_subst
PROMPT='%T %B%~%b $ '
RPROMPT='$(parse_git_branch)'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# ssh agent
alias ssha='eval "$(ssh-agent -s)"; ssh-add -t 43200 ~/.ssh/id_ed25519'

function is_in_git_repo {
    git rev-parse HEAD &> /dev/null
}

function fzf-down {
    fzf --height 50% "$@" --border
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

function gf {
    is_in_git_repo || return
    git -c color.status=always status --short |
        fzf-down -m --ansi --nth 2..,.. \
            --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
        cut -c 4- |
        sed 's/.* -> //'
}

function gbr {
    is_in_git_repo || return
    git branch --color=always |
        grep -v '/HEAD\s' |
        sort |
        fzf-down --ansi --multi --tac --preview-window right:70% \
            --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
        sed 's/^..//' |
        cut -d ' ' -f 1 |
        sed 's#^remotes/##'
}

function gt {
    is_in_git_repo || return
    git tag --sort -version:refname |
    fzf-down --multi --preview-window right:70% \
        --preview "git show --color=always {} | head -$LINES"
}

function gh {
    is_in_git_repo || return
    git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
        fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --header 'Press CTRL-S to toggle sort' \
            --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
        grep -o "[a-f0-9]\{7,\}"
}

function gr {
    is_in_git_repo || return
    git remote -v |
        awk '{print $1 "\t" $2}' |
        uniq |
        fzf-down --tac \
            --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
        cut -d $'\t' -f 1
}

function gc {
    is_in_git_repo || return
    git checkout $(gbr)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. /usr/local/opt/asdf/libexec/asdf.sh

