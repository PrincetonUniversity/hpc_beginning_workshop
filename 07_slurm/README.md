# Introduction to Job Scheduling and SLURM

[Table of Contents](/hpc_beginning_workshop/)

## What's a scheduler?

Schedulers help divide up the resources of a cluster fairly, give or take, and
they also make sure jobs don't trip over each other on the compute nodes.

All computational jobs for any cluster **EXCEPT Nobel** should be submitted
to the scheduler.

We use SLURM (Simple Linux User Resource Management), which is one type of
scheduling software.

## SLURM basics

To run SLURM you need:
  * A job to run (python script, R script, Matlab job, compiled executable)
  * A SLURM script (often suffixed `.cmd`, `.slurm` or `.sh` by convention but not necessarily)

*You should never run code directly on the head/login node except for ~ 5 - 10
minute test runs using limited resources (cores and memory).*

For detailed examples of these scripts, you can look at: [Introduction Slurm](https://researchcomputing.princeton.edu/education/online-tutorials/getting-started/introducing-slurm)

## Serial job example

```bash
#!/bin/bash
#SBATCH --job-name=slurm-test    # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

echo 'Hello world!'
```

SLURM scripts are more or less Bash scripts (using the scripting syntax built into Bash) with some extra parameters to help out slurm.

* `--nodes=1` - claim one node
* `--ntasks=1` - claim one task (by default 1 per core)
* `--time` - claim a time allocation, here 1 minute. Format is `DAYS-HOURS:MINUTES:SECONDS`
* The other settings can configure an automated email from SLURM to you. Always worth it.

You probably won't ever need a one minute allocation, but this is a Hello world! script.

In this case, rather than running a program or code, we're just using the `echo` fucntion to print out 'Hello world!' in good programming tradition.

Read [this page](https://researchcomputing.princeton.edu/faq/where-do-i-store-) to know where to write your files for running jobs.

## Submitting a job

Assuming you wrote that script to a file called, `job.slurm` in your home directory:
```
cd ~
sbatch job.slurm
```

You'll either receive an error if you have a problem in your script syntax or a job id.

You can use the job id to track your job, see its progress through the system, and see when it will run, etc.

Some quick utilities:

`squeue -u username` will show all jobs active or pending for `username`
`scontrol show jobid 12345` will show a detailed set of info about a job, including how many cores+nodes it is for, what node it's running on, and its status.
`sshare -u username` will show info about shares and usage for a particular username.

As a slurm job runs, unless you redirect output, a file named slurm-jobid.out will be produced in your home dir. You can use `cat`, `less`, or any editor to view it. It contains the output your program would have written to a terminal, if run interactively.

## `salloc` and interactive testing on compute node
Say you have a job that might take days, but you want to make sure the code runs solidly for the first 20 minutes while keeping an eye on it.

You can't do that on a login node, so what do you do?

`salloc` takes the same modifiers as follow the `#SBATCH` in your SLURM script. It will however send you in an interactive shell to the compute node once the allocation is granted! So it won't be great to ask for many hours or days, but it can get you 30 minutes pretty quickly.

`salloc --nodes=1 --ntasks=1 --time 00:20:00` will ask for an allocation of 1 node, 1 task, and 20 minutes. Once it's granted you'll be in a shell where you can run processes directly that will be killed after the time elapses.

## Considerations

Some things to think about:
  * Make sure your slurm script loads any dependencies or path changes (i.e. you need python3, so `module load anaconda3`)
  * Make sure you call your executable with its full path **or** `cd` to the appropriate directory.
  * If you call the executable directly and not via an interpreter like `srun` or `python` or `Rscript`, etc., make sure you have `+x` permissions on it!
  * Think about file systems! Different ones are useful for different things, have different sizes, and they don't tall talk to each other. (i.e. `/scratch` is local to a specific node, `/network/scratch/username` is networked to the entire cluster. This has implication for temporary files and data).
  * `/home` has a default 10 GB quota (or 1 GB for some) and should be used mostly for small results, code, and packages needed to run tasks. On the Tigress clusters there is a shared gpfs file system and Adroit has scratch storage. You can request an increase up to 10 GB for your `/home` dir if necessary for larger packages. The form is [here](https://forms.rc.princeton.edu/quota/).

## Multicore Jobs

Sometimes you might want to run jobs using technologies like OpenMP or MPI. These
are both ways of using more than one core. (There are certainly others, including
array jobs.)

For these, you'll be adjusting two parameters in your SLURM script, but you
will need to be aware of two factors--whether you want more tasks or more cores
per task.

Let's say I want to run R substituting the Intel MKL BLAS for the built-in. MKL
is mulithreading and will let me use more than one core on a node. (Though it
will not let me use more than one node--for that you need MPI!)

```bash
#!/bin/bash
#SBATCH --job-name=multicore     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=3        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:15:00          # maximum time needed (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel intel-mkl

LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_rt.so /usr/bin/Rscript test.R
```

Here I adjust the `--cpus-per-task` parameter to tell SLURM that I want my single task to
be able to use three cores (since MKL will happily use the CPU power that way).

(Unless you're an R user, don't worry too much about the `LD_PRELOAD`, that's
just me forcing R to use the BLAS library that I would like, i.e. MKL)

## Multinode Jobs

In another situation, you might have an executable that uses MPI (Message Passing
Interface) to use multiple cores over multiple nodes.
For example, the script below uses 32 cpu-cores over two nodes:

```bash
#!/bin/bash
#SBATCH --job-name=multinode     # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks=16              # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=2G         # memory per cpu-core (4G is default)
#SBATCH --time=00:05:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load intel intel-mpi

srun ./a.out
```

**IMPORTANT**: *Only codes that have been explicitly written to run in parallel can take advantage of multiple cores on multiple nodes. Using a
value of `--ntasks` greater than 1 for a code that has not been parallelized will not improve its performance but you will be charged for
the extra CPUs.*

**IMPORTANT**: *The optimal value of `--nodes` and `--ntasks` for a parallel code must be determined empirically. As these quantities increase,
the parallel efficiency tends to decrease and queue wait times increase. The parallel efficiency is the serial execution time divided by the
product of the parallel execution time and the number of tasks.*


## Combined Multinode, Multithreading Jobs

In this case we combined multithreading with multinode parallelism:

```bash
#!/bin/bash
#SBATCH --job-name=hybrid        # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks=8               # total number of tasks across all nodes
#SBATCH --cpus-per-task=2        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load intel intel-mpi

srun ./a.out
```

## Array Jobs

Array jobs are a different way to parallelize your computations. These use a
set of variables that Slurm will set for you in the job.

```bash
#!/bin/bash
#SBATCH --job-name=array-job     # create a short name for your job
#SBATCH --output=slurm-%N.%j.out # STDOUT file
#SBATCH --error=slurm-%N.%j.err  # STDERR file
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --array=0-4              # array job will submit 5 jobs (0, 1, 2, 3, 4)
#SBATCH --mail-type=all          # send email on job start, end and fault
#SBATCH --mail-user=<YourNetID>@princeton.edu

# A few special parameters are set in this case that we echo below:

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"

echo  -n "Executing on the machine: " 
hostname
echo "Array Task ID : " $SLURM_ARRAY_TASK_ID 
echo " Random number : " $RANDOM

srun python myscript.py $SLURM_ARRAY_TASK_ID
```

The first few lines of `myscript.py` might look like this:

```python
import sys
idx = int(sys.argv[-1]) # get the value of SLURM_ARRAY_TASK_ID
parameters = [2.5, 5.0, 7.5, 10.0, 12.5]
myparam = parameters[idx]
# execute the rest of the script using myparam
```

Job arrays produce outputs with the job id and the individual task id that
echo their subtask number. You can set the array numbers to any arbitrary set
of numbers, so that you can subset processing a larger list by grabbing the
value of `$SLURM_ARRAY_TASK_ID`. For example:

```bash
#SBATCH --array=0,100,200,300,400,500
./myprogram $SLURM_ARRAY_TASK_ID
```

This snippet shows a six task array, that will pass increments of 100 to the
program in question. It can then start processing a data frame, for example,
at rows 0, 100, 200, 300, 400, etc. and stop iterating after 99 rows. Thus if these
arrays run in parallel, you would complete 600 rows.

## GPUs

If your code can use a GPU, you might want to request one, as does the
following script that wraps a Python job in tensorflow-gpu.

```bash
#!/bin/bash
#SBATCH --job-name=poisson       # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3
conda activate tf-gpu

srun python my-tf-script.py
```

**IMPORTANT**: *Only code that has been explicitly written to run on GPUs can take advantage of GPUs. Adding the `--gres` option to your Slurm script for a CPU code will not speed-up the execution time but you will be charged for requesting the GPU.*

This asks for a single GPU (of any type) via `--gres=gpu:1` You can specify
more granularly too, `--gres=gpu:tesla_v100:2` would ask for two Tesla v100s.
Note that only codes that have been written to use a gpu will be able to
do so.

## Efficiency Reports

You will receive an email after each job finishes, for example:

```
Job ID: 670018
Cluster: adroit
User/Group: ceisgrub/pres
State: COMPLETED (exit code 0)
Cores: 1
CPU Utilized: 00:00:05
CPU Efficiency: 22.73% of 00:00:22 core-walltime
Job Wall-clock time: 00:00:22
Memory Utilized: 1.41 MB
Memory Efficiency: 0.14% of 1.00 GB
```

The report provides information about run time, CPU usage, memory usage, etc. You should inspect these values to determine if you are using the resources properly. Your queue time is in part determined by the amount of resources your are requesting. Your fairshare value, which in part determines the priority of your next job, is decreased in proportion to the resources you request.

## module load?

You may have seen the `module load` commands in the previous scripts. Now that
you've looked at some Slurm scripts the [tutorial on `modules`s](modules/) will make much more
sense.
