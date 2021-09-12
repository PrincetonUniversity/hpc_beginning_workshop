# Connecting to the Clusters via SSH

## A Few Caveats
These instructions assume you:
1. Are Princeton University faculty, student, or staff
2. Are connecting...
    * (if on-campus) from the campus wireless eduroam network, or a wired campus connection, or through Nobel
    * (if off-campus) with **GlobalProtect VPN**, or through Nobel
        * You can install the [GlobalProtect VPN](https://www.princeton.edu/vpn) on your laptop. Make sure you connect via the GlobalProtect app on your laptop *before* ssh-ing to Adroit or another cluster.
3. Are connecting with **Duo Authentication**
    * All of the clusters from both on campus and off campus now require two-factor authentication via Duo. If you need help getting this set up, contacting the [OIT Support and Operations Center](http://www.princeton.edu/oit/) will be your best course of action. You can also see OIT's resoures for using Duo [here](https://princeton.service-now.com/snap/?id=kb_article&sys_id=692a27064f9ca20018ddd48e5210c72b).
    * Upon connecting, you can request a push to a cell phone application, a text with a passcode, or you can enter a generated pass code with a soft key created by the Duo application on your cell phone.
    * If you use a system that respects a standard `~/.ssh/config`, you can use a [multiplexing solution](https://github.com/PrincetonUniversity/removing_tedium/tree/master/01_suppressing_duo#ii-multiplexing-approach-vpn-free).
5. Have an account on the system you're looking to connect to. You can register for [Adroit](https://forms.rc.princeton.edu/registration/?q=adroit) here. (Note: You will need to login using your university credentials).

## SSH

In order to connect to the university computing clusters, you will need an SSH
(secure shell) client. If you have trouble connecting then see [this page](https://researchcomputing.princeton.edu/ssh).

On MacOS and Linux, the default Terminal application has such a client built-in.
No download is necessary!

On Windows machines, you'll need a client. One option is [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) and another is [Mobaxterm](http://mobaxterm.mobatek.net/).

Regardless, you'll need to know a few things:

1. Server (Host) Address of the cluster
    * For each cluster, the address typically follows the formula '[cluster-name].princeton.edu'. So for Adroit, for example, the address would be adroit.princeton.edu.
2. Your NetID and Password  
    * **Note:** This may be different than your email if you use an alias.

### Using Terminal as an Example

Once you launch an instance of Terminal, you'll be at a command prompt *on your local
machine* (i.e., on your computer) that looks something like this:
```
benjaminhicks ~/hpc_beginning_workshop $
```
The `$` is an indication that you're ready to enter a command.

To connect to a cluster, the general address looks like this, where you replace the <>'s with the needed content:

```
ssh <netID>@<hostname>.princeton.edu
```

To connect to Adroit, as a user with the netid bhicks, I'd type something like this

```
benjaminhicks ~/hpc_beginning_workshop $ ssh bhicks@adroit.princeton.edu
```
and after hitting Enter, I'd see something like this
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

I'm now remotely connected to adroit4, which is the head node of the cluster!

The shell I used in both cases is one called [Bash](https://www.gnu.org/software/bash/).
It's a particular command line interface that is common across Unix-alike machines.

 ## SSH Keys: `ssh` without typing passwords

 Typing passwords every time you want to connect to a machine or, more annoyingly, every time you want to copy a file to/from a remote machine gets annoying quickly.  One solution is to enable passwordless login/remote operations by generating a public/private pair of *ssh keys* and using them to negotiate the connection.  The procedure is explained in [this guide](https://github.com/PrincetonUniversity/removing_tedium/tree/master/02_passwordless_logins).

 ## <a name="tmux">Staying connected (tmux)</a>

 If your shell is disconnected, the command you're running terminates. This comes up very frequently when you're connected to Nobel, where tasks are
 run directly from the command line rather than the SLURM scheduler. This is bad.
 A built-in solution to most Unix-alike operating systems is `nohup`, but it's of limited utility.

 Hence we bring in something like [tmux](https://www.ocf.berkeley.edu/~ckuehl/tmux/).
 It comes installed on all university clusters, and it lets you start a shell
 session that, rather than being remote via SSH, lives on the server.

 A simple use case would be

 ```
 # To launch tmux
 tmux
 tmux attach

 # To detach from your session
 # Press ctrl-b, then d

 # To kill your session
 # Press ctrl-d during the tmux session
 ```

 You would then be attached back to the session you created by default when you called tmux.
 To close a session,
 just `exit` or `ctrl+d`. These sessions will remain until the server is rebooted or you
 close them. Anything you run while attached to the session runs in that session,
 and therefore it is safe from a disconnect.

 Note: Nobel has two hosts, `compton`
 and `davisson`, and the session will live on one or the other. You can find the host by looking in the lower right corner of your tmux session window. To find your session again after
 a disconnect, you'll need to login directly to that host rather than just nobel, i.e.
 `ssh compton.princeton.edu`. Otherwise you'll do tmux attach and not find your
 session.

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


 ## Learn More About Adroit by Running Commands

 Once in Adroit, type each command below and examine the output:

 ```
 hostname                  # get the name of the machine you are on
 whoami                    # get username of the account
 date                      # get the current date and time
 pwd                       # print working directory
 cat /etc/os-release       # info about operating system
 lscpu                     # info about the CPUs on head node
 snodes                    # info about the compute nodes (7 nodes for myadroit)
 squeue                    # which jobs are running or waiting to run
 qos                       # quality of service (job partitions and limits)
 slurmtop                  # shows a map of cluster usage
 who                       # list users on the head node
 checkquota                # view your quota and request more space
 ```

 Here is example output from the commands above:

 <pre>
 $ <b>hostname</b>
 adroit4


 $ <b>whoami</b>
 ceisgrub


 $ <b>date</b>
 Fri Feb 21 16:20:03 EST 2020


 $ <b>pwd</b>
 /home/ceisgrub


 $ <b>cat /etc/os-release</b>
 NAME="Springdale Linux"
 VERSION="7.7 (Verona)"
 ID="rhel"
 ID_LIKE="fedora"
 VERSION_ID="7.7"
 PRETTY_NAME="Springdale Linux 7.7 (Verona)"
 ANSI_COLOR="0;32"
 CPE_NAME="cpe:/o:springdale:linux:7.7:GA"
 HOME_URL="http://springdale.princeton.edu/"
 BUG_REPORT_URL="https://springdale.math.ias.edu/"

 REDHAT_BUGZILLA_PRODUCT="Springdale Linux 7"
 REDHAT_BUGZILLA_PRODUCT_VERSION=7.7
 REDHAT_SUPPORT_PRODUCT="Springdale Linux"
 REDHAT_SUPPORT_PRODUCT_VERSION=7.7



 $ <b>lscpu</b>
 Architecture:          x86_64
 CPU op-mode(s):        32-bit, 64-bit
 Byte Order:            Little Endian
 CPU(s):                32
 On-line CPU(s) list:   0-31
 Thread(s) per core:    1
 Core(s) per socket:    16
 Socket(s):             2
 NUMA node(s):          2
 Vendor ID:             GenuineIntel
 CPU family:            6
 Model:                 85
 Model name:            Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz
 Stepping:              4
 CPU MHz:               1021.179
 CPU max MHz:           3700.0000
 CPU min MHz:           1000.0000
 BogoMIPS:              5200.00
 Virtualization:        VT-x
 L1d cache:             32K
 L1i cache:             32K
 L2 cache:              1024K
 L3 cache:              22528K
 NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30
 NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31
 Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch epb cat_l3 cdp_l3 intel_ppin intel_pt ssbd mba ibrs ibpb stibp tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm cqm mpx rdt_a avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local dtherm ida arat pln pts pku ospke md_clear spec_ctrl intel_stibp flush_l1d



 $ <b>snodes</b>
 HOSTNAMES     STATE    CPUS S:C:T    CPUS(A/I/O/T)   CPU_LOAD MEMORY   GRES     PARTITION          AVAIL_FEATURES
 adroit-01     idle     20   2:10:1   0/20/0/20       0.01     128000   (null)   class              ivy
 adroit-02     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-03     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-04     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-05     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-06     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-07     idle     20   2:10:1   0/20/0/20       0.01     64000    (null)   class              ivy
 adroit-08     mix      32   2:16:1   31/1/0/32       19.93    384000   (null)   all*               skylake
 adroit-09     idle     32   2:16:1   0/32/0/32       0.01     384000   (null)   all*               skylake
 adroit-10     mix      32   2:16:1   25/7/0/32       16.58    384000   (null)   all*               skylake
 adroit-11     mix      32   2:16:1   30/2/0/32       11.01    384000   (null)   all*               skylake
 adroit-12     mix      32   2:16:1   30/2/0/32       10.98    384000   (null)   all*               skylake
 adroit-13     mix      32   2:16:1   24/8/0/32       4.20     384000   (null)   all*               skylake
 adroit-14     mix      32   2:16:1   20/12/0/32      20.01    384000   (null)   all*               skylake
 adroit-15     idle     32   2:16:1   0/32/0/32       0.01     384000   (null)   all*               skylake
 adroit-16     mix      32   2:16:1   5/27/0/32       3.01     384000   (null)   all*               skylake
 adroit-h11g1  idle     40   2:20:1   0/40/0/40       0.04     770000   gpu:tesl gpu                (null)
 adroit-h11g4  idle     16   2:8:1    0/16/0/16       0.61     64000    gpu:tesl gpu                (null)



 $ <b>squeue</b>
              JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
             660090       all run_05_0    fanid PD       0:00      1 (QOSMaxJobsPerUserLimit)
             661432       all       KL   mlenel PD       0:00      1 (Dependency)
       661431_[6-7]       all       KL   mlenel PD       0:00      1 (Dependency)
             661439       all sys/dash lclingan  R      37:28      1 adroit-10
           661429_6       all       KL   mlenel  R    1:13:28      1 adroit-08
           661429_7       all       KL   mlenel  R    1:13:28      1 adroit-08
             660093       all run_15_0    fanid  R 3-20:26:13      1 adroit-16
             660092       all run_15_0    fanid  R 3-20:27:14      1 adroit-08
             660091       all run_15_0    fanid  R 3-20:28:42      1 adroit-08
             660087       all run_15_1    fanid  R 9-12:05:41      1 adroit-08
             660999       all BBR_m06-    kyras  R 2-21:31:33      1 adroit-12
             660996       all BMR_m06-    kyras  R 2-21:40:50      1 adroit-11
             660085       all run_1_1_    fanid  R 10-00:38:49      1 adroit-08
             660086       all run_05_1    fanid  R 10-00:38:49      1 adroit-08
             660088       all run_05_0    fanid  R 10-00:38:49      1 adroit-16
             660089       all run_05_0    fanid  R 10-00:38:49      1 adroit-16
             660116       all tBu3PPd_     leit  R 8-05:22:17      1 adroit-11
             660114       all Phdiimin     leit  R 8-14:31:04      1 adroit-14
             660115       all tBu3PPd_     leit  R 8-14:31:04      1 adroit-14
             660113       all Phdiimin     leit  R 9-12:05:41      1 adroit-12
             661298       all job.scri vincenzi  R    6:37:12      1 adroit-13
             661391       all run_cali  hherman  R    3:59:23      1 adroit-10



 $ <b>who</b>
 bill     pts/0        2020-02-18 08:17 (delta.princeton.edu)
 yongickc pts/1        2020-02-20 08:11 (chm-c07y213xjyvx.princeton.edu)
 zhengshi pts/2        2020-02-10 01:59 (:pts/25:S.0)
 root     pts/3        2020-02-19 13:54 (adroit-nfs2)
 keweiz   pts/4        2020-02-21 09:01 (vpn10-client-128-112-69-24.princeton.edu)
 haonan   pts/5        2020-02-21 15:23 (myadroit)
 jdh4     pts/9        2020-02-21 16:12 (tigressgateway1.princeton.edu)
 yongickc pts/10       2020-02-17 08:14 (chm-c07y213xjyvx.princeton.edu)
 zhengy   pts/11       2020-02-21 09:26 (nat-oitwireless-inside-vapornet100-10-8-2-157.princeton.edu)
 msislam  pts/12       2020-02-21 15:36 (nat-oitwireless-inside-vapornet100-10-9-125-87.princeton.edu)
 aidanm   pts/13       2020-02-21 10:03 (pni-10h01410k2euh.princeton.edu)
 meggl    pts/15       2020-02-21 10:04 (vpn10-client-128-112-71-193.princeton.edu)
 mrasna   pts/16       2020-02-21 14:54 (nat-oitwireless-inside-vapornet100-10-8-5-193.princeton.edu)
 nmishra  pts/17       2020-02-21 15:55 (nat-oitwireless-inside-vapornet100-10-9-111-71.princeton.edu)
 cfei     pts/19       2020-02-21 13:59 (nat-oitwireless-inside-vapornet100-10-9-154-116.princeton.edu)
 jdeobald pts/21       2020-02-21 11:42 (dynamic-oit-swiftnet-128-112-127-249.princeton.edu)
 dianw    pts/22       2020-02-21 11:54 (vpn10-client-128-112-69-89.princeton.edu)
 xiaoyuel pts/23       2020-02-21 14:26 (vpn10-client-128-112-71-50.princeton.edu)
 perezgiz pts/24       2020-02-21 14:07 (josko-eth-dongle.princeton.edu)
 zhengshi pts/25       2020-02-12 14:41 (:pts/20:S.0)
 keweiz   pts/26       2020-02-21 14:30 (vpn10-client-128-112-69-24.princeton.edu)
 keweiz   pts/27       2020-02-21 16:09 (vpn10-client-128-112-69-24.princeton.edu)



 $ <b>checkquota</b>
           Storage/size quota filesystem report for user: ceisgrub
 Filesystem               Mount                 Used   Limit  MaxLim Comment
 Adroit home              /home                9.1GB   9.3GB    10GB
 Adroit scratch           /scratch                 0       0       0
 Adroit scratch network   /scratch/network     1.7GB    93GB   100GB

           Storage number of files used report for user: ceisgrub
 Filesystem               Mount                 Used   Limit  MaxLim Comment
 Adroit home              /home                80.5K    975K    1.0M
 Adroit scratch           /scratch                 1       0       0
 Adroit scratch network   /scratch/network     18.9K    9.8M   10.5M

 For quota increase requests please use this website:

          https://forms.rc.princeton.edu/quota
 </pre>
