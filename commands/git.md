## useful git commands

### Remove remote .gitignored files
Taken from [codeblocq](http://www.codeblocq.com/2016/01/Untrack-files-already-added-to-git-repository-based-on-gitignore/)

```bash
# after having .gitignore(d) the files you need
git rm -r --cached .
git add .
git commit -m "ignore [explanation] files"
```

### Remove multiple git branches
[source](https://medium.com/@rajsek/deleting-multiple-branches-in-git-e07be9f5073c)

```bash
git branch | grep <pattern> | xargs git branch -D    # -d might be sufficient 
```

### Checkout local changes within a file (rather than a whole file)
```bash
git checkout --patch -- <path argument>
```

### Stash commands you always end up googling again
```bash
git stash push -m "describe stash"
git stash show -p stash@{x}
git stash pop stash@{x}
```

### messed-up-a-merge useful commands
```bash
git config --global pull.rebase true
git reset --hard HEAD@{2}
```

### commands for stacking PRs
```bash
git branch -u "origin/your/branch"
git pull
```
