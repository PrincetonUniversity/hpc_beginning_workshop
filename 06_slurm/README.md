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

## SLURM Commands

| Command | Description |
:---------|:------------|
| `sbatch <slurm_script>` | Submit a job (e.g., `sbatch job.slurm`) |
| `squeue` | Show jobs in the queue |
| `squeue -u <NetID>` | Show jobs in the queue for a specific user (e.g., `squeue -u ceisgrub`) |
| `squeue -u <NetID> --start` | Report the expected start time for pending jobs |
| `squeue -j <JobID>` | Show the nodes allocated to a running job |
| `scancel <JobID>` | Cancel a job (e.g., `scancel 2534640`) |
| `scontrol show <JobID>` | See detailed info about a job |
| `snodes` | Show properties of the nodes on a cluster (e.g., maximum memory) |
| `sinfo` | Show how nodes are being used |
| `sshare/sprio` | Show the priority assigned to jobs |
| `smap/sview` | Graphical display of the queues |
| `slurmtop` | Text-based view of cluster nodes |
| `scontrol show config` | View default parameter settings |
| `sacct -o MaxVMSizeNode,ReqMem -j <JobID>` | View details about finished jobs. Use `sacct -e` to view list options. |

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

`salloc --nodes=1 --ntasks=1 --mem=4G --time=00:20:00` will ask for an allocation of 1 node, 1 task, and 20 minutes. Once it's granted you'll be in a shell where you can run processes directly that will be killed after the time elapses. To leave the session before it expires use the `exit` command.

To get a GPU: `salloc --nodes=1 --ntasks=1 --mem=4G --time=00:20:00 --gres=gpu:1`

## Considerations

Some things to think about:
  * Make sure your slurm script loads any dependencies or path changes (i.e. you need python3, so `module load anaconda3`)
  * Make sure you call your executable with its full path **or** `cd` to the appropriate directory.
  * If you call the executable directly and not via an interpreter like `srun` or `python` or `Rscript`, etc., make sure you have `+x` permissions on it!
  * Think about file systems! Different ones are useful for different things, have different sizes, and they don't tall talk to each other. (i.e. `/scratch` is local to a specific node, `/network/scratch/username` is networked to the entire cluster. This has implication for temporary files and data).
  * `/home` has a default 10 GB quota (or 1 GB for some) and should be used mostly for small results, code, and packages needed to run tasks. On the Tigress clusters there is a shared gpfs file system and Adroit has scratch storage. You can request an increase up to 10 GB for your `/home` dir if necessary for larger packages. The form is [here](https://forms.rc.princeton.edu/quota/).

## Big Memory Serial Job example

One advantage of using the HPC clusters over you laptop or workstation is the large amount of RAM available per node. You can run a serial job with 100's of GB of memory, for example. This can be very useful for working with a large data set in Python or R. To find out how much memory each node has, run the `snodes` command and look at the MEMORY column which is in megabytes.

```bash
#!/bin/bash
#SBATCH --job-name=slurm-test    # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=190G       # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3
conda activate myenv

python myscript.py
```

The example above runs a python script using 1 cpu-core and 190 GB of memory.

## Multithreaded Jobs

Some software like the linear algebra routines in NumPy and MATLAB are able to use multiple CPU-cores using threading libraries like OpenMP or Intel Threading Building Blocks.

```bash
#!/bin/bash
#SBATCH --job-name=multicore     # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:15:00          # maximum time needed (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

module purge
module load anaconda3

srun python myscript.py
```

Here I adjust the `--cpus-per-task` parameter to tell SLURM that I want my single task to
be able to use four cores.

## Multinode Jobs

In another situation, you might have an executable that uses MPI (Message Passing
Interface) to use multiple cores over multiple nodes.
For example, the script below uses 32 cpu-cores over two nodes:

```bash
#!/bin/bash
#SBATCH --job-name=multinode     # create a short name for your job
#SBATCH --nodes=2                # node count
#SBATCH --ntasks-per-node=16     # number of tasks per node
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

Array jobs provide a different way to parallelize your computations. They are used when you need to run the same job a large number of times with only slight differences between the jobs. For instance, let's say that you need to run 100 jobs, each with a different seed value for the random number generator. This can be done with a single array job.

Below is an example Slurm script where there are 5 jobs in the array:

```bash
#!/bin/bash
#SBATCH --job-name=array-job     # create a short name for your job
#SBATCH --output=slurm-%A.%a.out # STDOUT file
#SBATCH --error=slurm-%A.%a.err  # STDERR file
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --array=0-4              # job array with index values 0, 1, 2, 3, 4
#SBATCH --mail-type=all          # send email on job start, end and fault
#SBATCH --mail-user=<YourNetID>@princeton.edu

# A few special parameters are set in this case that we echo below

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"

echo -n "Executing on the machine: "
hostname
echo "Array Task ID : " $SLURM_ARRAY_TASK_ID

python myscript.py $SLURM_ARRAY_TASK_ID
```

The first few lines of `myscript.py` might look like this:

```python
import sys
idx = int(sys.argv[-1]) # get the value of SLURM_ARRAY_TASK_ID
parameters = [2.5, 5.0, 7.5, 10.0, 12.5]
myparam = parameters[idx]
# execute the rest of the script using myparam
```

For an R script you can use:

```R
args <- commandArgs(TRUE)
idx <- as.numeric(args[1])
parameters <- c(2.5, 5.0, 7.5, 10.0, 12.5)
myparam <- parameters[idx + 1]
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

Note that it is normal to see `(QOSMaxJobsPerUserLimit)` listed in the
'NODELIST(REASON)' column of `squeue` output for array jobs. It indicates that you can only have
a certain number of jobs actively queued. Just wait and all the jobs of the array will run.

Each job in the array will have the same values for `nodes`, `ntasks`, `cpus-per-task`, `time` and so on. This means that job arrays can be used to handle everything from serial jobs to large multi-node cases.

To see the limit on the number of jobs in an array:

```
# ssh della
$ scontrol show config | grep Array
MaxArraySize      = 2501
```

## Running Multiple Jobs in Parallel as a Single SLURM Job

In general one should use Job Arrays for this task but in some cases different executables need to run simultaneously. In the example below all the executables are the same but this is not requred. If we have, say, 3 jobs and we want to run them in parallel as a single SLURM job, we can use the following script:

```bash
#!/bin/bash
#SBATCH --job-name=poisson       # create a short name for your job
#SBATCH --nodes=3                # node count
#SBATCH --ntasks=3               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3

srun -N 1 -n 1 python demo.py 0 &
srun -N 1 -n 1 python demo.py 1 &
srun -N 1 -n 1 python demo.py 2 &
wait
```

Since we want to run the jobs in parallel, we place the & character at the end of each srun command so that each job runs in the background. The wait command serves as a barrier until all the background jobs are complete. Since sruns cannot share nodes by default, we need to request three nodes and three tasks, one for each srun. In the execution command we then distribute the resources by giving each srun one task on one node. Notice the wait command at the end which ensures that the SLURM job does not exit until all the sruns have finished.

The programs run in parallel, which means that we only need to request the time it takes for one program to run (e.g., the longest running program if they have different runtimes).

For more see "MULTIPLE PROGRAM CONFIGURATION" on [this page](https://slurm.schedmd.com/srun.html).

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
conda activate tf2-gpu

python my-tf-script.py
```

**IMPORTANT**: *Only code that has been explicitly written to run on GPUs can take advantage of GPUs. Adding the `--gres` option to your Slurm script for a CPU code will not speed-up the execution time but your future fairshare value will be lowered accordingly for requesting the GPU.*

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

## Job Priority

Here is an explanation from Bill Wichser of Research Computing taken from [AskRC](https://askrc.princeton.edu/question/238/what-determines-my-jobs-priority-under-slurm/):

The Slurm scheduler works much like many other schedulers by simply applying a priority number to a job. To see all jobs with associated priorities one can use

```
squeue -o "%.18i %Q %.9q %.8j %.8u %.10a %.2t %.10M %.10L %.6C %R" | more
```

So how is this number determined?

There are a few factors which determine this value. The command "sprio -w" will show you the current values being used along with the weights associated. Looking at della I find

```
sprio -w

      JOBID   PRIORITY        AGE  FAIRSHARE    JOBSIZE        QOS
    Weights                  1000      10000      10000      10000
```

Let me try to explain what each component tries to do.

AGE - this is an increasing value which increments as a job which is ready to run sits in the queue waiting for resources. It will increment for a maximum time of 10 days which is a configurable limit.

FAIRSHARE this gets complicated but is basically a measure of how much the user and or group has been using the cluster over the past 30 days. See the "sshare -l" command for actual values where the LevelFS is used as a multiplier to either boost or decrement the actual value given past usage.

JOBSIZE - this is basically the number of cores requested such that more cores give higher priority. Why this is important is because wide jobs would be starved if not given a higher priority and smaller jobs can then be backfilled as resources are waiting to be freed.

QOS - use the "qos" command to see the various weights for the quality of service the job is using. This is based almost entirely on the time requested. And in most cases those jobs requesting shorter times are given the highest priority here.

Using the command (all on one line)

```
watch -n 30 -d 'squeue --start --format="%.7i %.7Q %.7q %.15j %.12u %.10a %.20S %.6D %.5C %R" --sort=S --states=PENDING | egrep -v "N/A" | head -20'
```

One can then watch the top jobs waiting to run and begin to see how this works. In many instances you will find lower priority jobs which will run before higher priority ones. This is all due to the requested resources, when they will free, and the decisions the scheduler is making in this regard. This is also why having an accurate representation of timelimit is so important. better fitting of jobs and more accurate scheduling can happen as the actual time specified becomes more accurate for all jobs.

Run the following command to see how many shares your group has as well as your fairshare value: 

```
sshare
```

When running jobs remember to only request what you need.

## Planning your jobs

[Table of Contents](/hpc_beginning_workshop/)

Ask yourself:
  1. What are my needs?
  2. Do I need to do many single core jobs or their equivalent?
  3. If my job can be made parallel, how?
    1. Slice up data set
    2. Library parallelization through threading (matlab and a specially built R with MKL can do this, for example)
  4. How does this scale (i.e. can I make this work on 1 core, 2 cores, 3, more?)

Allow yourself:
  * Time to experiment on code
  * Use of good version control like a [Github
  repo hosted by Princeton](https://www.princeton.edu/researchcomputing/services/github-form-new/)
  * Time to do some tests and studies to determine optimum run conditions -- the more you can pare down requirements the more efficiently you can run.
  * Time to look at different approaches.
