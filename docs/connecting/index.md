# Connecting to a cluster

## A few caveats
These instructions assume you are:
  1. Princeton University faculty, student, or staff
  2. Are connecting from the campus wireless or
  3. Are connecting from the campus VPN
  4. Are connecting with Duo Authentication for Nobel
  5. Have an account on the system you're looking to connect to. You can register for

  [Nobel](https://www.princeton.edu/researchcomputing/computational-hardware/nobel/usage-guidelines/)
  and [Adroit](https://www.princeton.edu/researchcomputing/computational-hardware/adroit/registration/)
  here. (Note: You will need to login using your university credentials).

## SSH
In order to connect to the university computing clusters, you will need an SSH
(secure shell) client.

On MacOS and Linux, the default terminal application has such a client built-in.
No download is necessary!

On Windows machines, you'll need a client. One option is [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) and another is [Mobaxterm](http://mobaxterm.mobatek.net/), which includes an X Windows server for
interactive windowed applications on a cluster like Nobel.

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
The `$` is an indication that you're ready to enter a command (and not using
  a root account, which you would only be on your workstation ever, most likely)

To connect to adroit, I'd type something like this and hit enter:
```
ssh bhicks@adroit
The authenticity of host 'adroit (128.112.129.186)' can't be established.
RSA key fingerprint is SHA256:1hlQZZlWTt4DDR3Ym8lejWmZDyeXtT0HU9E+b3fp1a0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'adroit,128.112.129.186' (RSA) to the list of known hosts.
bhicks@adroit's password:
Last login: Tue Apr 11 10:08:15 2017 from nat-oitwireless-outside-vapornet3-j-8.princeton.edu
The adroit cluster has access to 20 cores per node.

March 2017 -- Gaussian v16 has been installed


[bhicks@adroit3 ~]$
```

I'm now remotely connected to `adroit3`, which is the head node of the cluster! The
shell I used in both cases is one called [Bash](https://www.gnu.org/software/bash/).
It's a particular command line interface that is common across Unix-alike machines.


## Getting files to Adroit

One of the most frequently asked questions is how to get files to Adroit or a cluster.
Again, Linux/MacOS has an answer out of the box, but on Windows you'll need to use
clients like PuTTY and Mobaxterm
OR SFTP-capable clients like [WS_FTP](https://www.ipswitch.com/secure-information-and-file-transfer/wsftp-client) (paid, sadly) or [Filezilla](https://filezilla-project.org/). In both cases,
make sure you're using interactive logon. Filezilla especially can be a pain
with Duo Authentication for Nobel. If you're transferring a lot of files, consider
zipping them.

The default client to transfer files is `scp` on POSIX systems.
This is a copy command that uses
SSH to copy files. I'll discuss its use at greater length when [talking about the
command line utils](/hpc_beginning_workshop/utilities/).
