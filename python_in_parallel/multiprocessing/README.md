# Python Multiprocessing

The [multiprocessing](https://docs.python.org/3/library/multiprocessing.html) module provides a way to run multiple Python processes to solve a problem in parallel.

Here is a sample Python script that uses `multiprocessing`. The list of elements passed to the pmap function is divided across the CPU-cores and execute  in parallel.

```python
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
module load anaconda3/2026.7

srun python myscript.py
```

Run the commands below to execute the sample code:

```
$ cat myscript.py
# use a text editor to enter your email address in job.slurm
$ sbatch job.slurm
```

One advantage to Python `multiprocessing` over [job arrays](https://researchcomputing.princeton.edu/support/knowledge-base/slurm#arrays) is that the output of the different parallel operations can be reduced within the Python script. When job arrays are used the reduction must be done in a separate step.

CPython (the standard Python interpreter) has a Global Interpreter Lock (GIL) that only lets one thread execute Python bytecode at a time. This doesn't mean Python can't use threads — it can, and threads are useful for I/O-bound work or for C extensions like NumPy that release the GIL — but it does mean threads alone won't speed up CPU-bound pure-Python code. Python `multiprocessing` sidesteps the GIL by running a separate Python process, each with its own interpreter, on each CPU-core. The choice of `--cpus-per-task=4` here leads to 4 independent Python processes rather than 4 threads sharing one. (CPython 3.13+ also ships an experimental GIL-free build per [PEP 703](https://peps.python.org/pep-0703/), but it isn't the default yet.)

In the example above, the function `f(x)` is trivial. Python `multiprocessing` becomes useful when `f(x)` is expensive.

For more info see [this page](https://researchcomputing.princeton.edu/support/knowledge-base/python#multiprocessing).
