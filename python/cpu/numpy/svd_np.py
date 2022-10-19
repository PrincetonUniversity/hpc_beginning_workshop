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
