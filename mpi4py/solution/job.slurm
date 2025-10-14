#!/bin/bash
#SBATCH --job-name=mpi4py-ex        # create a name for your job
#SBATCH --nodes=2                   # node count
#SBATCH --ntasks-per-node=1         # total number of tasks
#SBATCH --cpus-per-task=1           # cpu-cores per task
#SBATCH --mem-per-cpu=1G            # memory per cpu-core
#SBATCH --time=00:01:00             # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail  # receive email notifications

module purge
module load anaconda3/2025.6
module load openmpi/gcc/4.1.6
conda activate fast-mpi4py

srun python send_recv.py
