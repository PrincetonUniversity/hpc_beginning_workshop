#!/bin/bash
#SBATCH --job-name=multiGPUtest  # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=2               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --gres=gpu:2             # number of gpus per node
#SBATCH --time=00:00:30          # total run time limit (HH:MM:SS)

module purge
module load nvhpc/24.3 openmpi/cuda-12.3/nvhpc-24.3/4.1.6 cudatoolkit/12.3

srun ./direct.out
