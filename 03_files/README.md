# The Bash Command Line

[Table of Contents](/hpc_beginning_workshop/)

## Quick Start

```
mkdir <path/name>              # make directory
cd <path/name>                 # change directory
pwd                            # print working directory
ls                             # list contents of current working directory
ls -l                          # same as "ls" but with long format
cd ..                          # change directory to the parent directory
rm -rf <path/name>             # remove the directory and all its contents
cp file1 file2                 # create a copy of a file
cp -r <path/dir> .             # copy <path/dir> to the current directory
mv <path/name> <path2/name2>   # move <path/name> to <path2/name2>
touch <name>                   # make an empty file called <name>
```

Below is an example session using the commands above:

```
ssh <YourNetID>@adroit.princeton.edu

[jdh4@adroit4 ~]$ mkdir research

[jdh4@adroit4 ~]$ ls
research

[jdh4@adroit4 ~]$ cd research

[jdh4@adroit4 research]$ pwd
/home/jdh4/research

[jdh4@adroit4 research]$ cd ..

[jdh4@adroit4 ~]$ pwd
/home/jdh4

[jdh4@adroit4 ~]$ cd research

[jdh4@adroit4 research]$ ls -l
total 0

[jdh4@adroit4 research]$ touch file1

[jdh4@adroit4 research]$ ls
file1

[jdh4@adroit4 research]$ cd ..

[jdh4@adroit4 ~]$ pwd
/home/jdh4

[jdh4@adroit4 ~]$ mkdir software

[jdh4@adroit4 ~]$ cd software

[jdh4@adroit4 software]$ pwd
/home/jdh4/software

[jdh4@adroit4 software]$ mkdir mycode

[jdh4@adroit4 software]$ mkdir scripts

[jdh4@adroit4 software]$ ls -l
total 0
drwxr-xr-x. 2 jdh4 pustaff 10 Sep 16 09:56 mycode
drwxr-xr-x. 2 jdh4 pustaff 10 Sep 16 09:56 scripts

[jdh4@adroit4 software]$ cd mycode

[jdh4@adroit4 mycode]$ ls -l
total 0

[jdh4@adroit4 mycode]$ touch myprogram

[jdh4@adroit4 mycode]$ ls -l
total 0
-rw-r--r--. 1 jdh4 pustaff 0 Sep 16 09:57 myprogram

[jdh4@adroit4 mycode]$ pwd
/home/jdh4/software/mycode

[jdh4@adroit4 mycode]$ cd ..

[jdh4@adroit4 software]$ pwd
/home/jdh4/software

[jdh4@adroit4 software]$ ls -l
total 0
drwxr-xr-x. 2 jdh4 pustaff 31 Sep 16 09:57 mycode
drwxr-xr-x. 2 jdh4 pustaff 10 Sep 16 09:56 scripts

[jdh4@adroit4 software]$ rm -rf scripts

[jdh4@adroit4 software]$ ls -l
total 0
drwxr-xr-x. 2 jdh4 pustaff 31 Sep 16 09:57 mycode

[jdh4@adroit4 software]$ cd ~

[jdh4@adroit4 ~]$ pwd
/home/jdh4

[jdh4@adroit4 ~]$ ls -R
.:
research  software

./research:

./software:
mycode

./software/mycode:
myprogram
```

Here are some more advanced commands to try:

```
cat <file>              # output contents to terminal
which <command>         # show path of command (e.g., which gcc)
env                     # list all environment variables/settings
echo $USER              # print contents of shell variable USER
ehco $PATH              # print contests of shell variable PATH
wget <url>              # download file from the internet
history                 # see a list of recent commands
```

Bash is one of the most common shells in the POSIX (i.e. Unix standard) world.
Its name stands for Bourne Again SHell, named after the original Bourne
shell (`/bin/sh`).

A shell is just a common interface for interacting with an operating system
and carrying out commands. Windows computers use DOS shell prompts to interact
with the system to this day, even though DOS is long gone.

The notes for this are taken from one of my own repos [here](https://github.com/bwhicks/bash-notes)

## Anatomy of a Linux file system
At its heart, a Linux (or for that matter) file system maps sectors on the hard
drive to the files we use.

The gory details are beyond our scope. Instead, we need to think about how this works.

The base of a file system in a POSIX world is `/`, root. Every other thing mounted
to the file system attaches to root in some way.

There are two ways to express a location. One is the absolute way. That defines
a path all the way down from root. For example `/home/bhicks` on Adroit is my
home directory. Read it right to left: home is a subdirectory of root, bhicks is
a subdirectory of home.

The other is called a relative path. This is a short hand way for working with
the system to be explained momentarily.

## Always use 'man'. Always
One of the most useful commands you should probably learn before even basic
file operations is the most straightfoward -- 'man'

Syntax:

```bash
man <command>
```
It will give a printout of a particular system command's usage
(or really any program that has manual documentation) to the terminal window

A shortened version of the output of `man ls` is here:
```
LS(1)                     BSD General Commands Manual                    LS(1)

NAME
     ls -- list directory contents

SYNOPSIS
     ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]

DESCRIPTION
     For each operand that names a file of a type other than directory, ls dis-
     plays its name as well as any requested, associated information.  For each
     operand that names a file of type directory, ls displays the names of files
     contained within that directory, as well as any requested, associated infor-
     mation.

     If no operands are given, the contents of the current directory are dis-
     played.  If more than one operand is given, non-directory operands are dis-
     played first; directory and non-directory operands are sorted separately and
     in lexicographical order.
```

Most entries describe the command's basic function, give a listing of its operands
(usually prefixed by `--` or `-`) and then what it takes as an input.

So from that, we learn that `ls` lists the contents of a directory.

## Getting around the file system

When you first open a terminal, you will probably be dropped off in your home directoy,
often abbreviated by a `~`. POSIX systems all use forward slashes to mark directory
structure. (Directories are like the folders you see in a graphical interface.)

For example:
```
/ denotes the root directory
/home/ marks a directory under the directory /
/home/user marks a directory under /home
```

Prompt for my home directory on a server called della is something like this:
```
[bhicks@della4 ~]$
```
The `$` is just shell speak for 'Ready to start a new command sequence, and you're not root' (Root gets `\#` usually)

Let's look around, shall we? If you see a command here, run its 'man' to get a
full listing. It's habit building. In a good way.

### Looking around - `ls` and `pwd`
`ls` gives you the structure of a directory and its files.

Without any arguments, it will return any non-hidden files in your current directory.

```
[bhicks@della4 ~]$ ls
output.out  R  R-benchmark-25.R  R-benchmark-parallel.R  Rmpi_0.6-6.tar.gz  submit.cmd
```

This shows me a list of files in the current directory, but not much else.

A useful common set of operands are `ls -al`:
```
[bhicks@della4 ~]$ ls -al
total 248
drwxr-xr-x  12 bhicks cses   4096 Nov  7 14:59 .
drwxr-xr-x 758 root   root  20480 Nov  7 14:24 ..
-rw-------   1 bhicks cses  11732 Nov  7 15:16 .bash_history
-rw-r--r--   1 bhicks cses     18 Jul 20 11:16 .bash_logout
-rw-r--r--   1 bhicks cses    192 Nov  7 13:07 .bash_profile
-rw-r--r--   1 bhicks cses    231 Jul 20 11:16 .bashrc
-rw-r--r--   1 bhicks cses   1448 Oct 27 13:12 .c
drwx------   6 bhicks cses     84 Sep  6 08:58 .cache
drwxr-xr-x   3 bhicks cses     40 Aug  2 11:57 .conda
drwxr-xr-x   3 bhicks cses     44 Sep  6 09:07 .config
-rw-r--r--   1 bhicks cses     37 Oct 27 12:13 .gitconfig
-rw-r--r--   1 bhicks cses    172 Jul 20 11:16 .kshrc
drwx------   5 bhicks cses     51 Aug  2 08:59 .local
drwxr-xr-x   3 bhicks cses     55 Sep  6 09:06 .matplotlib
-rw-r--r--   1 bhicks cses  10432 Oct 27 13:12 .o
-rw-r--r--   1 bhicks cses    422 Nov  7 14:58 output.out
drwxr-xr-x   2 bhicks cses     28 Aug  2 12:29 .pip
drwxr-----   3 bhicks cses     26 Sep  6 08:56 .pki
drwxr-xr-x   3 bhicks cses     44 Nov  4 12:27 R
-rw-r--r--   1 bhicks cses  13666 Dec  2  2012 R-benchmark-25.R
-rwxr-xr-x   1 bhicks cses   3052 Nov  7 14:21 R-benchmark-parallel.R
-rw-r--r--   1 bhicks cses 105181 Jun  2 09:11 Rmpi_0.6-6.tar.gz
-rw-r--r--   1 bhicks cses     48 Nov  4 12:26 .R.Rout
-rwxr-xr-x   1 bhicks cses  11429 Oct 27 13:12 .so
drwx------   2 bhicks cses     24 Sep 27 14:40 .ssh
-rw-r--r--   1 bhicks cses    378 Nov  7 14:58 submit.cmd
drwxr-xr-x   2 bhicks cses     31 Oct 27 11:17 .vim
-rw-------   1 bhicks cses   5282 Nov  7 14:59 .viminfo
-rw-------   1 bhicks cses     50 Sep  6 09:02 .Xauthority
```

This looks like a lot of obtuse information, but it tells me 1) all the files, including
'hidden' dotted files like my .bashrc that helps set initial variables for a Bash session 2) shows size in B (add `-alh` to get a more useful set of values there) and 3) the
permissions of each file, but that's a topic for later.

I still don't know what the absolute file path for the directory is. In this case,
`pwd` is the ticket. It prints the working directory to the console.

```
[bhicks@della4 ~]$ pwd
/home/bhicks
```

Now I know that `~` is a shorthand way of writing `/home/bhicks`.

## You are now free to move about the file system - `cd`

I know where I am. Now how do I get where I'm going? `cd` is the command to change the working directory in a POSIX environment.

The basic syntax is `cd <new directory>`. But here we can get into what those `.` and `..` at the top of a directory listing mean.

`.` marks the current directory and its permissions.
`..` marks the directory above.

You can use these as a quick shorthand in many cases.

If I were in `/home/bhicks` then `cd ..` would move me to `/home`. You can keep doing this, or even chain them. From `/home/bhicks` `cd ../..` would move me to ``/``.

You can also use `cd` to move to an absolute or relative path. An absolute path is a path written from root down (`/var/www/public_html/images/cat_gifs`). A relative path is written from the current directory (if your working dir was `/var/www`, then `cd public_html/images/cat_gifs` would get you to the same directory as the absolute path above).

It's worth noting that this distinction applies to any command where you supply a file name for execution. `cp /home/bhicks/interlac_dict.txt /home/fnord/` and `cp interlac_dict.txt /home/fnord` would work equally well--if my working directory were `/home/bhicks`.

## Making a new folder - `mkdir`

The aptly named `mkdir` will make a directory. The syntax is `mkdir <directory name>`. It has a few quirks.

Let's say I'm in my home directory and want to make a folder and a folder beneath it.

```
~ $mkdir work
~ $mkdir work/Mon
```

Great! The folders `~/work` and `~/work/Mon` now both exist.

So, you might think, 'I bet I can just do `mkdir work/Mon` to save a step.' But you'll get this if you're starting from scratch.

```
~ $mkdir work/Mon
mkdir: work: No such file or directory
```

Sounds like a Monday. In any case, `mkdir` can't make the subdirectory because the directory doesn't exist.  However: `mkdir -p work/Mon` works like a charm. The `-p` flag creates subdirectories recursively.

You can combine this with the `{}` braces selector to do some neat tricks. `mkdir -p work/{Mon,Tues,Wed,Thurs,Fri}` will create `work/` and then the named subdirectories below, all in one shot.

# Working with Files

## A Word about Files in Unix

In the world of UNIX systems (Linux, MacOS, FreeBSD, etc.), files are really only of two types: 1) Binary and 2) Text.
This philosophy carries through to the commandline also. You can think of the BASH shell as a way of working with files that
are often nothing more than a stream of text.

## Copying a file - `cp`

`cp` is a command that lets you, well, copy a file. The syntax is relatively straightfoward but it does have a few
useful flags to know.

`cp <file> <newfile>` is the basic syntax. The file can be given as a relative path or an absolute one (see [Directories](Directories.md) if this doesn't make sense).


`cp` also supports wildcard expansion, so the characters `*` and `{}` both have special meanings.

If you wanted to copy all the files in one directory, for example:

```
~/foo $pwd
/Users/benjaminhicks/foo
~/foo $ls -al

total 0
drwxr-xr-x    6 benjaminhicks  staff   204 Nov 28 12:37 .
drwxr-xr-x+ 130 benjaminhicks  staff  4420 Nov 28 12:37 ..
drwxr-xr-x    2 benjaminhicks  staff    68 Nov 28 12:40 bar
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:37 file1
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:37 file2
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:37 file3

~/foo $cp * bar/
cp: bar is a directory (not copied).
~/foo $ls -al bar/

total 0
drwxr-xr-x  5 benjaminhicks  staff  170 Nov 28 12:42 .
drwxr-xr-x  6 benjaminhicks  staff  204 Nov 28 12:37 ..
-rw-r--r--  1 benjaminhicks  staff    0 Nov 28 12:42 file1
-rw-r--r--  1 benjaminhicks  staff    0 Nov 28 12:42 file2
-rw-r--r--  1 benjaminhicks  staff    0 Nov 28 12:42 file3
```

Since we didn't use recursion, you'll note that the wildcard `*` also selected bar underneath. By default
it matches ANY character. To avoid this (and also some potentially hilarious recursion loops if you just
say directories are OK using `-r`), you can be more targeted.

In this instance `cp file* bar/` would work very well. You could also use `cp {file1,file2,file3} bar/`
since `{}` with commas and no spaces as separators gets expanded into running `cp file1 bar/ cp file2 bar/`, etc.


A few important flags:
* `cp -r` - This sets `cp` to copy recursively, i.e. it lets you copy an entire directory and all the subdirectories below it.
 - For example: `cp -r foo/ bar/` would copy the entire directory `foo/` and all its subdirectories and files to `bar/` relative to your working directory.
* `cp -rp` or `cp -a`:
 - Similar commands, these are recursive AND ensure that the files are copied with the same owner and permissions. `cp -a` combines all of these and preserves some Linux security features.

## Moving a file - `mv`

`mv` moves a file, which in UNIX-land is also how you rename a file.

The basic syntax is `mv <source> <destination>`, in any format, relative or absolute that is valid.

`mv` is incredibly powerful and if you're moving around a lot of files will let you pull out some
really annoying problems. Once you're used to it, it's also much quicker than lassoing files with a mouse.

It can also end up sending files willy-nilly. Most operating system files are protected and require superuser privileges to edit or move files in certain protected directories,
so unless you use `sudo`, you're unlikely to bring down your system. You
just might move some files somewhere annoying, however, so be careful.

The wildcard selector `*` and braces `{}` are both supported, too, huzzah!

Suppose you had a tremendously messy directory and needed to get all the text files out and put them elsewhere.

```
~/junkdrawer $pwd
/Users/benjaminhicks/junkdrawer
~/junkdrawer $ls -al
total 0
drwxr-xr-x   19 benjaminhicks  staff   646 Nov 28 12:56 .
drwxr-xr-x+ 131 benjaminhicks  staff  4454 Nov 28 12:54 ..
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 1.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 1.useful.txt
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 10.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 11.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 12.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 2.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 2.useful.txt
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 3.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 3.useful.txt
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 4.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 4.useful.txt
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 5.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 5.useful.txt
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 6.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 7.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 8.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 9.spam
~/junkdrawer $mkdir useful_text
~/junkdrawer $mv *.txt useful_text/
~/junkdrawer $ls -al
total 0
drwxr-xr-x   15 benjaminhicks  staff   510 Nov 28 12:57 .
drwxr-xr-x+ 131 benjaminhicks  staff  4454 Nov 28 12:54 ..
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 1.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 10.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 11.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 12.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 2.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 3.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 4.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 5.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 6.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 7.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 8.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 9.spam
drwxr-xr-x    7 benjaminhicks  staff   238 Nov 28 12:57 useful_text
~/junkdrawer $ls -al useful_text/
total 0
drwxr-xr-x   7 benjaminhicks  staff  238 Nov 28 12:57 .
drwxr-xr-x  15 benjaminhicks  staff  510 Nov 28 12:57 ..
-rw-r--r--   1 benjaminhicks  staff    0 Nov 28 12:56 1.useful.txt
-rw-r--r--   1 benjaminhicks  staff    0 Nov 28 12:56 2.useful.txt
-rw-r--r--   1 benjaminhicks  staff    0 Nov 28 12:56 3.useful.txt
-rw-r--r--   1 benjaminhicks  staff    0 Nov 28 12:56 4.useful.txt
-rw-r--r--   1 benjaminhicks  staff    0 Nov 28 12:56 5.useful.txts
```

The wildcard selector grabbed all the files that ended in .txt and then `mv` shunted them to the directory we made called `useful_files`.

The same flags `-r` and `-rp` and `-a` all apply to `mv` just as they did to `cp`. This is also how you rename a directory.

In the example above, `mv -r useful_text/ new_text/` would rename the directory to `new_text`

## Deleting a file - `rm`

### Caution
The `rm` command does NOT come with an undo. If you delete and don't have a backup, it's gone short of using a hard disk recovery tool and hoping the deleted blocks don't get overwritten. Be careful. If you use `sudo` be very, very careful. If someone tells you to `sudo rm -rf /*`, they're playing an old prank
involving deleting the subdirectories of the system root. Many modern Linux distros will prevent this,
as will MacOS, but just don't.

On systems supported by OIT or Research Computing, your `/home` directory (and
certain other directories on the `/tigress` file system) will be backed up
and you can request restores by emailing `cses@princeton.edu` for RC systems.

`rm`, as the caution above indicates, deletes files. Without flags, it will on
ly delete files not directories, but it does accept the standard `*` and `{}` operators.

The syntax is `rm <file or list of files>`

On some systems, the `rm` command is re-aliased to `rm -i`. This is a nicety because it forces you to say yes or no to file deletions. On many, it is not so aliased and it will delete files aggressively and silently. If you're not sure what your `rm` is going to do, `rm -i` is useful to keep you from nuking files youwould really rather have.

Continuing from the example above, if I wanted to get rid of all the .spam files:

```
~/junkdrawer $ls -al
total 0
drwxr-xr-x   15 benjaminhicks  staff   510 Nov 28 12:57 .
drwxr-xr-x+ 131 benjaminhicks  staff  4454 Nov 28 13:00 ..
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 1.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 10.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 11.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 12.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 2.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 3.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 4.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 5.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 6.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 7.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 8.spam
-rw-r--r--    1 benjaminhicks  staff     0 Nov 28 12:56 9.spam
drwxr-xr-x    7 benjaminhicks  staff   238 Nov 28 12:57 useful_text
~/junkdrawer $rm *.spam
~/junkdrawer $ls
useful_text
~/junkdrawer $
```

Now, let's say I wanted to get rid of the whole junkdrawer folder. Here you'll need to use the familiar `-r` flag.

```
~/junkdrawer $cd ..
~ $rm -r junkdrawer/
```

I moved up one directory using `cd ..` and then `rm -r junkdrawer/` removed the folder and all its subfolders.

Some useful flags:

`rm -f` (and combinable as `rm -rf`) - These delete a file (or files/directories with `-r`) and also override any prompts for confirmation. This is a bulldozer. Aim carefully.

## `history` (and the up arrow) and tab completion

A handy trick that you may find yourself using is the `history` command. It lists
Your most recent commands, can be searched (`history | grep searchterm`) and
you can invoke a command in it by typing its number with a `!` in front: `!150`
 (for example).

You can also scroll through this one by one in many terminal programs by pressing
up.

Another time saving trick is tab completion. In many terminal clients, pressing
`tab` while writing out a file path will try to complete as much as of it as
possible and can save some precious seconds (and typos).
