# https://stackoverflow.com/questions/10523415/execute-command-on-all-files-in-a-directory

for file in /dir/*
do
  cmd [option] "$file" >> results.out
done
