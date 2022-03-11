# Job Array

Consider the case of running 3 jobs within the array:

```
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

```
import os
idx = int(os.environ["SLURM_ARRAY_TASK_ID"])
parameters = [0, 10, 20]
myparam = parameters[idx]
print(f"Job with array task id {idx} is using myparam={myparam}")
with open(f"output_taskid_{idx}_myparam_{myparam}.out", "w") as f:
    f.write(myparam)
```

Run the job by executing these commands:

```
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
$ cd hpc_beginning_workshop/job_array/python
$ sbatch job.slurm
```

The Slurm out


The will produce three files:

```
$ ls -l
```

Here are the contents of the files:

```
$ cat
```
