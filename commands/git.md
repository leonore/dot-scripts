## useful git commands

### Remove remote .gitignored files

Taken from [codeblocq](http://www.codeblocq.com/2016/01/Untrack-files-already-added-to-git-repository-based-on-gitignore/)

```
# after having .gitignore(d) the files you need
git rm -r --cached .
git add .
git commit -m "ignore [explanation] files"
```