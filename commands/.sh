# https://stackoverflow.com/questions/10523415/execute-command-on-all-files-in-a-directory
for file in /dir/*
do
  cmd [option] "$file" >> results.out
done

# copy directory, will create dest/ if non-existent
cp -R origin/ dest/

# helpful greps
grep foo -m 2         # number of hits
grep foo -m 1 -A 5    # number of lines to show after the hit
grep foo -m 1 -B 5    # number of lines to show before the hit

# pipe stdout to a file
command-generating-stdout 2>&1 | tee outfile

# basic find and replace in a file
sed -i 's/original/new/g' file.txt

# recursive find and replace in a directory
grep -rl pattern . | xargs sed -i 's/old/new/g'

# get k8s resources and act on them
kubectl get pods | awk '/pattern/{print $1}' | xargs kubectl delete pod
