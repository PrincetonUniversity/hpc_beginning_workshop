import os
import time

import ray

num_cpus = int(os.getenv('SLURM_CPUS_PER_TASK'))
ray.init(num_cpus=num_cpus)  # or ray.init(address="auto") on a cluster

@ray.remote
def f(x):
    return x * x

futures = [f.remote(i) for i in range(4)]
start = time.time()
print(ray.get(futures))
print(f"Elapsed time: {time.time() - start:.2f} seconds")