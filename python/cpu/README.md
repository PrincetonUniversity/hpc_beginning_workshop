# Serial Python Script

Here is a simple Python script:

```python
import numpy as np
N = 3
X = np.random.randn(N, N)
print("X =\n", X)
print("Inverse(X) =\n", np.linalg.inv(X))
```

Below is the Slurm script:

```bash
#!/bin/bash
#SBATCH --job-name=matinv           # create a short name for your job
#SBATCH --nodes=1                   # node count
#SBATCH --ntasks=1                  # total number of tasks across all nodes
#SBATCH --cpus-per-task=1           # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=4G            # memory per cpu-core (4G is default)
#SBATCH --time=00:01:00             # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail  # receive email notifications
#SBATCH --mail-user=<YourNetID>@princeton.edu

module purge
module load anaconda3/2025.6

python matrix_inverse.py
```

To run the Python script, simply submit the job to the cluster:

```
$ sbatch job.slurm
```

After the job completes, view the output with `cat slurm-*`:

```
X =
 [[ 1.34903552  0.67843791 -0.43574188]
 [ 1.60554068  0.66067333 -0.38373032]
 [-1.54970008  1.28489254  0.14557173]]
Inverse(X) =
 [[ -1.93014233   2.15752707  -0.09023234]
 [ -1.18235524   1.56870044   0.59596897]
 [-10.11145687   9.12202091   0.64855209]]
```

Use `squeue -u $USER` to monitor queued jobs.

# Introduction to Errors
 
Getting used to the types of errors you may encounter while submitting jobs is important. Here's how to force some of them to occur:
 
- In the slurm script, introduce a typo by changing `python` to `pythn` and observe the syntax error
- Undo the above, and next change N to 15000 in `matrix_inverse.py` and you'll encounter an error for running out of time
- Then update time in the slurm script to `00:05:00` and you'll encounter an error for running out of memory
- Finally, change `mem-per-cpu` to 8G and you'll have a successful run with some interesting stats


# Guide

For more on working with Python see [this page](https://researchcomputing.princeton.edu/support/knowledge-base/python).
