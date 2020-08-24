# g()

Bash function - g is a functional alias for git (i.e.: 'g status' = 'git status') and a processor
with option switches for shortcuts of my most commonly used git commands.

## Use

Use this and customize it with your most used git commands.   I use this as a menu to remind my old man brain what I need to do next.

# Default Help menu

When you execute g() without parameters you will get the following:

PURPOSE: g is an alias for git (i.e.: 'g status' = 'git status') and a processor
          with option switches for shortcuts of my most commonly used git commands.

 OPTIONS:
   s | status  = git status                      d | detail   = git --no-pager show HEAD | less
   l | log     = git log --name-status          co | checkout = git checkout
   . | all     = git add .                      gu | addu     = git add -u (tracked files)
   a | add     = git add                        gi | init     = git init
   c | commit  = git commit -m                   r | reset    = git reset
   u | update  = git add & commit <msg> & push  ph | push     = git push
   f | files   = git ls-files                    p | pull     = git pull
   i | ignore  = add <file> to .gitignore       cl | clone    = git clone
  ei | eignore = edit .gitignore                 d | diff     = git diff
 cfg | config  = edit git config file            b | branch   = git branch
   b | brief   = git status --short --branch     h | head     = git show HEAD
  ls | last    = git --no-pager show --summary  fe | fetch    = git fetch --prune
   1 | 1liner  = git log --oneline              st | stash    = git stash
  lf | logfind = git log --grep <string>        ? | -?        = This help menu

   g help - will provide list of commands and guides
   g help <topic> - will provide man page for a specific topic or command

  NOTE: most commands will take additional parameters for the git sub command.
       i.e.: 'g s' will take additional options and parameters for 'git status'

## Special Options

### Update Option
This option performs the following operations:
  1) git add .
  2) git commit -m "<commit message>"
  3) git push (if remote repo defined)



## Authors
