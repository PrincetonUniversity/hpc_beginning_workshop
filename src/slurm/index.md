# Introduction to Job Scheduling and SLURM

## What's a scheduler?

Schedulers help divide up the resources of a cluster fairly, give or take, and
they also make sure jobs don't trip over each other on the compute nodes.

All computational jobs for any cluster **EXCEPT Nobel** should be submitted
to the scheduler.

We use SLURM (Simple Linux User Resource Management), which is one type of
scheduling software.

## SLURM basics

To run SLURM you need:
  * A job to run (python script, R script, Matlab job, compiled exectuable)
  * A SLURM script (often suffixed `.cmd` by convention but not necessarily)

*You should never run code directly on the head/login node except for ~ 5 - 10
minute test runs.*

For detailed examples of these scripts, you can look at: [Getting Started](https://www.princeton.edu/researchcomputing/education/online-tutorials/getting-started/)

We'll be following a recipe for a serial job.


## A sample script
```
#!/bin/bash
# serial job using 1 node and 1 processor,
# and runs for 1 minute (max).
#SBATCH -N 1   # node count
#SBATCH --ntasks-per-node=1  # core count
#SBATCH -t 00:01:00
# sends mail when process begins, and
# when it ends. Make sure you define your email
#SBATCH --mail-type=begin
#SBATCH --mail-type=end
#SBATCH --mail-user=yourNetID@princeton.edu

echo 'Hello world!'

```

SLURM scripts are more or less Bash scripts (using the scripting syntax built into Bash) with some extra parameters to help out slurm.

* `-N 1` - claim one node
* `--ntasks-per-node=1` - claim one task (by default 1 per core)
* `-t` - claim a time allocation, here 1 minute. Format is `DAYS-HOURS:MINUTES:SECONDS`
* The other settings can configure an automated email from SLURM to you. Always worth it.

You probably won't ever need a one minute allocation, but this is a Hello world! script.

In this case, rather than running a program or code, we're just using the `echo` fucntion to print out 'Hello world!' in good programming tradition.

## Submitting a job

Assuming you wrote that script to a file called, `test.cmd` in your home directory:
```
cd ~
sbatch test.cmd
```

You'll either receive an error if you have a problem in your script syntax or a job id.

You can use the job id to track your job, see its progress through the system, and see when it will run, etc.

Some quick utilities:

`squeue -u username` will show all jobs active or pending for `username`
`scontrol show jobid 12345` will show a detailed set of info about a job, including how many cores+nodes it is for, what node it's running on, and its status.
`sshare -u username` will show info about shares and usage for a particular username.

As a slurm job runs, unless you redirect output, a file named slurm-jobid.out will be produced in your home dir. You can use `cat`, `less`, or any editor to view it. It contains the output your program would have written to a terminal, if run interactively.

## `salloc` and interactive testing on compute node
Say you have a job that might take days, but you want to make sure the code runs solidly for the first 30 minutes while keeping an eye on it.

You can't do that on a login node, so what do you do?

`salloc` takes the same modifiers as follow the `#SBATCH` in your SLURM script. It will however send you in an interactive shell to the compute node once the allocation is granted! So it won't be great to ask for many hours or days, but it can get you 30 minutes pretty quickly.

`salloc -N 1 -n 1 -t 00:20:00` will ask for an allocation of 1 node, 1 task, and 20 minutes. Once it's granted you'll be in a shell where you can run processes directly that will be killed after the time elapses.

## Considerations

Some things to think about:
  * Make sure your slurm script loads any dependencies or path changes (i.e. you need python3, so `module load anaconda3`)
  * Make sure you call your executable with its full path **or** `cd` to the appropriate directory.
  * If you call the executable directly and not via an interpreter like `mpirun` or `python` or `Rscript`, etc., make sure you have `+x` permissions on it!
  * Think about file systems! Different ones are useful for different things, have different sizes, and they don't tall talk to each other. (i.e. `/scratch` is local to a specific node, `/network/scratch/username` is networked to the entire cluster. This has implication for temporarily files and data).
  * `/home` has a default 1 GB quota and should be used mostly for small results, code, and packages needed to run tasks. On the Tigress clusters there is a shared gpfs file system and Adroit has scratch storage. You can request an increase up to 10 GB for your `/home` dir if necessary for larger packages. The form is [here](https://forms.rc.princeton.edu/quota/).
  
