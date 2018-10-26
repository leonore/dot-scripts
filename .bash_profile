# quick access to bash_profile
openb() {
if [ "${@:-0}" == "-o" ]
then
    open ~/.bash_profile
else
    vim ~/.bash_profile 
fi
}

# some useful aliases
alias jupyter=/usr/local/anaconda3/bin/jupyter\ notebook
alias y3="cd ~/Documents/COMPSCI/YEAR\ 3"

# cd into workspace or directly into a workspace directory if argument provided
work() { cd ~/Documents/Workspace/"$@" }

# get the weather
weather() { 
echo "Weather for $1"
curl -s "https://api.openweathermap.org/data/2.5/weather?q=$1&units=metric&appid=SECRET" | tr ',' '\n' | grep -e description -e temp | sed -e 's/[\"{}:]/ /g' -e 's/description/ /g' -e 's/main//g'
}

# add a todo task or open the file
todo() { 
if [ "${@:-0}" == 0 ]
then
    open ~/Desktop/todo.txt
else
    echo "$@" >> ~/Desktop/todo.txt
    echo "$@ was added to list"
fi
} 
