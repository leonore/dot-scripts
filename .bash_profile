# quick access to bash_profile
openb() {
if [ "$@" = "-o" ]
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
echo -e "What city do you want the weather for?"
read city
echo "Weather for ${city}"
curl -s "https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=00bbba62aab5f8af6e031f59ed80c87e" | tr ',' '\n' | grep -e description -e temp | sed -e 's/[\"{}:]/ /g' -e 's/description/ /g' -e 's/main//g'
}

# add a todo task or open the file
todo() { 
if [ -z $@ ]
then
    open ~/Desktop/todo.txt
else
    echo "$@" >> ~/Desktop/todo.txt
fi
} 
