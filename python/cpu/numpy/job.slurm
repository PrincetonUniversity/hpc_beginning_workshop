#!/bin/bash
#SBATCH --job-name=py-svd        # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=6G         # memory per cpu-core
#SBATCH --time=00:01:00          # total run time limit (HH:MM:SS)

hostname
lscpu | grep "Model name"

module purge
module load anaconda3/2024.6

python svd_np.py
