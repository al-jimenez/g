#!/usr/bin/env bash

# 📌 g () - is a functional alias for git.  i.e.: 'g status' = 'git status'
# With option switches for shortcuts of my most commonly used git commands
# Usage: g | g <option> | g <option> <other parameters>
# ------------------------------------------------------------------------------
g() {
  if [ ! -z $1 ] ; then
    case $1 in
      .   | all      ) shift; git add . ${@}; return;;
      a   | add      ) shift; git add ${@}; return;;
      af  | after    ) shift; shiift;
                              [[ ! -z "${1}" ]] && { after="${1}"; };
                              [[ -z "${1}" ]] && { after="yesterday"; };
                              git log --name-status --after="${after}"; return;;
      au  | addu     ) shift; git add -u ${@}; return;;
      b   | brief    ) shift; git status --short --branch ${@}; return;;
      br  | branch   ) shift; git branch ${@}; return;;
      co  | checkout ) shift; git checkout ${@}; return;;
      cl  | clone    ) shift; git clone ${@}; return;;
      c   | commit   ) shift; git commit -m ${@}; return;;
     cfg  | config   ) shift; edit .git/config; return;;
      dt  | detail   ) shift; git --no-pager show HEAD ${@} | less; return;;
      d   | diff     ) shift; git diff ${@}; return;;
      ei  | e-ignore ) shift; nano .gitignore; return;;
      f   | files    ) shift; git ls-files ${@}; return;;
      fe  | fetch    ) shift; git fetch --prune ${@}; return;;
      gi  | init     ) shift; git init ${@}; return;;
      h   | head     ) shift; git show HEAD ${@}; return;;
      ls  | last     ) shift; git --no-pager show --summary ${@}; return;;
      l   | log      ) shift; git log --name-status ${@}; return;;
      li  | lignore  ) shift; less .gitignore; return;;
      lf  | logfind  ) shift; git log --pretty=format:"%C(white)%cs%C(reset):%s" --grep="${@}"; return;;
      o   | glog     ) shift; git log --name-status ${@}; return;;
      1   | 1liner   ) shift; git log --pretty=format:"%C(white)%h%C(bold red)|%C(reset)%cs%C(bold red)|%C(reset)%sC(reset)"; return;;
      p   | pull     ) shift; git pull ${@}; return;;
      ph  | push     ) shift; git push ${@}; return;;
      r   | reset    ) shift; git reset ${@}; return;;
      st  | stash    ) shift; git stash ${@}; return;;
      s   | status   ) shift;
                       git status ${@};
                       echo -e "${white}\nLast commit: \c";
                       git --no-pager log --pretty=format:"%C(white)%cr %C(white)%s%C(white)" -1 HEAD; echo;
                       [[ -e .notes ]] && { echo; cat .notes; echo; }; echo; # show git status and show project .notes if exists
                       return ;;
      i   | ignore   ) shift;
                       [[ -z "${1}" ]] && { echo -e "\n ERROR: selection requires a filename.\n\n  USAGE: g ignore <file>\n"; return; };
                       echo ${@} >> .gitignore; return ;;
      u   | update   ) shift;
                       [[ $(git status --short) ]] && { commit_msg="$(git status --short | sed 's/ M / /' | tr -d '\n' | trim)"; }
                       [[ ! -z "${1}" ]] && { commit_msg="${@} [${commit_msg}]"; }  # add additional commmit message
                       echo -e "\nGit update: \n"
                       # git add .; git commit -m "[$(dts %Y-%m-%-d' '%-I:%M' '%p;)]:[$(/bin/hostname 2>&1)]:${commit_msg}";
                       # git add .; git commit -m "[$(/bin/hostname 2>&1)]:${commit_msg}";
                       git add .; git commit -m "${commit_msg}";
                       [[ $(git remote show) ]] && git push;  # push if remote repo defined
                       echo;
                       git --no-pager log --pretty=format:"%C(white)%cr %C(white)%s%C(white)" -1 HEAD
                       echo; [[ -e .notes ]] && { echo; cat .notes; echo;}
                       return ;;
      -h | help      ) shift;
                       [[ ! -z "${1}" ]] && { git help ${1}; }              # get specific command man page
                       [[ -z "${1}"   ]] && { git help -a ; git help -g; }  # get general help
                       return;;
    esac
  else
    ${FUNCNAME[0]} ?; return;
  fi
  #[[ "${1}" == "help" ]] && { git help -a ; git help -g; return; }
  [[ "${1}" == "?" ]] || [[ "${1}" == "-?" ]] || [[ "${1}" == "-h" ]] && {
    echo -e "\n  PURPOSE: g is a shortcut for git (i.e.: 'g status' = 'git status') and a preprocessor
           with option switches for my most commonly used git commands

  OPTIONS:
  s | status   = git status            af | after   = git log --after=<yesterday>|<string>
  l | log      = git log               lf | logfind = git log --grep <string>
  . | all      = git add .             ls | last    = git --no-pager show --summary
  a | add      = git add                1 | 1liner  = git log --oneline
  c | commit   = git commit -m          b | brief   = git status --short --branch
  u | update   = git add,commit,push    d | detail  = git --no-pager show HEAD | less
  f | files    = git ls-files           h | head    = git show HEAD
  i | ignore   = <file> >> .gitignore   d | diff    = git diff
 ei | eignore  = edit .gitignore        b | branch  = git branch
cfg | config   = edit git config file  gi | init    = git init
 co | checkout = git checkout           r | reset   = git reset
 ph | push     = git push              gu | addu    = git add -u (tracked files)
  p | pull     = git pull              fe | fetch   = git fetch --prune
 cl | clone    = git clone             st | stash   = git stash
  ? | -?       = This help menu

  g help - will provide list of commands and guides
  g help <topic> - will provide man page for a specific topic or command

 NOTE: most commands will take additional parameters for the git sub command:
       i.e: g l --pretty=format:\"%h|%cs|%s\", or: g s --short, etc
  "
  return
  }
  [[ ! -z ${1} ]] && { git ${1}; return; }    # catch all for ther git command paraemters
}
