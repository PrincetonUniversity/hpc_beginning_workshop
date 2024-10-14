# Multi-threaded NumPy

Let's look at what is possible with NumPy on a CPU with 10's of cores. NumPy on our HPC clusters is built against the Intel Math Kernel library (MKL). This means that several [common numerical routines](https://numpy.org/devdocs/reference/routines.linalg.html?highlight=multithreading) can take advantage of multi-threading.

To see how NumPy was built, run the following commands:

```
$ module load anaconda3/2024.6
$ python -c "import numpy; print(numpy.show_config())"
Build Dependencies:
  blas:
    detection method: pkgconfig
    found: true
    include directory: /usr/licensed/anaconda3/2024.6/include
    lib directory: /usr/licensed/anaconda3/2024.6/lib
    name: mkl-sdl
    openblas configuration: unknown
    pc file directory: /usr/licensed/anaconda3/2024.6/lib/pkgconfig
    version: '2023.1'
  lapack:
    detection method: internal
    found: true
    include directory: unknown
    lib directory: unknown
    name: dep140137493227056
    openblas configuration: unknown
    pc file directory: unknown
    version: 1.26.4
Compilers:
  c:
    args: -march=nocona, -mtune=haswell, -ftree-vectorize, -fPIC, -fstack-protector-strong,
      -fno-plt, -O2, -ffunction-sections, -pipe, -isystem, /usr/licensed/anaconda3/2024.6/include,
      -fdebug-prefix-map=/croot/numpy_and_numpy_base_1708638617955/work=/usr/local/src/conda/numpy-base-1.26.4,
      -fdebug-prefix-map=/usr/licensed/anaconda3/2024.6=/usr/local/src/conda-prefix,
      -DNDEBUG, -D_FORTIFY_SOURCE=2, -O2, -isystem, /usr/licensed/anaconda3/2024.6/include
    commands: /croot/numpy_and_numpy_base_1708638617955/_build_env/bin/x86_64-conda-linux-gnu-cc
    linker: ld.bfd
    linker args: -Wl,-O2, -Wl,--sort-common, -Wl,--as-needed, -Wl,-z,relro, -Wl,-z,now,
      -Wl,--disable-new-dtags, -Wl,--gc-sections, -Wl,-rpath,/usr/licensed/anaconda3/2024.6/lib,
      -Wl,-rpath-link,/usr/licensed/anaconda3/2024.6/lib, -L/usr/licensed/anaconda3/2024.6/lib,
      -march=nocona, -mtune=haswell, -ftree-vectorize, -fPIC, -fstack-protector-strong,
      -fno-plt, -O2, -ffunction-sections, -pipe, -isystem, /usr/licensed/anaconda3/2024.6/include,
      -fdebug-prefix-map=/croot/numpy_and_numpy_base_1708638617955/work=/usr/local/src/conda/numpy-base-1.26.4,
      -fdebug-prefix-map=/usr/licensed/anaconda3/2024.6=/usr/local/src/conda-prefix,
      -DNDEBUG, -D_FORTIFY_SOURCE=2, -O2, -isystem, /usr/licensed/anaconda3/2024.6/include
    name: gcc
    version: 11.2.0
  c++:
    args: -fvisibility-inlines-hidden, -std=c++17, -fmessage-length=0, -march=nocona,
      -mtune=haswell, -ftree-vectorize, -fPIC, -fstack-protector-strong, -fno-plt,
      -O2, -ffunction-sections, -pipe, -isystem, /usr/licensed/anaconda3/2024.6/include,
      -fdebug-prefix-map=/croot/numpy_and_numpy_base_1708638617955/work=/usr/local/src/conda/numpy-base-1.26.4,
      -fdebug-prefix-map=/usr/licensed/anaconda3/2024.6=/usr/local/src/conda-prefix,
      -DNDEBUG, -D_FORTIFY_SOURCE=2, -O2, -isystem, /usr/licensed/anaconda3/2024.6/include
    commands: /croot/numpy_and_numpy_base_1708638617955/_build_env/bin/x86_64-conda-linux-gnu-c++
    linker: ld.bfd
    linker args: -Wl,-O2, -Wl,--sort-common, -Wl,--as-needed, -Wl,-z,relro, -Wl,-z,now,
      -Wl,--disable-new-dtags, -Wl,--gc-sections, -Wl,-rpath,/usr/licensed/anaconda3/2024.6/lib,
      -Wl,-rpath-link,/usr/licensed/anaconda3/2024.6/lib, -L/usr/licensed/anaconda3/2024.6/lib,
      -fvisibility-inlines-hidden, -std=c++17, -fmessage-length=0, -march=nocona,
      -mtune=haswell, -ftree-vectorize, -fPIC, -fstack-protector-strong, -fno-plt,
      -O2, -ffunction-sections, -pipe, -isystem, /usr/licensed/anaconda3/2024.6/include,
      -fdebug-prefix-map=/croot/numpy_and_numpy_base_1708638617955/work=/usr/local/src/conda/numpy-base-1.26.4,
      -fdebug-prefix-map=/usr/licensed/anaconda3/2024.6=/usr/local/src/conda-prefix,
      -DNDEBUG, -D_FORTIFY_SOURCE=2, -O2, -isystem, /usr/licensed/anaconda3/2024.6/include
    name: gcc
    version: 11.2.0
  cython:
    commands: cython
    linker: cython
    name: cython
    version: 3.0.8
Machine Information:
  build:
    cpu: x86_64
    endian: little
    family: x86_64
    system: linux
  host:
    cpu: x86_64
    endian: little
    family: x86_64
    system: linux
Python Information:
  path: /usr/licensed/anaconda3/2024.6/bin/python
  version: '3.12'
SIMD Extensions:
  baseline:
  - SSE
  - SSE2
  - SSE3
  found:
  - SSSE3
  - SSE41
  - POPCNT
  - SSE42
  - AVX
  - F16C
  - FMA3
  - AVX2
  - AVX512F
  - AVX512CD
  - AVX512_SKX
  - AVX512_CLX
  not found:
  - AVX512_KNL
  - AVX512_KNM
  - AVX512_CNL
  - AVX512_ICL

None
```

Load the `mkl` module to determine the maximum number of threads:

```
(base) $ python
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

N = 3000
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

module purge
module load anaconda3/2024.6

python svd_np.py
```

Step-by-step directions:

```
$ ssh <YourNetID>@adroit.princeton.edu
$ cd /scratch/network/<YourNetID>
$ git clone https://github.com/PrincetonUniversity/hpc_beginning_workshop.git
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

You can also run on the login node:

```
(base) $ env OMP_NUM_THREADS=1 /usr/bin/time -f %e python -c "import numpy as np; np.linalg.svd(np.random.randn(3000, 3000))"
12.27
(base) $ env OMP_NUM_THREADS=2 /usr/bin/time -f %e python -c "import numpy as np; np.linalg.svd(np.random.randn(3000, 3000))"
6.87
```

Run jobs to fill in the table below:

| cpus-per-task (or threads)| execution time (s) |
|:--------------------------:|:--------:|
| 1                          |   5.2    |
| 7                          |          |
| 14                         |          |
| 28                         |          |

The following data was found using one of the older Skylake nodes on Adroit with N=2000:

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
