# Utilities you can use

[Table of Contents](/hpc_beginning_workshop/)

## Getting files places

(Windows users can use their local system's FTP or PuTTY comes with pscp with similar syntax, just using Windows `\` notation for directories from drive letter).

Say you have a Linux/Mac system and need to get a file or folder to the cluster. `scp` uses SSH to move a file.


```
cd ~
mkdir test_dir/
touch test_dir/{file1,file2,file3}
ls -al test_dir/

scp -r test_dir bhicks@adroit:.
```
This copies test_dir (as one unit, with the files underneath pulled in too) to adroit. The syntax is the '-r' flag to move the folder recursively (i.e. folder and sub-files and folders) the path to copy from and the path to copy to, prepended with my user and login. `.` says "Wherever your shell start on login", which happens to be home.

You can reverse that to get the file back to your local machine. For many, many files, you may want to zip or tar them using the utility of your choice and move them that way.

For more advanced use cases, you should look into `rsync` (a powerful utility
for transferring many files with the potential to resume a broken connect) or
for very large sets that can be access through Globus, the university provides
[such as service](https://www.princeton.edu/researchcomputing/services/globus_description/).

## Princeton specific `modules`
All of the clusters run Springdale, a build of Linux that tracks along with the releases of Redhat (currently either 6 or 7).

Solution: Springdale is very stable and has stable packages built in.

Problem: It also means packages are hard to update, especially for things that have many versions.

Hence `module avail`. This lists all of the available modules that you can optionally load into your environment.

For example, to install a Python package to your home dir (the preferred site for anything custom)

```
module load anaconda
pip install --user django
```
This will install the web framework kit 'Django' to your local environment and you can use it anytime you module load `anaconda`. Anaconda also comes with many pre-built scientific packages, so you may not need to install anything.

Anaconda is also itself a full-fledged Python environment, with the capacity to
create virtual environments using the `conda` command, but that is outside the
scope of a this introductory course. See instead the [conda getting started](https://conda.io/docs/user-guide/getting-started.html), especially
the sections on managing environments, as that is what you might primarily use
on the Princeton clusters.

`module load` also lets you access math libraries (like OpenBLAS and MKL), different versions of compilers for parallel processing (Intel and OpenMPI for example), and different versions of `gcc`.

## Basic Linux utils
The terminal window, running BASH or another shell, is essentially a stream of text. It sends input and output to two basic 'pipes', `stdin` and `stdout`. `stdout` is what you see when you run a command.

`stderr` is often where messages are passed for errors. It too will put in an appearance on the commandline.

`stdin` is data that's piped to a program. More on this later.

On the terminal, you have control over where these outputs go--be that another program, a file, or nowhere at all.

This is where the magic happens. But first...



## Making a dummy file - `touch`
If you've wondered why many of my examples have empty files, that's because I created them using the `touch` command. It well, touches a file. Like the scene from E.T. but much less moving. This creates an entry
in the file system and a blank (text) file.

`touch <filename and path>` is pretty straightforward. You can also use Bash scripting tricks to do more
complicated things, but this program is just worth a mention.

## Redirecting and piping - `>`, `<`, `|`
These characters let you tell the shell what to send where.

### `OUTPUT > file`

The `>` character lets you redirect `stdout` to any file. If you type `ls -alh > dir_listing.txt`, for eample, you'll make a file named dir_listing.txt in your working directory that has the output of the `ls`.

This lets you pull off really interesting short hand ways of doing things. Say, for example, you have a
pile of text documents that you need to combine into one. You can use the `cat` command, which conCATenates files, to combine them into one using `>`.

If the files all happened to end in .txt, you could do `cat *.txt > combined.txt`. The new file would have the contents of all files whose names end in .txt in your current working directory.

This creates the file or overwrites it if it does exist.

`>>` changes the mode to make it append to the file if it does exist.

### `COMMAND  < file `

This takes a file and pushes it to a command. Many commands take file arguments and shorthand this, but you can always do it expressly.


### Complex redirects
You can also use these commands to redirect the terminal output too. This can be useful for keeping logs
or silencing a command you'd just as soon not see the output of.

`1` is the number for `stdout` and `2` is the one for `stderr`.

`1>filename` redirects `stdout` to `filename`
`2>filename` does the same thing for `stderr`

`2>&1` redirects `stderr` to `stdout` and you can then dump the whole shebang. You'll usually append this modifier after the command.

`blah > output_log 2>&1` will produce a file named `output_log` that will gripe about there not being a `blah` command.

If you want to silence output entirely, `blah > /dev/null 2>&1` will send the output to the null device,
a round-about way of saying 'toss the whole thing, I don't care'.


### Down the pipe - `|`

The most useful tool you'll encounter is the `|`. This pipes the standard output of one program to another (`2>&1` at the end of your command will redirect `stderr` too).

Why would I want to do this? An excellent example is the `find` command. Without going into its complex
(and implementation specific) syntax, `find .` would start in your current directory and recursively list every single file (throwing errors for files you don't have permission to read).

Not hugely useful as a search, but you can then pull out the handy-dandy tool of the Unix world: `grep`.

The name is somewhat useless, but its basic purpose is this: to search for a pattern in a file OR stream
you specify.

I do a lot of work on a Roman author named Pliny. Let's say I totally forgot this fact and wanted to find every file, folder, and subfolder in my home dir that used his name .

I'd `cd ~`, then run `find . | grep pliny`. By default, grep returns any line where it finds a match for the regular expression (long story, to be explained later) I feed it.

Now, if I wanted to keep this list: `find . | grep pliny > search.txt`. You could also do this with `find` without `grep`, but sometimes you can't be bothered with the syntax.

# Utilities for working with files

Listed below are an entirely non-comprehensive list of utilities you can use to do useful things with files. Many rely on a concept discussed below called a 'regular expression'. If you aren't familiar with these, I have linked some explanations of different regex flavors and implementations.

Others are just useful for watching processes and files.

## Regexes

Regular expressions are a shorthand way of telling a scripting language (or really any language) or utility 'look for this match'.

This can be very useful for finding a line that matches and deleting it, finding and replacing text (your word processor's find and replace is a much more use friendly but often less powerful version of this), etc.

Many programming languages have their versions of the regex, all of which tend to look similar but have different features. If you need highly complex regex, you're probably better moving to a scripting language like Python, PHP, or Javascript--or even a data science tool like R.

The two BASH tools I'll discuss that use regexes to great benefit are `grep` and `sed`.

The less than newbie friendly guide to regexes for the two programs are linked here:

[`sed` regexes](https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html)

[`grep` regexes](https://www.cyberciti.biz/faq/grep-regular-expressions/)
	Note: This site also explain the difference in `grep -E` and `grep -F`, which on old systems are sometimes different commands.

[`grep` regex checker](https://www.online-utility.org/text/grep.jsp)

## Checking what you did - `history`

`history` is a highly, highly useful command. It prints the contents of the hidden file `.bash__history` (usually in `~`) to the console along with a list of numbers.

You can shortcut this for the previous command without typing anything by just pressing the up arrow. Rinse and repeat the command.

But say you wanted to do this for something 50 back? You could hit up 50 times, or you cann call `history` and note the number. Then at a new terminal just type `!number` where number is the number of the command. It will be printed to the command line to be used again!

You can also pipe history output to `grep`, which I go into more detail later, but this is an easy usage:

Say I wanted to know 'When was the last time I ran a script named "manage.py"?'

`history | grep manage.py` would search my user history and return any lines that had
"manage.py" in them, matched strictly.


## Looking at text - `less`, `head`, and `tail`

You might find yourself wanting a look at a file, but not wanting to fire up a text editor like `vim` (often aliased to `vi`)  or `nano`. You could `echo` or `cat` the file to the terminal, but you can't scroll or search that, which makes it somewhat worthless.

Here are some options:

### `less` isn't `more`

The history of this commandline utility is somewhat beyond confusing. It postdates `more`, which was a less flexible version of the pageing utility (i.e. utilities that take text and paginate it for display), but it predates the less common utility `most`. To quote the [Slackware Linux Essentials Guide](http://www.slackbook.org/html/file-commands-pagers.html): 'If `less` is more than `more`, `most` is more than `less`.

If your platform has `most` installed, it's worth looking through the `man` page and learning about it. It lets you open multiple file buffers at once, among other niceties.

`less` is the goto pocket-knife here.

The syntax is simply `less <filename>`, i.e. `less myfile.html`

This will open any file, but of course a binary file (vs. HTML, XML, text documents, etc.) will just be gibberish.

`less` will take over your terminal and let you scroll up and down in the buffer. You can use `q` to quit and `:` to start command sequences. `:/regex` will let you search for a word in the file you've opened.

The `man` page goes into much greater detail as to manuevering `less`. It is very handy.

### `head`

`head` show the first few lines of file. Use `man` if you want more.

### `tail`

`tail` shows the last few lines of a file. Look at `man`, but the classic use is with the
`-f` flag for a log file you want to monitor. `tail -f filename` displays the file and updates when anything is appended to its end.

If you want to filter the file, you can use `grep` explained below to pipe the output.

`tail -f /var/log/messages | grep 'foo'` would only show appended lines with `foo` in them.

## `grep`

Don't worry [about the name](https://medium.com/@rualthanzauva/grep-was-a-private-command-of-mine-for-quite-a-while-before-i-made-it-public-ken-thompson-a40e24a5ef48#.utcb6warr). `grep` is amazing and it will revolutionize how you look at files.

Its usage is really beyond this basic overview, so I've included a strong tutorial below:

[Using Grep & Regular Expressions - DigitalOceans](https://www.digitalocean.com/community/tutorials/using-grep-regular-expressions-to-search-for-text-patterns-in-linux)

One thing to note is that `grep` typically includes the functionality of some old utilities called `egrep` and `fgrep`, which expand on its capacities. You'll often want to use the `-E` flag (not to be confused with `-e`).

`grep` will take a regular expression and return any line in the file that matches the expression.

A rough rundown on some regular expression tricks for grep without the extended functionality.

`grep "foo" file` would find any line that has 'foo', in it, regardless of position.

Metacharacters that flag positional info or unknown characters can help expand the functionality.

For example, `grep "^FOO" file` would find every line starting with FOO. `grep "FOO$" file` would return every line that ended with FOO.

You can also specify character ranges using `[]`, i.e. `[A-Z]` would match all the upper-case characters.

Metacharacters can also specify how often a pattern can repeat.

`grep "(.*)" file` would mean find any character `.` (`.` is a meta character that means match anything) between `()` and then do so as often as possible `*`. Thus any text between () would create a match.

(N.B. Want to make a literal `.`? `\.` "escapes" the period and treats it as literally a period.)

Grep also respects a huge number of backlash special characters and expressions. There are sufficiently many of them that I suggest you look [here](https://www.gnu.org/software/grep/manual/grep.html#The-Backslash-Character-and-Special-Expressions). Some require invoking the `-E` flag.

Regular expressions are an art. They also often have the same problems to solve, so googling for a regex to do a particular thing will find something.

The `-E` flag lets you do even more complex things like grouping regexes, providing alternate matches, etc.

`grep -E "(foo|bar)" file` would match "foo" OR "bar". Note that the parentheses are special characters when `-E` is invoked.

As noted above, python, perl, PHP, etc. all have versions of the regex, and they often linclude much more functionality and more online support for checkers.

But `grep` is widely available and doesn't require extra framework in the code.

## Editing streams - `sed`

`sed` is a utility called a stream editor. It takes a stream of text, pulled from a file or `stdout` via `|`.

What makes it fantastic is that you can use basic regexes (so no grouping, none of the special characters, unfortunately) to edit a stream.

It is also very feature rich, so I commend Bruce Barnett's [introduction](http://www.grymoire.com/Unix/Sed.html) to you.

The basic usage is this
`sed <commands and regex> filename`

This will perform the commands you request on the filename and w/o flags specifying otherwise output the result to the terminal. So you need to either use flags to make `sed` write the file OR use something like `>` or `|` to send the output to a file or command.

`-e` passes a script with commands to `sed` on the commandline

`sed -e s/foo/bar/g file` would output `file` with all instances of `foo` with `bar`.

`s/` invokes substitution with a regex (here the literal `foo`), and then `g` makes the replacement global throughout the line (otherwise only the first instance is replaced!).

An easier example:

`sed -e "1,11d" file` deletes the first 11 lines of a text.

If you want to edit a file inline:
`sed -i.bak -e "s/foo/bar/g" file` actually writes changes to the file and backs up the original to file.bak.

Again, very powerful, not utterly user friendly.
