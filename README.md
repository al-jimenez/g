# g()
g is a Bash function - g is a functional alias for git (i.e.: 'g status' = 'git status') and a processor
with option switches for shortcuts of my most commonly used git commands.

## Use
Use this and customize it with your most used git commands.   
I use this as a menu to remind my old man brain what I need to do next an what options I have to execute.

### OS
Used / created for macOS bash but can be modified for other OS.

## Help menu
When you execute g() without parameters you will get the following:
![Help menu](https://github.com/al-jimenez/g/blob/master/g.png?raw=true)

## Special Options

### Update Option
This option performs the following operations:
  1) git add .
  2) git commit -m "<commit message>"
  3) git push (if remote repo defined)

 The commit message can be specified on the command line i.e.:  g u "<commit message>"
 This message will be appended with the stagged filenames, i.e.:  "[a-macbook]:README.md; Updated README.md file"
 Optionaly I have include bash comments with the same code to prepend date and machine name as well.

### Ignore Option
 This option adds a file to the .gitignore file using the following syntax:
  g ignore <filename>

### Git Log Options
 Here are some 'git log' options that I commonly use:

     l | log      = git log --name-status

     1 | 1liner   = git log --oneline

    lf | logfind  = git log --grep <string>     
