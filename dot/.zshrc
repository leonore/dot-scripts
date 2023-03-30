export PATH=/Users/leo/.asdf/installs/golang/1.19.3/packages/bin:/Users/leo/.asdf/shims:/opt/homebrew/opt/asdf/libexec/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/opt/fzf/bin:$PATH
export PATH=/Users/leo/.sg:$PATH
export PATH=/Users/leo/.bin:$PATH

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# zsh completion tings
# source <(kubectl completion zsh)

# gcloud
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

# GITHUB aliases
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gd='git diff'
alias gp='git pull'
alias push='git push'
alias pusho='git push origin -u HEAD'
alias main='git checkout main'
alias work='cd ~/dev/sourcegraph/'
alias upstream='git branch --set-upstream-to=origin/main'
alias update='git pull origin main'

# KUBECTL aliases
alias ksg='kubectl -n dogfood-k8s'
alias kst='kubectl -n scaletesting'
alias sternsg='stern --namespace dogfood-k8s'
alias k=kubectl

# sourcegraph aliases
alias managed='cd /Users/leo/dev/deploy-sourcegraph-managed'
alias gosg='sg start enterprise-codeinsights'

alias gen='PGUSER=sourcegraph sg generate'
alias golint='PGUSER=sourcegraph sg lint -fix go'

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
dev() { cd ~/dev/"$@";}

# decode base64 into utf-8 insight view id
function insightid() {
    ID=$(echo "${@}" | base64 -d | sed -e 's/insight_view://; s/\"//g')
    echo $ID
    echo $ID | pbcopy
}

cb() {
    git fetch origin --prune -q
    if [ "$1" = "-d" ]; then 
        git branch -v | awk '{if ($3 == "[gone]") {print $1};}'
    else 
        git branch -v | awk '{if ($3 == "[gone]") {print $1};}' | xargs git branch -D
    fi
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

setopt prompt_subst
# 11:24 cwd (branch) >
PROMPT='%T %F{014}%1d%f %F{207}$(parse_git_branch)%f > '

# nice git and fzf integrations
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

function ghl {
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
# PROG=sg source /Users/leo/.sourcegraph/sg.zsh_autocomplete
autoload -Uz compinit
compinit

export MG_DEPLOY_SOURCEGRAPH_MANAGED_PATH=/Users/leo/dev/deploy-sourcegraph-managed/
# export PATH=$HOME/.bin:$PATH
# . /usr/local/opt/asdf/libexec/asdf.sh
source /Users/leo/google-cloud-sdk/completion.zsh.inc
source /Users/leo/google-cloud-sdk/path.zsh.inc
