import os
import random
import time

import ray

num_cpus = int(os.getenv('SLURM_CPUS_PER_TASK'))
ray.init(num_cpus=num_cpus)  # or ray.init(address="auto") on a cluster

@ray.remote
def costly_simulation(x):
    time.sleep(random.random())
    return x * x

futures = [costly_simulation.remote(i) for i in range(20)]
start = time.time()
print(ray.get(futures))
print(f"Elapsed time: {time.time() - start:.2f} seconds")