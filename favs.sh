#!/usr/bin/env bash

# favs() - add a fav item to ~/.favs with description and rating per item
# 📌 Usage: favs() | favs() <command options> <description> <rating=1,2,3> where 3 is highest.
# --------------------------------------------------------------------------------------------
favs() {
  if [[ ! -z ${3} ]]; then
     [[ ${3} == 1 ]] && local hearts="    ♥︎ "
     [[ ${3} == 2 ]] && local hearts="  ♥︎ ♥︎ "
     [[ ${3} == 3 ]] && local hearts="♥︎ ♥︎ ♥︎ "
  else local hearts="      "; fi;
  #[[ -z ${1} ]] && { shift; ${FUNCNAME[0]} ?; return; }
  [[ -z ${1} ]] && { cat ~/.favs; return; }
  [[ "${1}" == "-"  ]] && { shift; echo "${hearts}   NONE: $* -" $(LC_ALL=C date +"%m/%d/%Y") >> ~/.favs; return;    }
  [[ "${1}" == "-a" ]] || [[ "${1}" == "alias"    ]] && { shift; echo "${hearts}    ALIAS:${1} " >> ~/.favs; return; }
  [[ "${1}" == "-f" ]] || [[ "${1}" == "function" ]] && { shift; echo "${hearts} FUNCTION:${1} " >> ~/.favs; return; }
  [[ "${1}" == "-s" ]] || [[ "${1}" == "script"   ]] && { shift; echo "${hearts}   SCRIPT:${1} " >> ~/.favs; return; }
  [[ "${1}" == "-l" ]] || [[ "${1}" == "list"     ]] && { shift; cat ~/.favs; return;  }
  [[ "${1}" == "-e" ]] || [[ "${1}" == "edit"     ]] && { shift; edit ~/.favs; return; }
  [[ "${1}" == "-?" ]] || [[ "${1}" == "help"     ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "?" ]] && {
    echo -e "
    PURPOSE: List/rate favorite alias, functions & scripts

    ${FUNCNAME[0]} <command options> <description> <rating=1,2,3> where 3 is highest.

    Options:
      -               Add ${FUNCNAME[0]} without category
     -a | alias       Add ${FLNCNAME[0]} aliaslist/rate favorite alias, functions & scripts
     -f | function    Add ${FUNCNAME[0]} function
     -s | script      Add ${FUNCNAME[0]} script
     -l | list        Show ${FUNCNAME[0]} list
     -e | edit        Edit ${FUNCNAME[0]} file
     -? | -h | help   This help

     Examples:
      ${FUNCNAME[0]} -a 'c=clear;  Clears the screen' 3
        '♥︎ ♥︎ ♥︎ ALIAS:    c=clear;  Clears the screen'\n
      ${FUNCNAME[0]} -f 'notes | .n add a date stamped note to .notes file.' 2
        '  ♥︎ ♥︎ FUNCTION: notes | .n add a date stamped note to .notes file.'\n
      ${FUNCNAME[0]} -s 'cheatsheets.sh - load specific cheatsheets' 1
        '    ♥︎ SCRIPT:   cheatsheets.sh - load specific cheatsheets based
                         on language'\n
      ${FUNCNAME[0]} -s 'cheatsheets.sh - load specific cheatsheets'
        '      SCRIPT:   cheatsheets.sh - load specific cheatsheets based
                         on language'\n
    "
    return;
    }
    # [[ "${1}" != "" ]] && { ${FUNCNAME[0]} -h; exit 1; }                            # change to local dev project folder specified
    [[ $# -le 2 ]] && { echo -e "Error!  Usage: \n\t${FUNCNAME[0]} <options> <note> <rating=1,2,3> (where 3 is highest)\n"; return 1; }
}
