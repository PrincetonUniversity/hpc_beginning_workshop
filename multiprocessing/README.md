# Python Multiprocessing

The multiprocessing module provides a way to run multiple Python processes to solve a problem in parallel.

Here is a sample Python script that uses `multiprocessing`. The list of elements passed to the pmap function is divided across the CPU-cores and execute  in parallel.

```
import os
from multiprocessing import Pool

def f(x):
  return x*x

if __name__ == '__main__':
  num_cores = int(os.getenv('SLURM_CPUS_PER_TASK'))
  with Pool(num_cores) as p:
    print(p.map(f, [1, 2, 3, 4, 5, 6, 7, 8]))
```

Below is the Slurm script:

```
#!/bin/bash
#SBATCH --job-name=multipro      # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=4        # number of processes
#SBATCH --mem-per-cpu=4G         # memory per cpu-core (4G per cpu-core is default)
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)

module purge
module load anaconda3/2022.5

srun python myscript.py
```

Run the commands below to execute the sample code:

```
$ cat myscript.py
# use a text editor to enter your email address in job.slurm
$ sbatch job.slurm
```

For more info see [this page](https://researchcomputing.princeton.edu/support/knowledge-base/python#multiprocessing).
