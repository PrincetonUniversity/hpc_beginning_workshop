#!/bin/bash
#SBATCH --job-name=multiGPUtest  # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=2               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1G         # memory per cpu-core (4G is default)
#SBATCH --gres=gpu:2             # number of gpus per node
#SBATCH --time=00:00:30          # total run time limit (HH:MM:SS)
#SBATCH --reservation=hackathon  # name of reservation

module purge
module load intel/19.1/64/19.1.1.217 cudatoolkit/11.0 openmpi/cuda-10.2/intel-19.1

srun --gpus=2 --gpus-per-task=1 ./direct.out
