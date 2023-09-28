# Job Array

Consider the case of running 3 jobs within the array:

```bash
#!/bin/bash
#SBATCH --job-name=array-job     # create a short name for your job
#SBATCH --output=slurm-%A.%a.out # stdout file
#SBATCH --error=slurm-%A.%a.err  # stderr file
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)
#SBATCH --array=0-2              # job array with index values 0, 1, 2

echo "My SLURM_ARRAY_JOB_ID is $SLURM_ARRAY_JOB_ID."
echo "My SLURM_ARRAY_TASK_ID is $SLURM_ARRAY_TASK_ID"
echo "Executing on the machine:" $(hostname)

module purge
module load anaconda3/2021.11

python myscript.py
```

Below is the contents of `myscript.py`:

```python
import os
idx = int(os.environ["SLURM_ARRAY_TASK_ID"])
parameters = [0, 10, 20]
myparam = parameters[idx]
print(f"INFO: Job with array task id {idx} is using myparam={myparam}")
with open(f"output_taskid_{idx}_myparam_{myparam}.out", "w") as f:
    msg = f"Output file for task id {idx} using myparam={myparam}\n"
    f.write(msg)
```

Run the job by executing these commands:

```
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
$ cd hpc_beginning_workshop/job_array/python
$ sbatch job.slurm
```

This will produce the following files:

```bash
$ ls -l
total 36K
-rw-r--r--. 1 aturing cses 1.5K Mar 11 09:50 README.md
-rw-r--r--. 1 aturing cses  803 Mar 11 09:50 job.slurm
-rw-r--r--. 1 aturing cses  329 Mar 11 10:12 myscript.py
-rw-r--r--. 1 aturing cses    0 Mar 11 10:13 slurm-1308787.0.err
-rw-r--r--. 1 aturing cses    0 Mar 11 10:13 slurm-1308787.1.err
-rw-r--r--. 1 aturing cses   41 Mar 11 10:13 output_taskid_0_myparam_0.out
-rw-r--r--. 1 aturing cses  148 Mar 11 10:13 slurm-1308787.0.out
-rw-r--r--. 1 aturing cses    0 Mar 11 10:13 slurm-1308787.2.err
-rw-r--r--. 1 aturing cses   42 Mar 11 10:13 output_taskid_1_myparam_10.out
-rw-r--r--. 1 aturing cses  149 Mar 11 10:13 slurm-1308787.1.out
-rw-r--r--. 1 aturing cses   42 Mar 11 10:13 output_taskid_2_myparam_20.out
-rw-r--r--. 1 aturing cses  149 Mar 11 10:13 slurm-1308787.2.out
```

(**Note:** .err files will be generated even if nothing is written to them - this does not mean you had errors!)

Here are the contents of the Slurm output files:

```
$ cat slurm-1308787.0.out
My SLURM_ARRAY_JOB_ID is 1308787.
My SLURM_ARRAY_TASK_ID is 0
Executing on the machine: adroit-14
INFO: Job with array task id 0 is using myparam=0

$ cat slurm-1308787.1.out
My SLURM_ARRAY_JOB_ID is 1308787.
My SLURM_ARRAY_TASK_ID is 1
Executing on the machine: adroit-12
INFO: Job with array task id 1 is using myparam=10

$ cat slurm-1308787.2.out
My SLURM_ARRAY_JOB_ID is 1308787.
My SLURM_ARRAY_TASK_ID is 2
Executing on the machine: adroit-12
INFO: Job with array task id 2 is using myparam=20
```

Here are the contents of the output files:

```bash
$ cat output_taskid_0_myparam_0.out
Output file for task id 0 using myparam=0

$ cat output_taskid_1_myparam_10.out
Output file for task id 1 using myparam=10

$ cat output_taskid_2_myparam_20.out
Output file for task id 2 using myparam=20
```

For more on job arrays, see the [RC Slurm page](https://researchcomputing.princeton.edu/support/knowledge-base/slurm#arrays).
