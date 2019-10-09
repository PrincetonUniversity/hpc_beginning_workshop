# Connecting to a cluster

<!--[Table of Contents](/hpc_beginning_workshop/)
-->

## A few caveats
These instructions assume you are:
  1. Princeton University faculty, student, or staff
  2. Are connecting from the campus wireless for Adroit (or through Nobel)
  3. Are connecting from the campus VPN or a wired connection for Tigress systems
  (or through Nobel).
  4. Are connecting with Duo Authentication
  5. Have an account on the system you're looking to connect to. You can register for
  [Nobel](https://www.princeton.edu/researchcomputing/computational-hardware/nobel/usage-guidelines/)
  and [Adroit](https://forms.rc.princeton.edu/registration/?q=adroit)
  here. (Note: You will need to login using your university credentials).

## SSH
In order to connect to the university computing clusters, you will need an SSH
(secure shell) client.

On MacOS and Linux, the default terminal application has such a client built-in.
No download is necessary!

On Windows machines, you'll need a client. One option is [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) and another is [Mobaxterm](http://mobaxterm.mobatek.net/).

Regardless, you'll need to know a few things:

1. Server (host) address
  * For Adroit, if you're on the university's
  wifi (puwireless) or wired, simply `adroit` will do.
2. Your NetID and password
  * **N.B.** This may be different than your email if you use an alias.

## Using Terminal as an example

Once you launch an instance of Terminal, you'll be at a command prompt *on your local
machine* that looks something like this:
```
benjaminhicks ~/hpc_beginning_workshop $
```
The `$` is an indication that you're ready to enter a command.

To connect to adroit, I'd type something like this and hit enter:
```
nat-oitwireless-inside-vapornet100-c-14666:hpc_beginning_workshop bhicks$ ssh bhicks@adroit.princeton.edu
Warning: the ECDSA host key for 'adroit.princeton.edu' differs from the key for the IP address '128.112.128.32'
Offending key for IP in /Users/bhicks/.ssh/known_hosts:88
Matching host key in /Users/bhicks/.ssh/known_hosts:115
Are you sure you want to continue connecting (yes/no)? yes
Password:
Duo two-factor login for bhicks

Enter a passcode or select one of the following options:

 1. Duo Push to XXX-XXX-3224
 2. Phone call to XXX-XXX-3224
 3. Phone call to XXX-XXX-8335
 4. SMS passcodes to XXX-XXX-3224 (next code starts with: 1)

Passcode or option (1-4): 493203
Success. Logging you in...
Last login: Wed Oct 10 09:12:28 2018 from nat-oitwireless-outside-vapornet3-l-14.princeton.edu
[bhicks@adroit4 ~]$
```

I'm now remotely connected to adroit3, which is the head node of the cluster! The
shell I used in both cases is one called [Bash](https://www.gnu.org/software/bash/).
It's a particular command line interface that is common across Unix-alike machines.


## Duo Authentication

All of the clusters from both on campus and off campus now require two factor
authentication via Duo. If you need help getting this set up, contacting the
[OIT Support and Operations Center](http://www.princeton.edu/oit/)
will be your best course of action. You can also see OIT's resoures for using
Duo [here](https://princeton.service-now.com/snap/?id=kb_article&sys_id=692a27064f9ca20018ddd48e5210c72b).

Upon connecting, you can request a push to a cell phone application, a text with
a passcode, or you can enter a generate pass code with a soft key created by the
Duo application on your cell phone.

If you use a system that respects a standard `~/.ssh/config`, you can use the
[solution outlined on AskRC](https://askrc.princeton.edu/question/331/how-do-i-avoid-having-to-authenticate-with-duo-every-time/)
 to setup SSH Multiplexing.

## Getting files to Adroit

One of the most frequently asked questions is how to get files to Adroit or a cluster.
Again, Linux/MacOS has an answer out of the box, but clients like PuTTY and Mobaxterm
OR FTP clients like [WS_FTP](https://www.ipswitch.com/secure-information-and-file-transfer/wsftp-client) (paid, sadly) or [Filezilla](https://filezilla-project.org/). In both cases,
make sure you're using interactive logon. Filezilla especially can be a pain
with Duo Authentication for Nobel, but we have some tips [here](https://askrc.princeton.edu/question/343/how-do-i-get-filezilla-to-work-around-duo/)

If you're transferring a lot of files, consider
zipping them.

The default client to transfer files is `scp`. This is a copy command that uses
SSH to copy files. I'll discuss its use at greater length when [talking about the
command line utils](/hpc_beginning_workshop/util/).


## <a name="tmux">Staying connected (tmux)</a>

This comes up very frequently when you're connected to Nobel, where tasks are
run directly from the command line rather than the SLURM scheduler. If your
shell is disconnected, the command you're running terminates. This is bad.
A built in solution to most Unix-alike OSes is `nohup` but it's of limited utility.

Hence we bring in something like [tmux](https://www.ocf.berkeley.edu/~ckuehl/tmux/).
It comes installed on all university clusters, and it lets you start a shell
session that rather than being remote via SSH, lives on the server.

A simple use case would be

```
tmux
(press ctrl-b then release both keys then press d to detach the session)
tmux attach
# to exit tmux press ctrl+b then release both keys and then : and type kill-session
```

You would then be attached back to the session you created by default when you called tmux.
To close a session,
just `exit` or `ctrl+d`. These sessions will remain until the server is rebooted or you
close them. Anything you run while attached to the session runs in that session,
and therefore it is safe from a disconnect.

On Nobel, you'll want to look in the lower left. Nobel has two hosts, `compton`
and `davisson`, and the session will live on one or the other. To find it again after
a disconnect, you'll need to login directly to them rather than just `nobel`, i.e.
`ssh compton.princeton.edu`. Otherwise you'll do `tmux attach` and not find your
session.

`tmux` is a powerful and complex tool. In addition to the simple guide linked above,
you might see the following:

- [tmux - a very simple beginner's guide](https://www.ocf.berkeley.edu/~ckuehl/tmux/)
- [Beginner’s Guide to Tmux ](https://www.codementor.io/bruno/beginner-s-guide-to-tmux-recommended-configuration-plugins-and-navigation-demo-aih7o7ktw) (Feel free to ignore the installation as it's already on
the clusters, unless you want to run this on your Mac!)
- [A tmux primer](https://danielmiessler.com/study/tmux/)
