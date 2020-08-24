#!/usr/bin/env bash
# g () - is a functional alias for git.  i.e.: 'g status' = 'git status'
# With option switches for shortcuts of my most commonly used git commands
# 📌 Usage: g | g <command> | ?
# ------------------------------------------------------------------------------
g() {
  if [ ! -z $1 ] ; then
    case $1 in
      .   | all      ) shift; git add . ${@}; return;;
      a   | add      ) shift; git add ${@}; return;;
      gu  | addu     ) shift; git add -u ${@}; return;;
      b   | brief    ) shift; git status --short --branch ${@}; return;;
      br  | branch   ) shift; git branch ${@}; return;;
      co  | checkout ) shift; git checkout ${@}; return;;
      cl  | clone    ) shift; git clone ${@}; return;;
      c   | commit   ) shift; git commit -m ${@}; return;;
      cfg | config   ) shift; edit .git/config; return;;
      d   | detail   ) shift; git --no-pager show HEAD ${@} | less; return;;
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
      1   | 1liner   ) shift; git log --pretty=format:"%C(white)%cr%C(reset)|%C(white)%cs%C(reset):%s"; return;;
      p   | pull     ) shift; git pull ${@}; return;;
      ph  | push     ) shift; git push ${@}; return;;
      r   | reset    ) shift; git reset ${@}; return;;
      st  | stash    ) shift; git stash ${@}; return;;
      s   | status   ) shift; git status ${@}; return ;;
      i   | ignore   ) shift;
                       [[ -z "${1}" ]] && { echo -e "\n ERROR: selection requires a filename.\n\n  USAGE: g ignore <file>\n"; return; };
                       echo ${@} >> .gitignore; return ;;
      u   | update   ) shift;
                       [[ $(git status --short) ]] && { commit_msg="$(git status --short | sed 's/ M / /' | tr -d '\n' | trim); "; }
                       [[ ! -z "${1}" ]] && { commit_msg="${@}; ${commit_msg}"; }  # add additional commmit message
                       echo -e "\nGit update:\n"
                       #git add .; git commit -m "[$(dts %Y-%m-%-d' '%-I:%M' '%p;)]:[$(/bin/hostname 2>&1)]:${commit_msg}";
                       git add .; git commit -m "[$(/bin/hostname 2>&1)]:${commit_msg}";
                       [[ $(git remote show) ]] && git push;  # push if remote repo defined
                       echo;
                       git --no-pager log --pretty=format:"%C(bold yellow)%cr %C(reset)%s" -1 HEAD
                       echo -e "\n";
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
    echo -e "\n  PURPOSE: g is an alias for git (i.e.: 'g status' = 'git status') and a processor
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

  "
  return
  }
  [[ ! -z ${1} ]] && { git ${1}; return; }    # catch all for ther git command paraemters
}
