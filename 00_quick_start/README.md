# HPC Quick Start Overview

Here we show how to transfer your files to Adroit and submit a job to the Slurm scheduler. To obtain the example
materials, run this command:

```
$ git clone https://github.com/PrincetonUniversity/gpu_programming_intro
```

## Python Script Example

### On Your Local Machine

In a terminal on your laptop, change the working directory and examine the scripts:

```
$ cd hpc_beginning_workshop/00_quick_start
$ cat matrix_inversion.py
$ cat job.slurm
```

Here are the contents of the script file:

```python
import numpy as np
N = 3
X = np.random.randn(N, N)
print("X =\n", X)
print("Inverse(X) =\n", np.linalg.inv(X))
```

Below is the Slurm script which prescribes the resource requirements for the Python script:

```bash
#!/bin/bash
#SBATCH --job-name=py-matin      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3

srun python matrix_inverse.py
```

Next, while still on your laptop, run the following ssh command to create a directory on Adroit (`$USER` does not need to be changed but you need to replace `<YourNetID>`):

```
ssh <YourNetID>@adroit.princeton.edu "mkdir -p /scratch/network/$USER/python_test"
```

Transfer the Python and Slurm scripts to Adroit using the scp (secure copy) command:

```
scp matrix_inverse.py <YourNetID>@adroit.princeton.edu:/scratch/network/$USER/python_test
scp job.slurm <YourNetID>@adroit.princeton.edu:/scratch/network/$USER/python_test
```

Now everything is in place on Adroit. Let's connect to the head node of that cluster and submit the job.

### Connect to Adroit

SSH to Adroit:

```
ssh <YourNetID>@adroit.princeton.edu
```

Change the working directory ($USER does not need to be replaced):

```
cd /scratch/network/$USER/python_test
```

Submit the job by running the following command:

```
sbatch job.slurm
```

This will place your job in the queue. You can monitor the status of your job with `squeue -u <YourNetID>`. If the `ST` field is `PD` (pending) then your job is waiting for other jobs to finish. If you do not see it in the list then it has finished. After the job runs you can view the output with `cat slurm-<XXXXXX>.out`. You will receive an email when the job is finished if you entered your NetID in the Slurm script.

Here is the expected output:

```

```

## R Script Example

A similar procedure can be used to run an R script. To do this, first make a directory on Adroit for the job:

```
cd ~
mkdir r_test
cd r_test
pwd
```

Create a file called `data_analysis.R` with the following contents on your **local machine**:

```R
health = read.csv("cdc.csv")
print(summary(health))
```

And create a second file on your **local machine** called `cdc.csv`:

```
genhlth,exerany,hlthplan,smoke100,height,weight,wtdesire,age,gender
good,0,1,0,70,175,175,77,m
good,0,1,1,64,125,115,33,f
good,1,1,1,60,105,105,49,f
good,1,1,0,66,132,124,42,f
very good,0,1,0,61,150,130,55,f
very good,1,1,0,64,114,114,55,f
very good,1,1,0,71,194,185,31,m
very good,0,1,0,67,170,160,45,m
good,0,1,1,65,150,130,27,f
good,1,1,0,70,180,170,44,m
...
```

As for the Python case, use a second shell to transfer the files from your local machine to Adroit:

```
scp data_analysis.R <YourNetID>@adroit.princeton.edu:/home/<YourNetID>/r_test
scp cdc.csv <YourNetID>@adroit.princeton.edu:/home/<YourNetID>/r_test
```

Return to your session on Adroit and obtain a Slurm script:

```
wget https://tigress-web.princeton.edu/~jdh4/job.slurm
```

Edit the Slurm scrip as follows (use a text editor like nano, micro, vim, emacs or myadroit):

```bash
#!/bin/bash
#SBATCH --job-name=R-test        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multithread tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send mail when process begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

srun Rscript data_analysis.R
```

Submit the job with `sbatch job.slurm`. You will receive an email when the job is finished. After the job runs you can view the output with `cat slurm-<XXXXXX>.out`.

## Learn More About Adroit by Running Commands

Type each command below and examine the output:

```
hostname                  # get the name of the machine you are on
whoami                    # get username of the account
date                      # get the current date and time
pwd                       # print working directory
cat /etc/os-release       # info about operating system
lscpu                     # info about the CPUs on head node
snodes                    # info about the compute nodes (7 nodes for myadroit)
squeue                    # which jobs are running or waiting to run
qos                       # quality of servce (job partitions and limits)
slurmtop                  # shows a map of cluster usage
who                       # list users on the head node
checkquota                # view your quota and request more space
```

Here is example output from the commands above:

<pre>
[jdh4@adroit4 ~]$ <b>hostname</b>
adroit4


[jdh4@adroit4 ~]$ <b>whoami</b>
jdh4


[jdh4@adroit4 ~]$ <b>date</b>
Sat Sep 14 15:15:11 EDT 2019


[jdh4@adroit4 ~]$ <b>pwd</b>
/home/jdh4


[jdh4@adroit4 ~]$ <b>cat /etc/os-release</b> 
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



[jdh4@adroit4 ~]$ <b>lscpu</b>
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



[jdh4@adroit4 ~]$ <b>snodes</b>
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



[jdh4@adroit4 ~]$ <b>squeue</b>
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
 
 
 
[jdh4@adroit4 ~]$ <b>who</b>
mlenel   pts/0        2019-09-14 10:15 (vpn10-client-128-112-69-121.princeton.edu)
root     pts/1        2019-09-03 12:45 (delta.princeton.edu)
mlenel   pts/2        2019-09-14 10:16 (adroit4.princeton.edu)
mlenel   pts/8        2019-09-14 13:55 (vpn10-client-128-112-71-230.princeton.edu)
hherman  pts/10       2019-09-14 14:06 (vpn10-client-128-112-69-8.princeton.edu)
lclingan pts/11       2019-09-14 14:33 (myadroit)
lclingan pts/12       2019-09-14 14:34 (myadroit)
jdh4     pts/14       2019-09-14 15:02 (vpn10-client-128-112-70-165.princeton.edu)
tcyr     pts/15       2019-09-14 15:05 (nat-oitwireless-inside-vapornet100-10-9-77-247.princeton.edu)



[jdh4@adroit4 ~]$ <b>checkquota</b>
          Storage/size quota filesystem report for user: jdh4
Filesystem               Mount                 Used   Limit  MaxLim Comment
Adroit home              /home                2.8GB   9.3GB    10GB 
Adroit scratch           /scratch                 0       0       0 
Adroit scratch network   /scratch/network         0       0       0 

          Storage number of files used report for user: jdh4
Filesystem               Mount                 Used   Limit  MaxLim Comment
Adroit home              /home                17.2K    975K    1.0M 
Adroit scratch           /scratch                 2       0       0 
Adroit scratch network   /scratch/network         1       0       0 

For quota increase requests please use this website:

         https://forms.rc.princeton.edu/quota
</pre>
