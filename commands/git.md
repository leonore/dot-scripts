## useful git commands

### Remove remote .gitignored files

Taken from [codeblocq](http://www.codeblocq.com/2016/01/Untrack-files-already-added-to-git-repository-based-on-gitignore/)

```
# after having .gitignore(d) the files you need
git rm -r --cached .
git add .
git commit -m "ignore [explanation] files"
```

### Remove multiple git branches

[source](https://medium.com/@rajsek/deleting-multiple-branches-in-git-e07be9f5073c)

```
git branch | grep <pattern> | xargs git branch -D    # -d might be sufficient 
```

### Checkout local changes within a file (rather than a whole file)

```
git checkout --patch -- <path argument>
```
