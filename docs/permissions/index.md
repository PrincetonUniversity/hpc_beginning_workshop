# Permissions and $PATH

These are two of the most common stumbling blocks to new users of Linux. (And,
for that matter, veteran users.)

## Anatomy of Permissions
Here's an example `ls -al`:
```
[bhicks@adroit3 ~]$ ls -al
total 144
drwxr-xr-x   14 bhicks cses  4096 Apr 12 10:28 .
drwxr-xr-x. 930 root   root 24576 Apr 12 09:46 ..
-rw-r--r--    1 bhicks cses   311 Apr  5 13:49 .persistent_history
drwxr-xr-x    8 bhicks cses  4096 Mar 21 09:36 pkgs
-rw-------    1 bhicks cses    21 Apr 11 10:18 .python_history
-rw-r--r--    1 bhicks cses   148 Mar 28 10:09 run.cmd
drwx------    2 bhicks cses  4096 Jul 20  2016 .ssh
-rw-r--r--    1 bhicks cses   115 Feb  6 14:15 test.R
-rwxr-xr-x    1 bhicks cses    77 Apr 11 10:12 test.sh
drwxr-xr-t    3 bhicks cses  4096 Mar 21 09:30 .texlive2007
-rw-------    1 bhicks cses  5895 Apr 11 10:12 .viminfo
-rw-r--r--    1 bhicks cses   658 Jul 20  2016 .zshrc
```

```
-rw-r--r--    1 bhicks cses   115 Feb  6 14:15 test.R
```

The first several columns pertain to the file permissions. `d` indicates a directory.

It is follow by a burst of three flags `rwx`. These are permissions for the owner
(the first user of the two names listed), the group (the second user), and everyone else.

So in this case, I alone (or the root user!) can read and write this file. My group (`cses`) can read it, and every other logged in user can read it.

## `chmod`
You can change this using the command `chmod`. `touch` a file named `test.txt`,
then `ls -al test.txt`
```
-rw-r--r-- 1 bhicks cses 0 Apr 12 11:00 test.txt
```

Say I wanted to let my group write it, I'd use `chmod` with some flags to make that happen.

`chmod g+w test.text` will make it readable by its assigned group.

`chmod g-w test.text` would take that away.

The syntax is roughly: `chmod <ugo><+-><rwx> path/to/file.txt`
`u` is user, `g` is group, `o`is other. `+` or `-` add/remove permissions and `r` is read, `w` is write, and `x` is write.

You can also specify the permissions using 'Octal' permissions like `chmod 777` which are shorthand ways to specify permissions. (`777` is to be feared as it gives everyone full access to the file!)

## chown
But what if you want to change a file's owner or group? **First, do this with care!** You can render yourself unable to change a file.

The syntax is: `chown user:group path/to/file.txt`

If I wanted to change the group from `cses` to `bhicks`, I could do:

`chown :bhicks test.txt`, but it would fail because the group doesn't exist.

If I were to `chown` another user, they or someone with root access would have to fix it (so I won't show that).

## The `$PATH` variable

To run an executable script or file in a folder, it has to be `+x` for you and you have to specify its path (relative or absolute, even if same folder hence `./myscript.sh`)

So how do utilities and system binaries just run?
