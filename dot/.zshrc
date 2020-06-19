powerline-daemon -q 
. /Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# quick access to .zshrc
function ebash() {
if [[ "$1" = "-o" ]]
then
    open ~/.zshrc
else
    vim ~/.zshrc 
fi
}

# quick access to .tmux.conf
function etmux() {
  vim .tmux.conf
}

# some useful aliases
alias jupybook=/usr/local/anaconda3/bin/jupyter\ notebook
alias jupylab=jupybook
alias jupy=jupylab
alias y4="cd ~/Documents/COMPSCI/YEAR\ 4"
alias blog="cd ~/Documents/Workspace/leonore.github.io"

# cd into workspace or directly into a workspace directory if argument provided
work() { cd ~/Documents/Workspace/"$@";}

# activate venv by name
venv() { source ~/Documents/Workspace/venv/"$1"/bin/activate; }

# get the weather
weather() { 
echo "Weather for $1"
echo $(curl -k "https://api.openweathermap.org/data/2.5/weather\?q=$1\&units=metric\&appid=SECRET" | tr ',' '\n' | grep -e description -e temp | sed -e 's/[\"{}:]/ /g' -e 's/description/ /g' -e 's/main//g')
}

# add a todo task or open the file
todo() {
if [[ "${@:-0}" == 0 ]]
then
    open ~/Desktop/todo.txt
else
    echo "$@" >> ~/Desktop/todo.txt
    echo "$@ was added to list"
fi
o} 

# time logging
log() {
if [[ "${@:-0}" == 0 ]]
then
    open ~/Desktop/2020_log.txt
else
    echo "`date +"%a %d/%m/%y %T"` $@" >> ~/Desktop/2020_log.txt
    echo "$@ was logged"
fi
}


# spotify scripts
spotcov() {
    cd ~/Pictures/spotify\ covers
    # todo clean up extra files
}
