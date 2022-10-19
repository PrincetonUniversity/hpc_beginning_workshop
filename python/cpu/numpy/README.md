# Multi-threaded NumPy

Before writing code to harness the power of 1000's of GPU cores, let's look at what is possible with NumPy on a CPU with 10's of cores. NumPy on our HPC clusters is built against the Intel Math Kernel library (MKL). This means that several [common numerical routines](https://numpy.org/devdocs/reference/routines.linalg.html?highlight=multithreading) can take advantage of multi-threading.

To see how NumPy was built, run the following commands:

```
$ module load anaconda3/2022.5
$ python
>>> import numpy as np
>>> np.show_config()
mkl_info:
    libraries = ['mkl_rt', 'pthread']
    library_dirs = ['/usr/licensed/anaconda3/2019.3/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/usr/licensed/anaconda3/2019.3/include']
blas_mkl_info:
    libraries = ['mkl_rt', 'pthread']
    library_dirs = ['/usr/licensed/anaconda3/2019.3/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/usr/licensed/anaconda3/2019.3/include']
blas_opt_info:
    libraries = ['mkl_rt', 'pthread']
    library_dirs = ['/usr/licensed/anaconda3/2019.3/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/usr/licensed/anaconda3/2019.3/include']
lapack_mkl_info:
    libraries = ['mkl_rt', 'pthread']
    library_dirs = ['/usr/licensed/anaconda3/2019.3/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/usr/licensed/anaconda3/2019.3/include']
lapack_opt_info:
    libraries = ['mkl_rt', 'pthread']
    library_dirs = ['/usr/licensed/anaconda3/2019.3/lib']
    define_macros = [('SCIPY_MKL_H', None), ('HAVE_CBLAS', None)]
    include_dirs = ['/usr/licensed/anaconda3/2019.3/include']
```

Load the `mkl` module to determine the maximum number of threads:

```
>>> import mkl
>>> mkl.get_max_threads()
32
```

This is on the head node.

### Hands-On Exercise

Try running the code below and vary the value of `--cpus-per-task` to fill in the data in the table below:

```python
import os
num_threads = int(os.environ['SLURM_CPUS_PER_TASK'])

import mkl
mkl.set_num_threads(num_threads)

N = 2000
num_runs = 5

import numpy as np
np.random.seed(42)

from time import perf_counter
x = np.random.randn(N, N).astype(np.float64)
times = []
for _ in range(num_runs):
  t0 = perf_counter()
  u, s, vh = np.linalg.svd(x)
  elapsed_time = perf_counter() - t0
  times.append(elapsed_time)

print("execution time: ", min(times))
print("cpus-per-task (or threads): ", num_threads)
print("trace(s): ", s.sum())
```

Here is an appropriate Slurm script:

```
#!/bin/bash
#SBATCH --job-name=py-svd        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)

hostname
lscpu | grep "Model name"

module load anaconda3/2022.5

srun python svd_np.py
```

Step-by-step directions:

```
$ cd /hpc_beginning_workshop/python/cpu/numpy

# modify job.slurm by setting --cpus-per-task=2
$ sbatch job.slurm
# view the output file and note the execution time

# modify job.slurm by setting --cpus-per-task=4
$ sbatch job.slurm
# view the output file and note the execution time

# modify job.slurm by setting --cpus-per-task=8
$ sbatch job.slurm
# view the output file and note the execution time
```
<!--
Run jobs to fill in the table below:

| cpus-per-task (or threads)| execution time (s) |
|:--------------------------:|:--------:|
| 1                          |  4.2     |
| 2                          |          |
| 4                          |          |
| 8                          |          |
| 16                         |          |
| 32                         |          |
-->

The following data was found using one of the Skylake nodes on Adroit:

| cpus-per-task (or threads)| execution time (s) | speed-up ratio |  parallel efficiency |
|:--------------------------:|:--------:|:---------:|:-------------------:|
| 1                          |  4.2     |     1.0   |   100%              |
| 2                          |  2.2     |   1.9     |   95%               | 
| 4                          |  1.6     |   2.6     |   66%               |
| 8                          |  0.78    |   5.4     |   67%               |
| 16                         |  0.65    |   6.5     |   40%               |
| 32                         |  0.71    |   5.9     |   18%               |

Given the data above, which value of cpus-per-task should be used? Clearly using all 32 cores is not optimal. When 16 cores are used the execution time is minimized but the parallel efficiency is poor. Maybe the best choice is 8. Note that the parallel efficiency is measured relative to the serial case. That is, for cpus-per-task=2, we have 4.2 / (2.2 * 2) = 0.95.

We see that by dividing the computation across several threads, which run on the CPU-cores, the execution time is dramatically reduced. The same can be done with GPUs which have 1000's of cores.
