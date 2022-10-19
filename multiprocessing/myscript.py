import os
from multiprocessing import Pool

def f(x):
  return x*x

if __name__ == '__main__':
  num_cores = int(os.getenv('SLURM_CPUS_PER_TASK'))
  with Pool(num_cores) as p:
    print(p.map(f, [1, 2, 3, 4, 5, 6, 7, 8]))
